ObjectMapper
============

ObjectMapper is a framework written in Swift that makes it easy for you to convert your Model objects (Classes and Structs) to and from JSON.
##Features:
- Mapping JSON to objects
- Mapping objects to JSON
- Nested Objects (stand alone, in Arrays or in Dictionaries)
- Custom transformations during mapping
- Struct support

##The Basics
To support mapping, a Class or Struct just needs to implement the ```Mappable``` protocol.
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
        mapping(map)
    }

    // Mappable
    func mapping(map: Map) {
        username    <- map["username"]
        age         <- map["age"]
        weight      <- map["weight"]
        arrary      <- map["arr"]
        dictionary  <- map["dict"]
        best_friend <- map["best_friend"]
        friends     <- map["friends"]
        birthday    <- (map["birthday"], DateTransform())
    }
}

struct Temperature: Mappable {
    var celcius: Double?
    var fahrenheit: Double?

    init(){}

    init?(_ map: Map) {
        mapping(map)
    }

	mutating func mapping(map: Map) {
		celcius 	<- map["celcius"]
		fahrenheit 	<- map["fahrenheit"]
	}
}
```

Once your class implements Mappable, the Mapper class handles everything else for you:

Convert a JSON string to a model object:
```swift
let user = Mapper<User>().map(string: JSONString)
```

Convert a model object to a JSON string:
```swift
let JSONString = Mapper().toJSONString(user)
```

Object mapper can map classes composed of the following types:
- Int
- Bool
- Double
- Float
- String
- Array\<AnyObject\>
- Dictionary\<String, AnyObject\>
- Object\<T: Mappable\>
- Array\<T: Mappable\>
- Dictionary\<String, T: Mappable\>
- Optionals of all the above
- Implicitly Unwrapped Optionals of the above

##Easy Mapping of Nested Objects
ObjectMapper supports dot notation within keys for easy mapping of nested objects. Given the following JSON String:
```
"distance" : {
     "text" : "102 ft",
     "value" : 31
}
```
You can access the nested objects as follows:
```
func mapping(map: Map){
    distance <- map["distance.value"]
}
```

##Custom Transfoms
ObjectMapper also supports custom Transforms that convert values during the mapping process. To use a transform, simply create a tuple with ```map["field_name"]``` and the transform of choice on the right side of the ```<-``` operator:
```swift
birthday <- (map["birthday"], DateTransform())
```
The above transform will convert the JSON Int value to an NSDate when reading JSON and will convert the NSDate to an Int when converting objects to JSON.

You can easily create your own custom transforms by adopting and implementing the methods in the TransformType protocol:
```swift
public protocol TransformType {
    typealias Object
    typealias JSON

    func transformFromJSON(value: AnyObject?) -> Object?
    func transformToJSON(value: Object?) -> JSON?
}
```
<!-- ##To Do -->

##Installation
ObjectMapper can be added to your project using [Cocoapods 0.36 (beta)](http://blog.cocoapods.org/Pod-Authors-Guide-to-CocoaPods-Frameworks/) by adding the following line to your Podfile:
```
pod 'ObjectMapper', '~> 0.7'
```

If your using [Carthage](https://github.com/Carthage/Carthage) you can add a dependency on ObjectMapper by adding it to your Cartfile:
```
github "Hearst-DD/ObjectMapper" ~> 0.7
```

Otherwise, ObjectMapper can be added as a submodule:

1. Add ObjectMapper as a [submodule](http://git-scm.com/docs/git-submodule) by opening the Terminal, `cd`-ing into your top-level project directory, and entering the command `git submodule add https://github.com/Hearst-DD/ObjectMapper.git`
2. Open the `ObjectMapper` folder, and drag `ObjectMapper.xcodeproj` into the file navigator of your app project.
3. In Xcode, navigate to the target configuration window by clicking on the blue project icon, and selecting the application target under the "Targets" heading in the sidebar.
4. Ensure that the deployment target of ObjectMapper.framework matches that of the application target.
5. In the tab bar at the top of that window, open the "Build Phases" panel.
6. Expand the "Target Dependencies" group, and add `ObjectMapper.framework`.
7. Click on the `+` button at the top left of the panel and select "New Copy Files Phase". Rename this new phase to "Copy Frameworks", set the "Destination" to "Frameworks", and add `ObjectMapper.framework`.
