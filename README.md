ObjectMapper
============
[![CocoaPods](https://img.shields.io/cocoapods/v/ObjectMapper.svg)](https://github.com/tristanhimmelman/ObjectMapper)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Swift Package Manager](https://rawgit.com/jlyonsmith/artwork/master/SwiftPackageManager/swiftpackagemanager-compatible.svg)](https://swift.org/package-manager/)
[![Build Status](https://travis-ci.org/tristanhimmelman/ObjectMapper.svg?branch=master)](https://travis-ci.org/tristanhimmelman/ObjectMapper)

ObjectMapper is a framework written in Swift that makes it easy for you to convert your model objects (classes and structs) to and from JSON. 

- [Features](#features)
- [The Basics](#the-basics)
- [Mapping Nested Objects](#easy-mapping-of-nested-objects)
- [Custom Transformations](#custom-transforms)
- [Subclassing](#subclasses)
- [Generic Objects](#generic-objects)
- [Mapping Context](#mapping-context)
- [ObjectMapper + Alamofire](#objectmapper--alamofire) 
- [ObjectMapper + Realm](#objectmapper--realm)
- [Projects using ObjectMapper](#projects-using-objectmapper)
- [To Do](#to-do)
- [Contributing](#contributing)
- [Installation](#installation)

# Features:
- Mapping JSON to objects
- Mapping objects to JSON
- Nested Objects (stand alone, in arrays or in dictionaries)
- Custom transformations during mapping
- Struct support
- [Immutable support](#immutablemappable-protocol)

# The Basics
To support mapping, a class or struct just needs to implement the ```Mappable``` protocol which includes the following functions:
```swift
init?(map: Map)
mutating func mapping(map: Map)
```
ObjectMapper uses the ```<-``` operator to define how each member variable maps to and from JSON.

```swift
class User: Mappable {
    var username: String?
    var age: Int?
    var weight: Double!
    var array: [Any]?
    var dictionary: [String : Any] = [:]
    var bestFriend: User?                       // Nested User object
    var friends: [User]?                        // Array of Users
    var birthday: Date?

    required init?(map: Map) {

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

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        celsius 	<- map["celsius"]
        fahrenheit 	<- map["fahrenheit"]
    }
}
```

Once your class implements `Mappable`, ObjectMapper allows you to easily convert to and from JSON. 

Convert a JSON string to a model object:
```swift
let user = User(JSONString: JSONString)
```

Convert a model object to a JSON string:
```swift
let JSONString = user.toJSONString(prettyPrint: true)
```

Alternatively, the `Mapper.swift` class can also be used to accomplish the above (it also provides extra functionality for other situations):
```swift
// Convert JSON String to Model
let user = Mapper<User>().map(JSONString: JSONString)
// Create JSON String from Model
let JSONString = Mapper().toJSONString(user, prettyPrint: true)
```

ObjectMapper can map classes composed of the following types:
- `Int`
- `Bool`
- `Double`
- `Float`
- `String`
- `RawRepresentable` (Enums)
- `Array<Any>`
- `Dictionary<String, Any>`
- `Object<T: Mappable>`
- `Array<T: Mappable>`
- `Array<Array<T: Mappable>>`
- `Set<T: Mappable>` 
- `Dictionary<String, T: Mappable>`
- `Dictionary<String, Array<T: Mappable>>`
- Optionals of all the above
- Implicitly Unwrapped Optionals of the above

## `Mappable` Protocol

#### `mutating func mapping(map: Map)` 
This function is where all mapping definitions should go. When parsing JSON, this function is executed after successful object creation. When generating JSON, it is the only function that is called on the object.

#### `init?(map: Map)` 
This failable initializer is used by ObjectMapper for object creation. It can be used by developers to validate JSON prior to object serialization. Returning nil within the function will prevent the mapping from occuring. You can inspect the JSON stored within the `Map` object to do your validation:
```swift
required init?(map: Map){
	// check if a required "name" property exists within the JSON.
	if map.JSON["name"] == nil {
		return nil
	}
}
```

## `StaticMappable` Protocol
`StaticMappable` is an alternative to `Mappable`. It provides developers with a static function that is used by ObjectMapper for object initialization instead of `init?(map: Map)`. 

Note: `StaticMappable`, like `Mappable`, is a sub protocol of `BaseMappable` which is where the `mapping(map: Map)` function is defined.

#### `static func objectForMapping(map: Map) -> BaseMappable?` 
ObjectMapper uses this function to get objects to use for mapping. Developers should return an instance of an object that conforms to `BaseMappable` in this function. This function can also be used to:
- validate JSON prior to object serialization
- provide an existing cached object to be used for mapping
- return an object of another type (which also conforms to `BaseMappable`) to be used for mapping. For instance, you may inspect the JSON to infer the type of object that should be used for mapping ([see examples in ClassClusterTests.swift](https://github.com/Hearst-DD/ObjectMapper/blob/master/Tests/ObjectMapperTests/ClassClusterTests.swift#L67))

If you need to implement ObjectMapper in an extension, you will need to adopt this protocol instead of `Mappable`. 

## `ImmutableMappable` Protocol

`ImmutableMappable` provides the ability to map immutable properties. This is how `ImmutableMappable` differs from `Mappable`:

<table>
  <tr>
    <th>ImmutableMappable</th>
    <th>Mappable</th>
  </tr>
  <tr>
    <th colspan="2">Properties</th>
  </tr>
  <tr>
    <td>
<pre>
<strong>let</strong> id: Int
<strong>let</strong> name: String?
</pre>
  </td>
    <td>
<pre>
var id: Int!
var name: String?
</pre>
    </td>
  </tr>
  <tr>
    <th colspan="2">JSON -> Model</th>
  </tr>
  <tr>
    <td>
<pre>
init(map: Map) <strong>throws</strong> {
  id   = <strong>try</strong> map.value("id")
  name = <strong>try?</strong> map.value("name")
}
</pre>
  </td>
    <td>
<pre>
mutating func mapping(map: Map) {
  id   <- map["id"]
  name <- map["name"]
}
</pre>
    </td>
  </tr>
  <tr>
    <th colspan="2">Model -> JSON</th>
  </tr>
  <tr>
    <td>
<pre>
func mapping(map: Map) {
  id   <strong>>>></strong> map["id"]
  name <strong>>>></strong> map["name"]
}
</pre>
    </td>
    <td>
<pre>
mutating func mapping(map: Map) {
  id   <- map["id"]
  name <- map["name"]
}
</pre>
    </td>
  </tr>
  <tr>
    <th colspan="2">Initializing</th>
  </tr>
  <tr>
    <td>
<pre>
<strong>try</strong> User(JSONString: JSONString)
</pre>
    </td>
    <td>
<pre>
User(JSONString: JSONString)
</pre>
    </td>
  </tr>
</table>

#### `init(map: Map) throws`

This throwable initializer is used to map immutable properties from the given `Map`. Every immutable property should be initialized in this initializer.

This initializer throws an error when:
- `Map` fails to get a value for the given key
- `Map` fails to transform a value using `Transform`

`ImmutableMappable` uses `Map.value(_:using:)` method to get values from the `Map`. This method should be used with the `try` keyword as it is throwable. `Optional` properties can easily be handled using `try?`.

```swift
init(map: Map) throws {
    name      = try map.value("name") // throws an error when it fails
    createdAt = try map.value("createdAt", using: DateTransform()) // throws an error when it fails
    updatedAt = try? map.value("updatedAt", using: DateTransform()) // optional
    posts     = (try? map.value("posts")) ?? [] // optional + default value
}
```

#### `mutating func mapping(map: Map)`

This method is where the reverse transform is performed (model to JSON). Since immutable properties cannot be mapped with the `<-` operator, developers have to define the reverse transform using the `>>>` operator.

```swift
mutating func mapping(map: Map) {
    name      >>> map["name"]
    createdAt >>> (map["createdAt"], DateTransform())
    updatedAt >>> (map["updatedAt"], DateTransform())
    posts     >>> map["posts"]
}
```

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
```swift
distance <- map["distances.0.value"]
```
If you have a key that contains `.`, you can individually disable the above feature as follows:
```swift
func mapping(map: Map) {
    identifier <- map["app.identifier", nested: false]
}
```
When you have nested keys which contain `.`, you can pass the custom nested key delimiter as follows ([#629](https://github.com/tristanhimmelman/ObjectMapper/pull/629)):
```swift
func mapping(map: Map) {
    appName <- map["com.myapp.info->com.myapp.name", delimiter: "->"]
}
```

# Custom Transforms
ObjectMapper also supports custom transforms that convert values during the mapping process. To use a transform, simply create a tuple with `map["field_name"]` and the transform of your choice on the right side of the `<-` operator:
```swift
birthday <- (map["birthday"], DateTransform())
```
The above transform will convert the JSON Int value to an Date when reading JSON and will convert the Date to an Int when converting objects to JSON.

You can easily create your own custom transforms by adopting and implementing the methods in the `TransformType` protocol:
```swift
public protocol TransformType {
    associatedtype Object
    associatedtype JSON

    func transformFromJSON(_ value: Any?) -> Object?
    func transformToJSON(_ value: Object?) -> JSON?
}
```

### TransformOf
In a lot of situations you can use the built-in transform class `TransformOf` to quickly perform a desired transformation. `TransformOf` is initialized with two types and two closures. The types define what the transform is converting to and from and the closures perform the actual transformation. 

For example, if you want to transform a JSON `String` value to an `Int` you could use `TransformOf` as follows:
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

Classes that implement the `Mappable` protocol can easily be subclassed. When subclassing mappable classes, follow the structure below:

```swift
class Base: Mappable {
	var base: String?
	
	required init?(map: Map) {

	}

	func mapping(map: Map) {
		base <- map["base"]
	}
}

class Subclass: Base {
	var sub: String?

	required init?(map: Map) {
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

    required init?(map: Map){

    }

    func mapping(map: Map) {
        result <- map["result"]
    }
}

let result = Mapper<Result<User>>().map(JSON)
```

# Mapping Context

The `Map` object which is passed around during mapping, has an optional `MapContext` object that is available for developers to use if they need to pass information around during mapping. 

To take advantage of this feature, simply create an object that implements `MapContext` (which is an empty protocol) and pass it into `Mapper` during initialization. 
```swift
struct Context: MapContext {
	var importantMappingInfo = "Info that I need during mapping"
}

class User: Mappable {
	var name: String?
	
	required init?(map: Map){
	
	}
	
	func mapping(map: Map){
		if let context = map.context as? Context {
			// use context to make decisions about mapping
		}
	}
}

let context = Context()
let user = Mapper<User>(context: context).map(JSONString)
```

# ObjectMapper + Alamofire

If you are using [Alamofire](https://github.com/Alamofire/Alamofire) for networking and you want to convert your responses to Swift objects, you can use [AlamofireObjectMapper](https://github.com/tristanhimmelman/AlamofireObjectMapper). It is a simple Alamofire extension that uses ObjectMapper to automatically map JSON response data to Swift objects.


# ObjectMapper + Realm

ObjectMapper and Realm can be used together. Simply follow the class structure below and you will be able to use ObjectMapper to generate your Realm models:

```swift
class Model: Object, Mappable {
	dynamic var name = ""

	required convenience init?(map: Map) {
		self.init()
	}

	func mapping(map: Map) {
		name <- map["name"]
	}
}
```

If you want to serialize associated RealmObjects, you can use [ObjectMapper+Realm](https://github.com/jakenberg/ObjectMapper-Realm). It is a simple Realm extension that serializes arbitrary JSON into Realm's `List` class.

To serialize Swift `String`, `Int`, `Double` and `Bool` arrays you can use [ObjectMapperAdditions/Realm](https://github.com/APUtils/ObjectMapperAdditions#realm-features). It'll wrap Swift types into RealmValues that can be stored in Realm's `List` class.

Note: Generating a JSON string of a Realm Object using ObjectMappers' `toJSON` function only works within a Realm write transaction. This is because ObjectMapper uses the `inout` flag in its mapping functions (`<-`) which are used both for serializing and deserializing. Realm detects the flag and forces the `toJSON` function to be called within a write block even though the objects are not being modified.

# Projects Using ObjectMapper
- [Xcode Plugin for generating `Mappable` and `ImmutableMappable` code](https://github.com/liyanhuadev/ObjectMapper-Plugin)

- [Json4Swift - Supports generating `ImmutableMappable` structs online (no plugins needed)](http://www.json4swift.com)

If you have a project that utilizes, extends or provides tooling for ObjectMapper, please submit a PR with a link to your project in this section of the README.

# To Do
- Improve error handling. Perhaps using `throws`
- Class cluster documentation

# Contributing

Contributions are very welcome 👍😃. 

Before submitting any pull request, please ensure you have run the included tests and they have passed. If you are including new functionality, please write test cases for it as well.

# Installation
### Cocoapods
ObjectMapper can be added to your project using [CocoaPods 0.36 or later](http://blog.cocoapods.org/Pod-Authors-Guide-to-CocoaPods-Frameworks/) by adding the following line to your `Podfile`:

```ruby
pod 'ObjectMapper', '~> 3.4'
```

### Carthage
If you're using [Carthage](https://github.com/Carthage/Carthage) you can add a dependency on ObjectMapper by adding it to your `Cartfile`:

```
github "tristanhimmelman/ObjectMapper" ~> 3.4
```

### Swift Package Manager
To add ObjectMapper to a [Swift Package Manager](https://swift.org/package-manager/) based project, add:

```swift
.Package(url: "https://github.com/tristanhimmelman/ObjectMapper.git", majorVersion: 3, minor: 4),
```
to your `Package.swift` files `dependencies` array.

### Submodule
Otherwise, ObjectMapper can be added as a submodule:

1. Add ObjectMapper as a [submodule](http://git-scm.com/docs/git-submodule) by opening the terminal, `cd`-ing into your top-level project directory, and entering the command `git submodule add https://github.com/tristanhimmelman/ObjectMapper.git`
2. Open the `ObjectMapper` folder, and drag `ObjectMapper.xcodeproj` into the file navigator of your app project.
3. In Xcode, navigate to the target configuration window by clicking on the blue project icon, and selecting the application target under the "Targets" heading in the sidebar.
4. Ensure that the deployment target of `ObjectMapper.framework` matches that of the application target.
5. In the tab bar at the top of that window, open the "Build Phases" panel.
6. Expand the "Target Dependencies" group, and add `ObjectMapper.framework`.
7. Click on the `+` button at the top left of the panel and select "New Copy Files Phase". Rename this new phase to "Copy Frameworks", set the "Destination" to "Frameworks", and add `ObjectMapper.framework`.
