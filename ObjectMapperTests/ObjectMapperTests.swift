//
//  ObjectMapperTests.swift
//  ObjectMapperTests
//
//  Created by Tristan Himmelman on 2014-10-16.
//  Copyright (c) 2014 hearst. All rights reserved.
//

import UIKit
import XCTest
import ObjectMapper

class ObjectMapperTests: XCTestCase {

    let userMapper = Mapper<User>()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

	func testImmutableMappable() {
		let mapper = Mapper<Immutable>()
		let JSON = [ "prop1": "Immutable!", "prop2": 255, "prop3": true ]

		let immutable = mapper.map(JSON)
		XCTAssertEqual(immutable.prop1, "Immutable!")
		XCTAssertEqual(immutable.prop2, 255)
		XCTAssertEqual(immutable.prop3, true)

		let JSON2 = [ "prop1": "prop1", "prop2": NSNull() ]
		let immutable2 = mapper.map(JSON2)
		XCTAssert(immutable2 == nil)

		let JSONFromObject = mapper.toJSON(immutable)
		XCTAssert(mapper.map(JSONFromObject) == immutable)
	}

    func testBasicParsing() {
        let username = "John Doe"
        let identifier = "user8723"
        let photoCount = 13
        let age = 1227
        let weight = 123.23
        let float: Float = 123.231
        let drinker = true
        let smoker = false
        let arr = [ "bla", true, 42 ]
        let directory = [
            "key1" : "value1",
            "key2" : false,
            "key3" : 142
        ]
        
        let subUserJSON = "{\"identifier\" : \"user8723\", \"drinker\" : true, \"age\": 17, \"username\" : \"sub user\" }"
        
        let userJSONString = "{\"username\":\"\(username)\",\"identifier\":\"\(identifier)\",\"photoCount\":\(photoCount),\"age\":\(age),\"drinker\":\(drinker),\"smoker\":\(smoker), \"arr\":[ \"bla\", true, 42 ], \"dict\":{ \"key1\" : \"value1\", \"key2\" : false, \"key3\" : 142 }, \"arrOpt\":[ \"bla\", true, 42 ], \"dictOpt\":{ \"key1\" : \"value1\", \"key2\" : false, \"key3\" : 142 }, \"weight\": \(weight), \"float\": \(float), \"friend\": \(subUserJSON), \"friendDictionary\":{ \"bestFriend\": \(subUserJSON)}}"
		
		if let user = userMapper.map(string: userJSONString) {
			XCTAssertEqual(username, user.username, "Username should be the same")
			XCTAssertEqual(identifier, user.identifier!, "Identifier should be the same")
			XCTAssertEqual(photoCount, user.photoCount, "PhotoCount should be the same")
			XCTAssertEqual(age, user.age!, "Age should be the same")
			XCTAssertEqual(weight, user.weight!, "Weight should be the same")
			XCTAssertEqual(float, user.float!, "float should be the same")
			XCTAssertEqual(drinker, user.drinker, "Drinker should be the same")
			XCTAssertEqual(smoker, user.smoker!, "Smoker should be the same")

			//println(Mapper().toJSONString(user, prettyPrint: true))
		} else {
			XCTAssert(false, "Mapping user object failed")
		}
    }
	
