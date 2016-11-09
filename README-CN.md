# ObjectMapper
> 文档由Swift老司机活动中心负责翻译，欢迎关注[@SwiftOldDriver](http://weibo.com/6062089411)。翻译有问题可以到 [ObjectMapper-CN-Guide](https://github.com/SwiftOldDriver/ObjectMapper-CN-Guide) 提 PR。

[ObjectMapper](https://github.com/Hearst-DD/ObjectMapper) 是一个使用 Swift 编写的用于 model 对象（类和结构体）和 JSON  之间转换的框架。

- [特性](#特性)
- [基础使用方法](#基础使用方法)
- [映射嵌套对象](#映射嵌套对象)
- [自定义转换规则](#自定义转换规则)
- [继承](#继承)
- [泛型对象](#泛型对象)
- [映射时的上下文对象](#映射时的上下文对象)
- [ObjectMapper + Alamofire](#objectmapper--alamofire) 
- [ObjectMapper + Realm](#objectmapper--realm)
- [To Do](#to-do)
- [安装](#installation)

# 特性:
- 把 JSON 映射成对象 
- 把对象映射 JSON
- 支持嵌套对象 (单独的成员变量、在数组或字典中都可以)
- 在转换过程支持自定义规则
- 支持结构体（ Struct ）
- [Immutable support](#immutablemappable-protocol-beta) (目前还在 beta )

# 基础使用方法
为了支持映射，类或者结构体只需要实现```Mappable```协议。这个协议包含以下方法：
```swift
init?(map: Map)
mutating func mapping(map: Map)
```
ObjectMapper使用自定义的```<-``` 运算符来声明成员变量和 JSON 的映射关系。
```swift
class User: Mappable {
    var username: String?
    var age: Int?
    var weight: Double!
    var array: [AnyObject]?
    var dictionary: [String : AnyObject] = [:]
    var bestFriend: User?                       // 嵌套的 User 对象
    var friends: [User]?                        // Users 的数组
    var birthday: NSDate?

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

一旦你的对象实现了 `Mappable`, ObjectMapper就可以让你轻松的实现和 JSON 之间的转换。

把 JSON 字符串转成 model 对象：

```swift
let user = User(JSONString: JSONString)
```

把一个 model 转成 JSON 字符串：

```swift
let JSONString = user.toJSONString(prettyPrint: true)
```

也可以使用`Mapper.swift`类来完成转换（这个类还额外提供了一些函数来处理一些特殊的情况：

```swift
// 把 JSON 字符串转成 Model
let user = Mapper<User>().map(JSONString: JSONString)
// 根据 Model 生成 JSON 字符串
let JSONString = Mapper().toJSONString(user, prettyPrint: true)
```

ObjectMapper支持以下的类型映射到对象中：

- `Int`
- `Bool`
- `Double`
- `Float`
- `String`
- `RawRepresentable` (枚举)
- `Array<AnyObject>`
- `Dictionary<String, AnyObject>`
- `Object<T: Mappable>`
- `Array<T: Mappable>`
- `Array<Array<T: Mappable>>`
- `Set<T: Mappable>` 
- `Dictionary<String, T: Mappable>`
- `Dictionary<String, Array<T: Mappable>>`
- 以上所有的 Optional 类型
- 以上所有的隐式强制解包类型（Implicitly Unwrapped Optional）

## `Mappable` 协议

#### `mutating func mapping(map: Map)` 
所有的映射最后都会调用到这个函数。当解析 JSON 时，这个函数会在对象创建成功后被执行。当生成 JSON 时就只有这个函数会被对象调用。

#### `init?(map: Map)` 
这个可失败的初始化函数是 ObjectMapper 创建对象的时候使用的。开发者可以通过这个函数在映射前校验 JSON 。如果在这个方法里返回 nil 就不会执行 `mapping` 函数。可以通过传入的保存着 JSON 的  `Map` 对象进行校验：

```swift
required init?(map: Map){
	// 检查 JSON 里是否有一定要有的 "name" 属性
	if map.JSONDictionary["name"] == nil {
		return nil
	}
}
```

## `StaticMappable` 协议
`StaticMappable` 是 `Mappable` 之外的另一种选择。 这个协议可以让开发者通过一个静态函数初始化对象而不是通过 `init?(map: Map)`。

注意: `StaticMappable` 和 `Mappable` 都继承了 `BaseMappable` 协议。 `BaseMappable` 协议声明了 `mapping(map: Map)` 函数。

#### `static func objectForMapping(map: Map) -> BaseMappable?` 
ObjectMapper 使用这个函数获取对象后进行映射。开发者需要在这个函数里返回一个实现 `BaseMappable` 对象的实例。这个函数也可以用于：

- 在对象进行映射前校验 JSON 
- 提供一个缓存过的对象用于映射
- 返回另外一种类型的对象（当然是必须实现了 BaseMappable）用于映射。比如你可能通过检查 JSON 推断出用于映射的对象 ([看这个例子](https://github.com/Hearst-DD/ObjectMapper/blob/master/ObjectMapperTests/ClassClusterTests.swift#L62))。

如果你需要在 extension 里实现 ObjectMapper，你需要选择这个协议而不是 `Mappable` 。

## `ImmutableMappable` Protocol (Beta)

> ⚠️ 这个特性还处于 Beta 阶段。正式发布时 API 可能会完全不同。这段等到正式发布后再翻译。

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
mutating func mapping(map: Map) {
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

This method is where the reverse transform is performed (Model to JSON). Since immutable properties can not be mapped with the `<-` operator, developers have to define the reverse transform using the `>>>` operator.

```swift
mutating func mapping(map: Map) {
    name      >>> map["name"]
    createdAt >>> (map["createdAt"], DateTransform())
    updatedAt >>> (map["updatedAt"], DateTransform())
    posts     >>> map["posts"]
}
```
# 轻松映射嵌套对象

ObjectMapper 支持使用点语法来轻松实现嵌套对象的映射。比如有如下的 JSON 字符串：

```json
"distance" : {
     "text" : "102 ft",
     "value" : 31
}
```
你可以通过这种写法直接访问到嵌套对象：

```swift
func mapping(map: Map) {
    distance <- map["distance.value"]
}
```
嵌套的键名也支持访问数组中的值。如果有一个返回的 JSON 是一个包含 distance 的数组，可以通过这种写法访问：

```
distance <- map["distances.0.value"]
```
如果你的键名刚好含有 `.` 符号，你需要特别声明关闭上面提到的获取嵌套对象功能：

```swift
func mapping(map: Map) {
    identifier <- map["app.identifier", nested: false]
}
```
如果刚好有嵌套的对象的键名还有 `.` ,可以在中间加入一个自定义的分割符（[#629](https://github.com/Hearst-DD/ObjectMapper/pull/629)）:
```swift
func mapping(map: Map) {
    appName <- map["com.myapp.info->com.myapp.name", delimiter: "->"]
}
```
这种情况的 JSON 是这样的：

```json
"com.myapp.info" : {
     "com.myapp.name" : "SwiftOldDriver"
}
```

# 自定义转换规则
ObjectMapper 也支持在映射时自定义转换规则。如果要使用自定义转换，创建一个 tuple（元祖）包含 ```map["field_name"]``` 和你要使用的变换放在 ```<-``` 的右边：

```swift
birthday <- (map["birthday"], DateTransform())
```
当解析 JSON 时上面的转换会把 JSON 里面的 Int 值转成一个 NSDate ，如果是对象转为 JSON 时，则会把 NSDate 对象转成 Int 值。

只要实现```TransformType``` 协议就可以轻松的创建自定义的转换规则：

```swift
public protocol TransformType {
    associatedtype Object
    associatedtype JSON

    func transformFromJSON(_ value: Any?) -> Object?
    func transformToJSON(_ value: Object?) -> JSON?
}
```

### TransformOf
大多数情况下你都可以使用框架提供的转换类 ```TransformOf``` 来快速的实现一个期望的转换。 ```TransformOf``` 的初始化需要两个类型和两个闭包。两个类型声明了转换的目标类型和源类型，闭包则实现具体转换逻辑。

举个例子，如果你想要把一个 JSON 字符串转成 Int ，你可以像这样使用 ```TransformOf``` ：

```swift
let transform = TransformOf<Int, String>(fromJSON: { (value: String?) -> Int? in 
    // 把值从 String? 转成 Int?
    return Int(value!)
}, toJSON: { (value: Int?) -> String? in
    // 把值从 Int? 转成 String?
    if let value = value {
        return String(value)
    }
    return nil
})

id <- (map["id"], transform)
```
这是一种更省略的写法：

```swift
id <- (map["id"], TransformOf<Int, String>(fromJSON: { Int($0!) }, toJSON: { $0.map { String($0) } }))
```
# 继承

实现了  ```Mappable``` 协议的类可以容易的被继承。当继承一个 mappable 的类时，使用这样的结构：

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

注意确认子类中的实现调用了父类中正确的初始化器和映射函数。

# 泛型对象

ObjectMapper 可以处理泛型只要这个泛型也实现了`Mappable`协议。看这个例子：

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
# 映射时的上下文对象

`Map` 是在映射时传入的对象，带有一个 optional  `MapContext` 对象，开发者可以通过使用这个对象在映射时传入一些信息。

为了使用这个特性，需要先创建一个对象实现了 `MapContext` 协议（这个协议是空的），然后在初始化时传入 `Mapper` 中。

```swift
struct Context: MapContext {
	var importantMappingInfo = "映射时需要知道的额外信息"
}

class User: Mappable {
	var name: String?
	
	required init?(map: Map){
	
	}
	
	func mapping(map: Map){
		if let context = map.context as? Context {
			// 获取到额外的信息
		}
	}
}

let context = Context()
let user = Mapper<User>(context: context).map(JSONString)
```

#ObjectMapper + Alamofire

如果网络层你使用的是  [Alamofire](https://github.com/Alamofire/Alamofire) ，并且你希望把返回的结果转换成 Swift 对象，你可以使用 [AlamofireObjectMapper](https://github.com/tristanhimmelman/AlamofireObjectMapper) 。这是一个使用 ObjectMapper 实现的把返回的 JSON 自动转成 Swift 对象的 Alamofire 的扩展。 


#ObjectMapper + Realm

ObjectMapper 可以和 Realm 一起配合使用。使用下面的声明结构就可以使用 ObjectMapper 生成 Realm 对象：

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

如果你想要序列化相关联的 RealmObject，你可以使用 [ObjectMapper+Realm](https://github.com/jakenberg/ObjectMapper-Realm)。这是一个简单的 Realm 扩展，用于把任意的 JSON 序列化成 Realm 的类（ealm's List class。）

Note: Generating a JSON string of a Realm Object using ObjectMappers' `toJSON` function only works within a Realm write transaction. This is caused because ObjectMapper uses the `inout` flag in its mapping functions (`<-`) which are used both for serializing and deserializing. Realm detects the flag and forces the `toJSON` function to be called within a write block even though the objects are not being modified.

# To Do
- Improve error handling. Perhaps using `throws`
- Class cluster documentation

# Installation
### Cocoapods
ObjectMapper can be added to your project using [CocoaPods 0.36 or later](http://blog.cocoapods.org/Pod-Authors-Guide-to-CocoaPods-Frameworks/) by adding the following line to your `Podfile`:

```ruby
pod 'ObjectMapper', '~> 2.2'
```

### Carthage
If you're using [Carthage](https://github.com/Carthage/Carthage) you can add a dependency on ObjectMapper by adding it to your `Cartfile`:

```
github "Hearst-DD/ObjectMapper" ~> 2.2
```

### Swift Package Manager
To add ObjectMapper to a [Swift Package Manager](https://swift.org/package-manager/) based project, add:

```swift
.Package(url: "https://github.com/Hearst-DD/ObjectMapper.git", majorVersion: 2, minor: 2),
```
to your `Package.swift` files `dependencies` array.

### Submodule
Otherwise, ObjectMapper can be added as a submodule:

1. Add ObjectMapper as a [submodule](http://git-scm.com/docs/git-submodule) by opening the terminal, `cd`-ing into your top-level project directory, and entering the command `git submodule add https://github.com/Hearst-DD/ObjectMapper.git`
2. Open the `ObjectMapper` folder, and drag `ObjectMapper.xcodeproj` into the file navigator of your app project.
3. In Xcode, navigate to the target configuration window by clicking on the blue project icon, and selecting the application target under the "Targets" heading in the sidebar.
4. Ensure that the deployment target of `ObjectMapper.framework` matches that of the application target.
5. In the tab bar at the top of that window, open the "Build Phases" panel.
6. Expand the "Target Dependencies" group, and add `ObjectMapper.framework`.
7. Click on the `+` button at the top left of the panel and select "New Copy Files Phase". Rename this new phase to "Copy Frameworks", set the "Destination" to "Frameworks", and add `ObjectMapper.framework`.