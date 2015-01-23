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
To support mapping, a Class or Struct just needs to implement the ```Mappable```. ObjectMapper uses the ```<=``` operator to define how each member variable maps to and from JSON.

```swift
class User: Mappable {

    var username: String?
    var age: Int?
    var weight: Double?
    var arr: [AnyObject]?
    var dict: [String : AnyObject] = [:]
    var friend: User?                       // Nested User object
    var birthday: NSDate?

    required init(){}

    // MapperProtocol    
    func map(mapper: Mapper) {
        username <= mapper["username"]
        age <= mapper["age"]
        weight <= mapper["weight"]
        arr <= mapper["arr"]
        dict <= mapper["dict"]
        friend <= mapper["friend"]
        birthday <= (mapper["birthday"], DateTransform<NSDate, Int>())
    }
}

struct Temperature: MapperProtocol {
    var celcius: Double?
    var fahrenheit: Double?
    
    init(){}
	
	mutating func map(mapper: Mapper) {
		celcius <= mapper["celcius"]
		fahrenheit <= mapper["fahrenheit"]
	}
}
```

Once your class implements MapperProtocol, the Mapper class handles everything else for you:

Convert a JSON string to a model object:
```swift
let user = Mapper().map(string: JSONString, toType: User.self)
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
- Optionals of all the abovee
- Object\<T: MapperProtocol\>
- Array\<T: MapperProtocol\>
- Dictionary\<String, T: MapperProtocol\>

##Custom Transfoms
ObjectMapper also supports custom Transforms that convert values during the mapping process. To use a transform, simply create a tuple with the mapper["field_name"] and the transform of choice on the right side of the '<=' operator:
```swift
birthday <= (mapper["birthday"], DateTransform<NSDate, Int>())
```
The above transform will convert the JSON Int value to an NSDate when reading JSON and will convert the NSDate to an Int when converting objects to JSON.

You can easily create your own custom transforms by subclassing and overriding the methods in the MapperTransform class:
```swift
public class MapperTransform<ObjectType, JSONType> {
    init(){}
    
    func transformFromJSON(value: AnyObject?) -> ObjectType? {
        return nil
    }
    
    func transformToJSON(value: ObjectType?) -> JSONType? {
        return nil
    }
}
```
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
func map(mapper: Mapper){
    distance <= mapper["distance.value"]
}
```

##To Do
- Support for implicitly unwrapped optionals (ex. var user: User!)


##Installation
ObjectMapper can be added to your project using [Cocoapods 0.36 (beta)](http://blog.cocoapods.org/Pod-Authors-Guide-to-CocoaPods-Frameworks/) by adding the following line to your Podfile:
```
pod 'ObjectMapper', '~> 0.2'
```

If your using [Carthage](https://github.com/Carthage/Carthage) you can add a dependency on ObjectMapper by adding it to your Cartfile:
```
github "Hearst-DD/ObjectMapper" ~> 0.2
```

Otherwise, ObjectMapper can be added as a submodule:

1. Add ObjectMapper as a [submodule](http://git-scm.com/docs/git-submodule) by opening the Terminal, `cd`-ing into your top-level project directory, and entering the command `git submodule add https://github.com/Hearst-DD/ObjectMapper.git`
2. Open the `ObjectMapper` folder, and drag `ObjectMapper.xcodeproj` into the file navigator of your app project.
3. In Xcode, navigate to the target configuration window by clicking on the blue project icon, and selecting the application target under the "Targets" heading in the sidebar.
4. Ensure that the deployment target of ObjectMapper.framework matches that of the application target.
5. In the tab bar at the top of that window, open the "Build Phases" panel.
6. Expand the "Target Dependencies" group, and add `ObjectMapper.framework`.
7. Click on the `+` button at the top left of the panel and select "New Copy Files Phase". Rename this new phase to "Copy Frameworks", set the "Destination" to "Frameworks", and add `ObjectMapper.framework`.