    func testInstanceParsing() {
        let username = "John Doe"
        let identifier = "user8723"
        let photoCount = 13
        let age = 1227
        let weight = 123.23
        let float: Float = 123.231
        let drinker = true
        let smoker = false
        let arr = [ "bla", true, 42 ]
        let directory = [
            "key1" : "value1",
            "key2" : false,
            "key3" : 142
        ]
        
        let subUserJSON = "{\"identifier\" : \"user8723\", \"drinker\" : true, \"age\": 17, \"username\" : \"sub user\" }"
        
        let userJSONString = "{\"username\":\"\(username)\",\"identifier\":\"\(identifier)\",\"photoCount\":\(photoCount),\"age\":\(age),\"drinker\":\(drinker),\"smoker\":\(smoker), \"arr\":[ \"bla\", true, 42 ], \"dict\":{ \"key1\" : \"value1\", \"key2\" : false, \"key3\" : 142 }, \"arrOpt\":[ \"bla\", true, 42 ], \"dictOpt\":{ \"key1\" : \"value1\", \"key2\" : false, \"key3\" : 142 },\"weight\": \(weight), \"float\": \(float), \"friend\": \(subUserJSON), \"friendDictionary\":{ \"bestFriend\": \(subUserJSON)}}"
        
        let user = Mapper().map(string: userJSONString, toObject: User())
        
        XCTAssertEqual(username, user.username, "Username should be the same")
        XCTAssertEqual(identifier, user.identifier!, "Identifier should be the same")
        XCTAssertEqual(photoCount, user.photoCount, "PhotoCount should be the same")
        XCTAssertEqual(age, user.age!, "Age should be the same")
        XCTAssertEqual(weight, user.weight!, "Weight should be the same")
        XCTAssertEqual(float, user.float!, "float should be the same")
        XCTAssertEqual(drinker, user.drinker, "Drinker should be the same")
        XCTAssertEqual(smoker, user.smoker!, "Smoker should be the same")

        println(Mapper().toJSONString(user, prettyPrint: true))
    }
    
    func testDictionaryParsing() {
        var name: String = "Genghis khan"
        var UUID: String = "12345"
        var major: Int = 99
        var minor: Int = 1
        let json: [String: AnyObject] = ["name": name, "UUID": UUID, "major": major]
        
        //test that the sematics of value types works as expected.  the resulting maped student
        //should have the correct minor property set even thoug it's not mapped
        var s = Student()
        s.minor = minor
        let student = Mapper().map(json, toObject: s)
        
        XCTAssertEqual(student.name!, name, "Names should be the same")
        XCTAssertEqual(student.UUID!, UUID, "UUID should be the same")
        XCTAssertEqual(student.major!, major, "major should be the same")
        XCTAssertEqual(student.minor!, minor, "minor should be the same")
        
        //Test that mapping a reference type works as expected while not relying on the return value
        var username: String = "Barack Obama"
        var identifier: String = "Political"
        var photoCount: Int = 1000000000
        
        let json2: [String: AnyObject] = ["username": username, "identifier": identifier, "photoCount": photoCount]
        let user = User()
        Mapper().map(json2, toObject: user)
        XCTAssertEqual(user.username, username, "Usernames should be the same")
        XCTAssertEqual(user.identifier!, identifier, "identifiers should be the same")
        XCTAssertEqual(user.photoCount, photoCount, "photo count should be the same")
    }
    
	func testNestedKeys(){
		let heightInCM = 180.0
		let heightText = "6 feet tall"
		
		let userJSONString = "{\"username\":\"bob\", \"height\": {\"value\": \(heightInCM), \"text\": \"\(heightText)\"} }"

		// Test that a nested JSON can be mapped to an object
		if let user = userMapper.map(string: userJSONString) {
			XCTAssert(user.heightInCM == heightInCM, "Height should be the same")
			XCTAssert(user.heightText == heightText, "Height text should be the same")

			// Test that nested keys can be mapped to JSON
			let userJSONString = userMapper.toJSONString(user, prettyPrint: true)

			if let user = userMapper.map(string: userJSONString) {
				XCTAssert(user.heightInCM == heightInCM, "Height should be the same")
				XCTAssert(user.heightText == heightText, "Height text should be the same")
			} else {
				XCTAssert(false, "Nested key failed")
			}
		} else {
			XCTAssert(false, "Nested key failed")
		}
	}
	
	func testNestedKeyObject(){
		let nestedUsername = "nested username"
		
		let userJSONString = "{\"username\":\"bob\", \"nested\": {\"user\": {\"username\":\"\(nestedUsername)\"} } }"
		
		// Test that a nested JSON can be mapped to an object
		if let user = userMapper.map(string: userJSONString) {
			
			// Test that nested keys can be mapped to JSON
			let userJSONString = userMapper.toJSONString(user, prettyPrint: true)
			
			if let user = userMapper.map(string: userJSONString) {
				XCTAssertEqual(user.nestedUser!.username, nestedUsername, "Height should be the same")
			} else {
				XCTAssert(false, "Nested key failed")
			}
		} else {
			XCTAssert(false, "Nested key failed")
		}
	}
	
