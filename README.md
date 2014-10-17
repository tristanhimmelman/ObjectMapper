ObjectMapper
============

ObjectMapper is a framework written in Swift that makes it easy for you to convert your Model objects to and from JSON. 

Features:
- Mapping JSON to objects
- Mapping objects to JSON
- Nested Objects (stand alone, in Arrays or in Dictionarys)
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

