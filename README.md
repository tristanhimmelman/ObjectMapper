ObjectMapper
============

ObjectMapper is a framework written in Swift that makes it easy for you to convert your Model objects to and from JSON. 
###Features:
- Mapping JSON to objects
- Mapping objects to JSON
- Nested Objects (stand alone, in Arrays or in Dictionaries)
- Custom transformations during mapping

To support mapping, a class just needs to implement the MapperProtocol. ObjectMapper uses the "<=" operator to define how each member variable maps to and from JSON.

```swift
class User: MapperProtocol {

    var username: String?
    var age: Int?
    var weight: Double?
    var arr: [AnyObject]?
    var dict: [String : AnyObject] = [:]
    var friend: User?
    var birthday: NSDate?

    // MapperProtocol    
    class func map(mapper: Mapper, object: User) {
        object.username <= mapper["username"]
        object.age <= mapper["age"]
        object.weight <= mapper["weight"]
        object.arr <= mapper["arr"]
        object.dict <= mapper["dict"]
        object.friend <= mapper["friend"]
        object.birthday <= (mapper["birthday"], DateTransform<NSDate, Int>())
    }
}
```

Once your class implements MapperProtocol, the Mapper class handles everything else for you:

Convert a JSON string to a model object:
```swift
let user = Mapper().map(JSONString, to: User.self)
```

Convert a model object to a JSON string:
```swift

let JSONString = Mapper().toJSONString(user)
```

Object mapper can handle classes composed of the following types:
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

ObjectMapper also supports Transforms that convert values during the mapping process. To use a transform, simply create a tuple with the mapper["field_name"] and the transform of choice on the right side of the '<=' operator:
```swift
object.birthday <= (mapper["birthday"], DateTransform<NSDate, Int>())
```
The above transform will convert the JSON Int value to an NSDate when reading JSON and will convert the NSDate to an Int when converting objects to JSON.

You can easily create your own custom transforms by subclassing and overriding the methods in the MapperTransform class:
```swift
public class MapperTransform<ObjectType, JSONType> {
    init(){

    }

    func transformFromJSON(value: AnyObject?) -> ObjectType? {
        return nil
    }

    func transformToJSON(value: ObjectType?) -> JSONType? {
        return nil
    }
}
```

###Installation

_Due to the current lack of [proper infrastructure](http://cocoapods.org) for Swift dependency management, using ObjectMapper in your project requires the following steps:_

1. Add ObjectMapper as a [submodule](http://git-scm.com/docs/git-submodule) by opening the Terminal, `cd`-ing into your top-level project directory, and entering the command `git submodule add https://github.com/Hearst-DD/ObjectMapper.git`
2. Open the `ObjectMapper` folder, and drag `ObjectMapper.xcodeproj` into the file navigator of your app project.
3. In Xcode, navigate to the target configuration window by clicking on the blue project icon, and selecting the application target under the "Targets" heading in the sidebar.
4. Ensure that the deployment target of Alamofire.framework matches that of the application target.
5. In the tab bar at the top of that window, open the "Build Phases" panel.
6. Expand the "Target Dependencies" group, and add `ObjectMapper.framework`.
7. Click on the `+` button at the top left of the panel and select "New Copy Files Phase". Rename this new phase to "Copy Frameworks", set the "Destination" to "Frameworks", and add `ObjectMapper.framework`.