	func testNullObject() {
		let userJSONString = "{\"username\":\"bob\"}"
		
		if let user = userMapper.map(string: userJSONString) {
			XCTAssert(user.heightInCM == nil, "Username should be the same")
		} else {
			XCTAssert(false, "Null Object failed")
		}
	}
	
	func testToObjectFromString() {
		let username = "bob"
		let userJSONString = "{\"username\":\"\(username)\"}"
		
		var user = User()
		user.username = "Tristan"
		
		Mapper().map(string: userJSONString, toObject: user)
		
		XCTAssert(user.username == username, "Username should be the same")
	}
	
	func testToObjectFromJSON() {
		let username = "bob"
		let userJSON = ["username":username]
		
		var user = User()
		user.username = "Tristan"
		
		Mapper().map(userJSON, toObject: user)
		
		XCTAssert(user.username == username, "Username should be the same")
	}
	
	func testToObjectFromAnyObject() {
		let username = "bob"
		let userJSON = ["username":username]
		
		var user = User()
		user.username = "Tristan"
		
		Mapper().map(userJSON as AnyObject?, toObject: user)
		
		XCTAssert(user.username == username, "Username should be the same")
	}
	
    func testToJSONAndBack(){
        var user = User()
        user.username = "tristan_him"
        user.identifier = "tristan_him_identifier"
        user.photoCount = 0
        user.age = 28
        user.weight = 150
        user.drinker = true
        user.smoker = false
        user.arr = ["cheese", 11234]
        
        let jsonString = Mapper().toJSONString(user, prettyPrint: true)
        println(jsonString)
		if let parsedUser = userMapper.map(string: jsonString) {
			XCTAssertEqual(user.identifier!, parsedUser.identifier!, "Identifier should be the same")
			XCTAssertEqual(user.photoCount, parsedUser.photoCount, "PhotoCount should be the same")
			XCTAssertEqual(user.age!, parsedUser.age!, "Age should be the same")
			XCTAssertEqual(user.weight!, parsedUser.weight!, "Weight should be the same")
			XCTAssertEqual(user.drinker, parsedUser.drinker, "Drinker should be the same")
			XCTAssertEqual(user.smoker!, parsedUser.smoker!, "Smoker should be the same")
		} else {
			XCTAssert(false, "to JSON and back failed")
		}
    }

    func testUnknownPropertiesIgnored() {
        let userJSONString = "{\"username\":\"bob\",\"identifier\":\"bob1987\", \"foo\" : \"bar\", \"fooArr\" : [ 1, 2, 3], \"fooObj\" : { \"baz\" : \"qux\" } }"
		let user = userMapper.map(string: userJSONString)
	
		XCTAssert(user != nil, "User should not be nil")
    }
    
    func testInvalidJsonResultsInNilObject() {
        let userJSONString = "{\"username\":\"bob\",\"identifier\":\"bob1987\"" // missing ending brace

        let user = userMapper.map(string: userJSONString)
	
        XCTAssert(user == nil, "User should be nil due to invalid JSON")
    }
	
	func testMapArrayJSON(){
		let name1 = "Bob"
		let name2 = "Jane"
		
		let arrayJSONString = "[{\"name\": \"\(name1)\", \"UUID\": \"3C074D4B-FC8C-4CA2-82A9-6E9367BBC875\", \"major\": 541, \"minor\": 123},{ \"name\": \"\(name2)\", \"UUID\": \"3C074D4B-FC8C-4CA2-82A9-6E9367BBC876\", \"major\": 54321,\"minor\": 13 }]"
	
		let students = Mapper<Student>().mapArray(string: arrayJSONString)

		XCTAssert(!students.isEmpty, "Student Array should not be empty")
		XCTAssert(students.count == 2, "There should be 2 students in array")
		XCTAssert(students[0].name == name1, "First student's does not match")
		XCTAssert(students[1].name == name2, "Second student's does not match")
	}

