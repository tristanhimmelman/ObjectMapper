ObjectMapper
============
[![CocoaPods](https://img.shields.io/cocoapods/v/ObjectMapper.svg)](https://github.com/Hearst-DD/ObjectMapper)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Build Status](https://travis-ci.org/Hearst-DD/ObjectMapper.svg?branch=master)](https://travis-ci.org/Hearst-DD/ObjectMapper)

ObjectMapper is a framework written in Swift that makes it easy for you to convert your model objects (classes and structs) to and from JSON. 

- [Features](#features)
- [The Basics](#the-basics)
- [Mapping Nested Objects](#easy-mapping-of-nested-objects)
- [Custom Transformations](#custom-transfoms)
- [Subclassing](#subclasses)
- [Generic Objects](#generic-objects)
- [ObjectMapper + Alamofire](#objectmapper--alamofire) 
- [ObjectMapper + Realm](#objectmapper--realm)
- [Contributing](#contributing)
- [Installation](#installation)

# Features:
- Mapping JSON to objects
- Mapping objects to JSON
- Nested Objects (stand alone, in arrays or in dictionaries)
- Custom transformations during mapping
- Struct support

# The Basics
To support mapping, a class or struct just needs to implement the ```Mappable``` protocol.
```swift
public protocol Mappable {
	init?(_ map: Map)
    mutating func mapping(map: Map)
}
```
ObjectMapper uses the ```<-``` operator to define how each member variable maps to and from JSON.

```swift
class User: Mappable {
    var username: String?
    var age: Int?
    var weight: Double!
    var array: [AnyObject]?
    var dictionary: [String : AnyObject] = [:]
    var bestFriend: User?                       // Nested User object
    var friends: [User]?                        // Array of Users
    var birthday: NSDate?

	required init?(_ map: Map) {

	}

    // Mappable
    func mapping(map: Map) {
        username    <- map["username"]
        age         <- map["age"]
        weight      <- map["weight"]
        array       <- map["arr"]
        dictionary  <- map["dict"]
        bestFriend  <- map["best_friend"]
        friends     <- map["friends"]
        birthday    <- (map["birthday"], DateTransform())
    }
}

struct Temperature: Mappable {
    var celsius: Double?
    var fahrenheit: Double?

    init?(_ map: Map) {

    }

    mutating func mapping(map: Map) {
        celsius 	<- map["celsius"]
        fahrenheit 	<- map["fahrenheit"]
    }
}
```

Once your class implements `Mappable`, the Mapper class handles everything else for you:

Convert a JSON string to a model object:
```swift
let user = Mapper<User>().map(JSONString)
```

Convert a model object to a JSON string:
```swift
let JSONString = Mapper().toJSONString(user, prettyPrint: true)
```

ObjectMapper can map classes composed of the following types:
- Int
- Bool
- Double
- Float
- String
- RawRepresentable (Enums)
- Array\<AnyObject\>
- Dictionary\<String, AnyObject\>
- Object\<T: Mappable\>
- Array\<T: Mappable\>
- Array\<Array\<T: Mappable\>\>
- Set\<T: Mappable\> 
- Dictionary\<String, T: Mappable\>
- Dictionary\<String, Array\<T: Mappable\>\>
- Optionals of all the above
- Implicitly Unwrapped Optionals of the above

# Easy Mapping of Nested Objects
ObjectMapper supports dot notation within keys for easy mapping of nested objects. Given the following JSON String:
```json
"distance" : {
     "text" : "102 ft",
     "value" : 31
}
```
You can access the nested objects as follows:
```swift
func mapping(map: Map) {
    distance <- map["distance.value"]
}
```
Nested keys also support accessing values from an array. Given a JSON response with an array of distances, the value could be accessed as follows:
```
distance <- map["distances.0.value"]
```
If you have a key that contains `.`, you can individually disable the above feature as follows:
```swift
func mapping(map: Map) {
    identifier <- map["app.identifier", nested: false]
}
```

# Custom Transforms
ObjectMapper also supports custom transforms that convert values during the mapping process. To use a transform, simply create a tuple with ```map["field_name"]``` and the transform of your choice on the right side of the ```<-``` operator:
```swift
birthday <- (map["birthday"], DateTransform())
```
The above transform will convert the JSON Int value to an NSDate when reading JSON and will convert the NSDate to an Int when converting objects to JSON.

You can easily create your own custom transforms by adopting and implementing the methods in the ```TransformType``` protocol:
```swift
public protocol TransformType {
    typealias Object
    typealias JSON

    func transformFromJSON(value: AnyObject?) -> Object?
    func transformToJSON(value: Object?) -> JSON?
}
```

### TransformOf
In a lot of situations you can use the built-in transform class ```TransformOf``` to quickly perform a desired transformation. ```TransformOf``` is initialized with two types and two closures. The types define what the transform is converting to and from and the closures perform the actual transformation. 

For example, if you want to transform a JSON String value to an Int you could use ```TransformOf``` as follows:
```swift
let transform = TransformOf<Int, String>(fromJSON: { (value: String?) -> Int? in 
    // transform value from String? to Int?
    return Int(value!)
}, toJSON: { (value: Int?) -> String? in
    // transform value from Int? to String?
    if let value = value {
        return String(value)
    }
    return nil
})

id <- (map["id"], transform)
```
Here is a more condensed version of the above:
```swift
id <- (map["id"], TransformOf<Int, String>(fromJSON: { Int($0!) }, toJSON: { $0.map { String($0) } }))
```

# Subclasses

Classes that implement the ```Mappable``` protocol can easily be subclassed. When subclassing mappable classes, follow the structure below:

```swift
class Base: Mappable {
	var base: String?
	
	required init?(_ map: Map) {

	}

	func mapping(map: Map) {
		base <- map["base"]
	}
}

class Subclass: Base {
	var sub: String?

	required init?(_ map: Map) {
		super.init(map)
	}

	override func mapping(map: Map) {
		super.mapping(map)
		
		sub <- map["sub"]
	}
}
```

Make sure your subclass implemenation calls the right initializers and mapping functions to also apply the mappings from your superclass.

# Generic Objects

ObjectMapper can handle classes with generic types as long as the generic type also conforms to `Mappable`. See the following example:
```swift
class Result<T: Mappable>: Mappable {
    var result: T?

    required init?(_ map: Map){

    }

    func mapping(map: Map) {
        result <- map["result"]
    }
}

let result = Mapper<Result<User>>().map(JSON)
```
<!-- # Mapping Immutable Properties

Note: This is an experimental feature. Not all ObjectMapper functionality is guaranteed to work for immutable mappings.

If you have a class or struct whose properties are immutable (`let`) and want to map it using ObjectMapper, you can use the following approach.

In the failable initializer, assign values to your properties using the `valueOrFail()` function on the `map` object. Once all properties are set, check `isValid` to determine if the mapping succeeded for all properties. If `isValid` returns false, return `nil` to indicate that initialization failed.

```swift
class Model: Mappable {
    let name: String // Non-optional property

    required init?(_ map: Map) {
        name = map["name"].valueOrFail()

        if !map.isValid {
            return nil
        }
    }

    func mapping(map: Map) {
    }
}

if let model = Mapper<Model>().map(JSONString) {
    // Now we have valid model.
} else {
    // Something wrong...
}
``` -->

#ObjectMapper + Alamofire

If you are using [Alamofire](https://github.com/Alamofire/Alamofire) for networking and you want to convert your responses to Swift objects, you can use [AlamofireObjectMapper](https://github.com/tristanhimmelman/AlamofireObjectMapper). It is a simple Alamofire extension that uses ObjectMapper to automatically map JSON response data to Swift objects.


#ObjectMapper + Realm

ObjectMapper and Realm can be used together. Simply follow the class structure below and you will be able to use ObjectMapper to generate your Realm models:

```swift
class Model: Object, Mappable {
	dynamic var name = ""

	required convenience init?(_ map: Map) {
		self.init()
	}

	func mapping(map: Map) {
		name <- map["name"]
	}
}
```

Note: Generating a JSON string of a Realm Object using ObjectMappers' `toJSON` function only works within a Realm write transaction. This is caused because ObjectMapper uses the `inout` flag in its mapping functions (`<-`) which are used both for serializing and deserializing. Realm detects the flag and forces the `toJSON` function to be called within a write block even though the objects are not being modified.

<!-- ##To Do -->

# Contributing

Contributions are very welcome 👍😃. 

Before submitting any pull request, please ensure you have run the included tests and they have passed. If you are including new functionality, please write test cases for it as well.

# Installation
ObjectMapper can be added to your project using [CocoaPods 0.36 or later](http://blog.cocoapods.org/Pod-Authors-Guide-to-CocoaPods-Frameworks/) by adding the following line to your `Podfile`:

```ruby
pod 'ObjectMapper', '~> 1.1'
```

If you're using [Carthage](https://github.com/Carthage/Carthage) you can add a dependency on ObjectMapper by adding it to your `Cartfile`:
```
github "Hearst-DD/ObjectMapper" ~> 1.1
```

Otherwise, ObjectMapper can be added as a submodule:

1. Add ObjectMapper as a [submodule](http://git-scm.com/docs/git-submodule) by opening the terminal, `cd`-ing into your top-level project directory, and entering the command `git submodule add https://github.com/Hearst-DD/ObjectMapper.git`
2. Open the `ObjectMapper` folder, and drag `ObjectMapper.xcodeproj` into the file navigator of your app project.
3. In Xcode, navigate to the target configuration window by clicking on the blue project icon, and selecting the application target under the "Targets" heading in the sidebar.
4. Ensure that the deployment target of `ObjectMapper.framework` matches that of the application target.
5. In the tab bar at the top of that window, open the "Build Phases" panel.
6. Expand the "Target Dependencies" group, and add `ObjectMapper.framework`.
7. Click on the `+` button at the top left of the panel and select "New Copy Files Phase". Rename this new phase to "Copy Frameworks", set the "Destination" to "Frameworks", and add `ObjectMapper.framework`.