	// test mapArray() with JSON string that is not an array form
	// should return a collection with one item
	func testMapArrayJSONWithNoArray(){
		let name1 = "Bob"
		
		let arrayJSONString = "{\"name\": \"\(name1)\", \"UUID\": \"3C074D4B-FC8C-4CA2-82A9-6E9367BBC875\", \"major\": 541, \"minor\": 123}"
		
		let students = Mapper<Student>().mapArray(string: arrayJSONString)

		XCTAssert(!students.isEmpty, "Student Array should not be empty")
		XCTAssert(students.count == 1, "There should be 1 student in array")
		XCTAssert(students[0].name == name1, "First student's does not match")
	}

	func testArrayOfCustomObjects(){
		let percentage1: Double = 0.1
		let percentage2: Double = 1792.41
		
		let JSON = "{ \"tasks\": [{\"taskId\":103,\"percentage\":\(percentage1)},{\"taskId\":108,\"percentage\":\(percentage2)}] }"
		
		let plan = Mapper<Plan>().map(string: JSON)
		
		if let tasks = plan?.tasks {
			let task1 = tasks[0]
			XCTAssertEqual(task1.percentage!, percentage1, "Percentage 1 should be the same")
			
			let task2 = tasks[1]
			XCTAssertEqual(task2.percentage!, percentage2, "Percentage 2 should be the same")
		} else {
			XCTAssert(false, "Tasks not mapped")
		}
	}
	
	func testDictionaryOfCustomObjects(){
		let percentage1: Double = 0.1
		let percentage2: Double = 1792.41
		
		let JSON = "{\"tasks\": { \"task1\": {\"taskId\":103,\"percentage\":\(percentage1)}, \"task2\": {\"taskId\":108,\"percentage\":\(percentage2)}}}"
		
		let taskDict = Mapper<TaskDictionary>().map(string: JSON)
		if let task = taskDict?.tasks?["task1"] {
			XCTAssertEqual(task.percentage!, percentage1, "Percentage 1 should be the same")
		} else {
			XCTAssert(false, "Dictionary not mapped")
		}
	}
	
	func testDoubleParsing(){
		let percentage1: Double = 1792.41
		
		let JSON = "{\"taskId\":103,\"percentage\":\(percentage1)}"
		
		let task = Mapper<Task>().map(string: JSON)
		
		if let task = task {
			XCTAssertEqual(task.percentage!, percentage1, "Percentage 1 should be the same")
		} else {
			XCTAssert(false, "Task not mapped")
		}
	}
	
	func testMappingAGenericObject(){
		let code: Int = 22
		let JSON = "{\"result\":{\"code\":\(code)}}"
		
		let response = Mapper<Response<Status>>().map(string: JSON)
		
		if let status = response?.result?.status {
			XCTAssertEqual(status, code, "Code was not mapped correctly")
		} else {
			XCTAssert(false, "Generic object FAILED to map")
		}
	}

	func testToJSONArray(){
		var task1 = Task()
		task1.taskId = 1
		task1.percentage = 11.1
		var task2 = Task()
		task2.taskId = 2
		task2.percentage = 22.2
		var task3 = Task()
		task3.taskId = 3
		task3.percentage = 33.3
		
		var taskArray = [task1, task2, task3]
		
		let JSONArray = Mapper().toJSONArray(taskArray)
		println(JSONArray)
		
		let taskId1 = JSONArray[0]["taskId"] as Int
		let percentage1 = JSONArray[0]["percentage"] as Double
		
		XCTAssertEqual(taskId1, task1.taskId!, "TaskId1 was not mapped correctly")
		XCTAssertEqual(percentage1, task1.percentage!, "percentage1 was not mapped correctly")

		let taskId2 = JSONArray[1]["taskId"] as Int
		let percentage2 = JSONArray[1]["percentage"] as Double
		
		XCTAssertEqual(taskId2, task2.taskId!, "TaskId2 was not mapped correctly")
		XCTAssertEqual(percentage2, task2.percentage!, "percentage2 was not mapped correctly")
		
		let taskId3 = JSONArray[2]["taskId"] as Int
		let percentage3 = JSONArray[2]["percentage"] as Double
		
		XCTAssertEqual(taskId3, task3.taskId!, "TaskId3 was not mapped correctly")
		XCTAssertEqual(percentage3, task3.percentage!, "percentage3 was not mapped correctly")
	}
	
	func testSubclass() {
		var object = Subclass()
		object.base = "base var"
		object.sub = "sub var"
		
		let json = Mapper().toJSON(object)
		let parsedObject = Mapper<Subclass>().map(json)
		
		XCTAssert(object.base! == parsedObject.base!, "base class var was not mapped")
		XCTAssert(object.sub! == parsedObject.sub!, "sub class var was not mapped")
	}

	func testGenericSubclass() {
		var object = GenericSubclass<String>()
		object.base = "base var"
		object.sub = "sub var"
		
		let json = Mapper().toJSON(object)
		let parsedObject = Mapper<GenericSubclass<String>>().map(json)
		
		XCTAssert(object.base! == parsedObject.base!, "base class var was not mapped")
		XCTAssert(object.sub! == parsedObject.sub!, "sub class var was not mapped")
	}
	
	func testSubclassWithGenericArrayInSuperclass() {
		let parsedObject = Mapper<SubclassWithGenericArrayInSuperclass<AnyObject>>().map(string:"{\"genericItems\":[{\"value\":\"value0\"}, {\"value\":\"value1\"}]}")
		if let genericItems = parsedObject?.genericItems {
			XCTAssertEqual(genericItems[0].value!, "value0")
			XCTAssertEqual(genericItems[1].value!, "value1")
		} else {
			XCTFail("genericItems should not be .None")
		}
	}
}

infix operator <^> { associativity left }
infix operator <*> { associativity left }

public func <^><T, U>(f: T -> U, a: T?) -> U? {
	return a.map(f)
}

public func <*><T, U>(f: (T -> U)?, a: T?) -> U? {
	return a.apply(f)
}

extension Optional {
	func apply<U>(f: (T -> U)?) -> U? {
		switch (self, f) {
		case let (.Some(x), .Some(fx)): return fx(x)
		default: return .None
		}
	}
}

struct Immutable: Equatable {
	let prop1: String
	let prop2: Int
	let prop3: Bool
}

extension Immutable: Mappable {
	static func create(prop1: String)(prop2: Int)(prop3: Bool) -> Immutable {
		return Immutable(prop1: prop1, prop2: prop2, prop3: prop3)
	}

	init?(_ map: Map) {
		let x = Immutable.create
			<^> map["prop1"].value()
			<*> map["prop2"].value()
			<*> map["prop3"].value()

		if let x = x {
			self = x
		} else {
			return nil
		}
	}

	mutating func mapping(map: Map) {
		switch map.mappingType {
		case .fromJSON:
			if let x = Immutable(map) {
				self = x
			}

		case .toJSON:
			var prop1 = self.prop1
			var prop2 = self.prop2
			var prop3 = self.prop3

			prop1 <- map["prop1"]
			prop2 <- map["prop2"]
			prop3 <- map["prop3"]
		}
	}
}

func ==(lhs: Immutable, rhs: Immutable) -> Bool {
	return lhs.prop1 == rhs.prop1 && lhs.prop2 == rhs.prop2 && lhs.prop3 == rhs.prop3
}

class Response<T: Mappable>: Mappable {
	var result: T?
	
	required init?(_ map: Map) {
		mapping(map)
	}

	func mapping(map: Map) {
		result <- map["result"]
	}
}

class Status: Mappable {
	var status: Int?
	
	required init?(_ map: Map) {
		mapping(map)
	}

	func mapping(map: Map) {
		status <- map["code"]
	}
}

class Plan: Mappable {
	var tasks: [Task]?
	
	required init?(_ map: Map) {
		mapping(map)
	}

	func mapping(map: Map) {
		tasks <- map["tasks"]
	}
}

class Task: Mappable {
	var taskId: Int?
	var percentage: Double?

	init() {}
	
	required init?(_ map: Map) {
		mapping(map)
	}

	func mapping(map: Map) {
		taskId <- map["taskId"]
		percentage <- map["percentage"]
	}
}

class TaskDictionary: Mappable {
	var test: String?
	var tasks: [String : Task]?
	
	required init?(_ map: Map) {
		mapping(map)
	}

	func mapping(map: Map) {
		test <- map["test"]
		tasks <- map["tasks"]
	}
}


// Confirm that struct can conform to `Mappable`
struct Student: Mappable {
	var name: String?
	var UUID: String?
	var major: Int?
	var minor: Int?

	init() {}
	
	init?(_ map: Map) {
		mapping(map)
	}

	mutating func mapping(map: Map) {
		name <- map["name"]
		UUID <- map["UUID"]
		major <- map["major"]
		minor <- map["minor"]
	}
}

class User: Mappable {
    
    var username: String = ""
    var identifier: String?
    var photoCount: Int = 0
    var age: Int?
    var weight: Double?
    var float: Float?
    var drinker: Bool = false
    var smoker: Bool?
    var arr: [AnyObject] = []
    var arrOptional: [AnyObject]?
    var dict: [String : AnyObject] = [:]
    var dictOptional: [String : AnyObject]?
	var dictString: [String : String]?
    var friendDictionary: [String : User]?
    var friend: User?
    var friends: [User]? = []
	var nestedUser: User?
	var heightInCM: Double?
	var heightText: String?

	init() {}

	required init?(_ map: Map) {
		mapping(map)
	}

	func mapping(map: Map) {
		username         <- map["username"]
		identifier       <- map["identifier"]
		photoCount       <- map["photoCount"]
		age              <- map["age"]
		weight           <- map["weight"]
		float            <- map["float"]
		drinker          <- map["drinker"]
		smoker           <- map["smoker"]
		arr              <- map["arr"]
		arrOptional      <- map["arrOpt"]
		dict             <- map["dict"]
		dictOptional     <- map["dictOpt"]
		friend           <- map["friend"]
		friends          <- map["friends"]
		friendDictionary <- map["friendDictionary"]
		dictString		 <- map["dictString"]
		heightInCM		 <- map["height.value"]
		heightText		 <- map["height.text"]
		nestedUser		 <- map["nested.user"]
	}
}

class Base: Mappable {
	
	var base: String?

	init() {}
	
	required init?(_ map: Map) {
		mapping(map)
	}

	func mapping(map: Map) {
		base <- map["base"]
	}
}

class Subclass: Base {
	
	var sub: String?

	override init() {
		super.init()
	}
	
	required init?(_ map: Map) {
		super.init(map)
	}

	override func mapping(map: Map) {
		super.mapping(map)
		
		sub <- map["sub"]
	}
}


class GenericSubclass<T>: Base {
	
	var sub: String?

	override init() {
		super.init()
	}

	required init?(_ map: Map) {
		super.init(map)
	}

	override func mapping(map: Map) {
		super.mapping(map)
		
		sub <- map["sub"]
	}
}

class WithGenericArray<T: Mappable>: Mappable {
	var genericItems: [T]?

	required init?(_ map: Map) {
		mapping(map)
	}

	func mapping(map: Map) {
		genericItems <- map["genericItems"]
	}
}

class ConcreteItem: Mappable {
	var value: String?

	required init?(_ map: Map) {
		mapping(map)
	}

	func mapping(map: Map) {
		value <- map["value"]
	}
}

class SubclassWithGenericArrayInSuperclass<Unused>: WithGenericArray<ConcreteItem> {
	required init?(_ map: Map) {
		super.init(map)
	}
}
