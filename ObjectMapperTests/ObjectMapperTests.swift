//
//  ObjectMapperTests.swift
//  ObjectMapperTests
//
//  Created by Tristan Himmelman on 2014-10-16.
//
//  The MIT License (MIT)
//
//  Copyright (c) 2014-2016 Hearst
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation
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

    func testBasicParsing() {
        let username = "John Doe"
        let identifier = "user8723"
        let photoCount = 13
        let age = 1227
        let weight = 123.23
        let float: Float = 123.231
        let drinker = true
        let smoker = false
		let sex: Sex = .Female
        let subUserJSON = "{\"identifier\" : \"user8723\", \"drinker\" : true, \"age\": 17, \"username\" : \"sub user\" }"
        
        let userJSONString = "{\"username\":\"\(username)\",\"identifier\":\"\(identifier)\",\"photoCount\":\(photoCount),\"age\":\(age),\"drinker\":\(drinker),\"smoker\":\(smoker), \"sex\":\"\(sex.rawValue)\", \"arr\":[ \"bla\", true, 42 ], \"dict\":{ \"key1\" : \"value1\", \"key2\" : false, \"key3\" : 142 }, \"arrOpt\":[ \"bla\", true, 42 ], \"dictOpt\":{ \"key1\" : \"value1\", \"key2\" : false, \"key3\" : 142 }, \"weight\": \(weight), \"float\": \(float), \"friend\": \(subUserJSON), \"friendDictionary\":{ \"bestFriend\": \(subUserJSON)}}"

		let user = userMapper.map(JSONString: userJSONString)!
		
		XCTAssertNotNil(user)
		XCTAssertEqual(username, user.username)
		XCTAssertEqual(identifier, user.identifier)
		XCTAssertEqual(photoCount, user.photoCount)
		XCTAssertEqual(age, user.age)
		XCTAssertEqual(weight, user.weight)
		XCTAssertEqual(float, user.float)
		XCTAssertEqual(drinker, user.drinker)
		XCTAssertEqual(smoker, user.smoker)
		XCTAssertEqual(sex, user.sex)

		//print(Mapper().toJSONString(user, prettyPrint: true))
    }
	
	func testOptionalStringParsing() {
		let username = "John Doe"
		let identifier = "user8723"
		let photoCount = 13
		let age = 1227
		let weight = 123.23
		let float: Float = 123.231
		let drinker = true
		let smoker = false
		let sex: Sex = .Female
		let subUserJSON = "{\"identifier\" : \"user8723\", \"drinker\" : true, \"age\": 17, \"username\" : \"sub user\" }"
		
		let userJSONString: String? = "{\"username\":\"\(username)\",\"identifier\":\"\(identifier)\",\"photoCount\":\(photoCount),\"age\":\(age),\"drinker\":\(drinker),\"smoker\":\(smoker), \"sex\":\"\(sex.rawValue)\", \"arr\":[ \"bla\", true, 42 ], \"dict\":{ \"key1\" : \"value1\", \"key2\" : false, \"key3\" : 142 }, \"arrOpt\":[ \"bla\", true, 42 ], \"dictOpt\":{ \"key1\" : \"value1\", \"key2\" : false, \"key3\" : 142 }, \"weight\": \(weight), \"float\": \(float), \"friend\": \(subUserJSON), \"friendDictionary\":{ \"bestFriend\": \(subUserJSON)}}"
		
		let user = userMapper.map(JSONString: userJSONString!)!
		
		XCTAssertNotNil(user)
		XCTAssertEqual(username, user.username)
		XCTAssertEqual(identifier, user.identifier)
		XCTAssertEqual(photoCount, user.photoCount)
		XCTAssertEqual(age, user.age)
		XCTAssertEqual(weight, user.weight)
		XCTAssertEqual(float, user.float)
		XCTAssertEqual(drinker, user.drinker)
		XCTAssertEqual(smoker, user.smoker)
		XCTAssertEqual(sex, user.sex)
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
		let sex: Sex = .Female
        let subUserJSON = "{\"identifier\" : \"user8723\", \"drinker\" : true, \"age\": 17, \"username\" : \"sub user\" }"
        
        let userJSONString = "{\"username\":\"\(username)\",\"identifier\":\"\(identifier)\",\"photoCount\":\(photoCount),\"age\":\(age),\"drinker\":\(drinker),\"smoker\":\(smoker), \"sex\":\"\(sex.rawValue)\", \"arr\":[ \"bla\", true, 42 ], \"dict\":{ \"key1\" : \"value1\", \"key2\" : false, \"key3\" : 142 }, \"arrOpt\":[ \"bla\", true, 42 ], \"dictOpt\":{ \"key1\" : \"value1\", \"key2\" : false, \"key3\" : 142 },\"weight\": \(weight), \"float\": \(float), \"friend\": \(subUserJSON), \"friendDictionary\":{ \"bestFriend\": \(subUserJSON)}}"
        
		let user = Mapper().map(JSONString: userJSONString, toObject: User())

		XCTAssertEqual(username, user.username)
		XCTAssertEqual(identifier, user.identifier)
		XCTAssertEqual(photoCount, user.photoCount)
		XCTAssertEqual(age, user.age)
		XCTAssertEqual(weight, user.weight)
		XCTAssertEqual(float, user.float)
		XCTAssertEqual(drinker, user.drinker)
		XCTAssertEqual(smoker, user.smoker)
		XCTAssertEqual(sex, user.sex)
        //print(Mapper().toJSONString(user, prettyPrint: true))
    }
    
    func testDictionaryParsing() {
        let name: String = "Genghis khan"
        let UUID: String = "12345"
        let major: Int = 99
        let minor: Int = 1
        let json: [String: Any] = ["name": name, "UUID": UUID, "major": major]
        
        //test that the sematics of value types works as expected.  the resulting maped student
        //should have the correct minor property set even thoug it's not mapped
        var s = Student()
        s.minor = minor
        let student = Mapper().map(JSON: json, toObject: s)

		XCTAssertEqual(name, student.name)
		XCTAssertEqual(UUID, student.UUID)
		XCTAssertEqual(major, student.major)
		XCTAssertEqual(minor, student.minor)

        //Test that mapping a reference type works as expected while not relying on the return value
        let username: String = "Barack Obama"
        let identifier: String = "Political"
        let photoCount: Int = 1000000000
        
        let json2: [String: Any] = ["username": username, "identifier": identifier, "photoCount": photoCount]
        let user = User()
        _ = Mapper().map(JSON: json2, toObject: user)
		
		XCTAssertEqual(username, user.username)
		XCTAssertEqual(identifier, user.identifier)
		XCTAssertEqual(photoCount, user.photoCount)
    }
    
	func testNullObject() {
		let JSONString = "{\"username\":\"bob\"}"

		let user = userMapper.map(JSONString: JSONString)
		
		XCTAssertNotNil(user)
		XCTAssertNil(user?.age)
	}
	
    func testToJSONAndBack(){
        let user = User()
        user.username = "tristan_him"
        user.identifier = "tristan_him_identifier"
        user.photoCount = 0
        user.age = 28
        user.weight = 150
        user.drinker = true
        user.smoker = false
			  user.sex = .Female
        user.arr = ["cheese", 11234]
		
        let JSONString = Mapper().toJSONString(user, prettyPrint: true)
        //print(JSONString)

		let parsedUser = userMapper.map(JSONString: JSONString!)!
		
		XCTAssertNotNil(parsedUser)
		XCTAssertEqual(user.identifier, parsedUser.identifier)
		XCTAssertEqual(user.photoCount, parsedUser.photoCount)
		XCTAssertEqual(user.age, parsedUser.age)
		XCTAssertEqual(user.weight, parsedUser.weight)
		XCTAssertEqual(user.drinker, parsedUser.drinker)
		XCTAssertEqual(user.smoker, parsedUser.smoker)
		XCTAssertEqual(user.sex, parsedUser.sex)
    }
	
	func testToJSONArrayAndBack(){
		let user = User()
		user.username = "tristan_him"
		user.identifier = "tristan_him_identifier"
		user.photoCount = 0
		user.age = 28
		user.weight = 150
		user.drinker = true
		user.smoker = false
		user.sex = .Female
		user.arr = ["cheese", 11234]
		let users = [user, user, user]
		
		//print(JSONString)
		let JSONString = Mapper().toJSONString(users)
		let parsedUsers = userMapper.mapArray(JSONString: JSONString!)

		XCTAssertNotNil(parsedUsers)
		XCTAssertTrue(parsedUsers?.count == 3)
		XCTAssertEqual(user.identifier, parsedUsers?[0].identifier)
		XCTAssertEqual(user.photoCount, parsedUsers?[0].photoCount)
		XCTAssertEqual(user.age, parsedUsers?[0].age)
		XCTAssertEqual(user.weight, parsedUsers?[0].weight)
		XCTAssertEqual(user.drinker, parsedUsers?[0].drinker)
		XCTAssertEqual(user.smoker, parsedUsers?[0].smoker)
		XCTAssertEqual(user.sex, parsedUsers?[0].sex)
	}

    func testUnknownPropertiesIgnored() {
        let JSONString = "{\"username\":\"bob\",\"identifier\":\"bob1987\", \"foo\" : \"bar\", \"fooArr\" : [ 1, 2, 3], \"fooObj\" : { \"baz\" : \"qux\" } }"

		let user = userMapper.map(JSONString: JSONString)

		XCTAssertNotNil(user)
    }
    
    func testInvalidJsonResultsInNilObject() {
        let JSONString = "{\"username\":\"bob\",\"identifier\":\"bob1987\"" // missing ending brace

        let user = userMapper.map(JSONString: JSONString)

		XCTAssertNil(user)
    }
	
	func testMapArrayJSON(){
		let name1 = "Bob"
		let name2 = "Jane"
		
		let JSONString = "[{\"name\": \"\(name1)\", \"UUID\": \"3C074D4B-FC8C-4CA2-82A9-6E9367BBC875\", \"major\": 541, \"minor\": 123},{ \"name\": \"\(name2)\", \"UUID\": \"3C074D4B-FC8C-4CA2-82A9-6E9367BBC876\", \"major\": 54321,\"minor\": 13 }]"
	
		let students = Mapper<Student>().mapArray(JSONString: JSONString)

		XCTAssertTrue(students?.count ?? 0 > 0)
		XCTAssertTrue(students?.count == 2)
		XCTAssertEqual(students?[0].name, name1)
		XCTAssertEqual(students?[1].name, name2)
	}

	// test mapArray() with JSON string that is not an array form
	// should return a collection with one item
	func testMapArrayJSONWithNoArray(){
		let name1 = "Bob"
		
		let JSONString = "{\"name\": \"\(name1)\", \"UUID\": \"3C074D4B-FC8C-4CA2-82A9-6E9367BBC875\", \"major\": 541, \"minor\": 123}"
		
		let students = Mapper<Student>().mapArray(JSONString: JSONString)

		XCTAssertTrue(students?.count ?? 0 > 0)
		XCTAssertTrue(students?.count == 1)
		XCTAssertEqual(students?[0].name, name1)
	}

	func testMapArrayJSONWithEmptyArray() {
		let JSONString = "[]"

		let students = Mapper<Student>().mapArray(JSONString: JSONString)

		XCTAssertNotNil(students)
		XCTAssertTrue(students?.count == 0)
	}

	func testArrayOfCustomObjects(){
		let percentage1: Double = 0.1
		let percentage2: Double = 1792.41
		
		let JSONString = "{ \"tasks\": [{\"taskId\":103,\"percentage\":\(percentage1)},{\"taskId\":108,\"percentage\":\(percentage2)}] }"
		
		let plan = Mapper<Plan>().map(JSONString: JSONString)

		let tasks = plan?.tasks
		
		XCTAssertNotNil(tasks)
		XCTAssertEqual(tasks?[0].percentage, percentage1)
		XCTAssertEqual(tasks?[1].percentage, percentage2)
	}

	func testDictionaryOfArrayOfCustomObjects(){
		let percentage1: Double = 0.1
		let percentage2: Double = 1792.41
		
		let JSONString = "{ \"dictionaryOfTasks\": { \"mondayTasks\" :[{\"taskId\":103,\"percentage\":\(percentage1)},{\"taskId\":108,\"percentage\":\(percentage2)}] } }"
		
		let plan = Mapper<Plan>().map(JSONString: JSONString)
		
		let dictionaryOfTasks = plan?.dictionaryOfTasks
		XCTAssertNotNil(dictionaryOfTasks)
		XCTAssertEqual(dictionaryOfTasks?["mondayTasks"]?[0].percentage, percentage1)
		XCTAssertEqual(dictionaryOfTasks?["mondayTasks"]?[1].percentage, percentage2)
		
		let planToJSON = Mapper().toJSONString(plan!, prettyPrint: true)
		//print(planToJSON!)
		let planFromJSON = Mapper<Plan>().map(JSONString: planToJSON!)

		let dictionaryOfTasks2 = planFromJSON?.dictionaryOfTasks
		XCTAssertNotNil(dictionaryOfTasks2)
		XCTAssertEqual(dictionaryOfTasks2?["mondayTasks"]?[0].percentage, percentage1)
		XCTAssertEqual(dictionaryOfTasks2?["mondayTasks"]?[1].percentage, percentage2)
	}
	
	func testArrayOfEnumObjects(){
		let a: ExampleEnum = .a
		let b: ExampleEnum = .b
		let c: ExampleEnum = .c

		let JSONString = "{ \"enums\": [\(a.rawValue), \(b.rawValue), \(c.rawValue)] }"

		let enumArray = Mapper<ExampleEnumArray>().map(JSONString: JSONString)
		let enums = enumArray?.enums
		
		XCTAssertNotNil(enums)
		XCTAssertTrue(enums?.count == 3)
		XCTAssertEqual(enums?[0], a)
		XCTAssertEqual(enums?[1], b)
		XCTAssertEqual(enums?[2], c)
	}

	func testDictionaryOfCustomObjects(){
		let percentage1: Double = 0.1
		let percentage2: Double = 1792.41
		
		let JSONString = "{\"tasks\": { \"task1\": {\"taskId\":103,\"percentage\":\(percentage1)}, \"task2\": {\"taskId\":108,\"percentage\":\(percentage2)}}}"
		
		let taskDict = Mapper<TaskDictionary>().map(JSONString: JSONString)
		
		let task = taskDict?.tasks?["task1"]
		XCTAssertNotNil(task)
		XCTAssertEqual(task?.percentage, percentage1)
	}

	func testDictionryOfEnumObjects(){
		let a: ExampleEnum = .a
		let b: ExampleEnum = .b
		let c: ExampleEnum = .c

		let JSONString = "{ \"enums\": {\"A\": \(a.rawValue), \"B\": \(b.rawValue), \"C\": \(c.rawValue)} }"

		let enumDict = Mapper<ExampleEnumDictionary>().map(JSONString: JSONString)
		let enums = enumDict?.enums
		
		XCTAssertNotNil(enums)
		XCTAssertTrue(enums?.count == 3)
	}

	func testDoubleParsing(){
		let percentage1: Double = 1792.41
		
		let JSONString = "{\"taskId\":103,\"percentage\":\(percentage1)}"
		
		let task = Mapper<Task>().map(JSONString: JSONString)

		XCTAssertNotNil(task)
		XCTAssertEqual(task?.percentage, percentage1)
	}

	func testToJSONArray(){
		let task1 = Task()
		task1.taskId = 1
		task1.percentage = 11.1
		let task2 = Task()
		task2.taskId = 2
		task2.percentage = 22.2
		let task3 = Task()
		task3.taskId = 3
		task3.percentage = 33.3
		
		let taskArray = [task1, task2, task3]
		
		let JSONArray = Mapper().toJSONArray(taskArray)
		
		let taskId1 = JSONArray[0]["taskId"] as? Int
		let percentage1 = JSONArray[0]["percentage"] as? Double

		XCTAssertEqual(taskId1, task1.taskId)
		XCTAssertEqual(percentage1, task1.percentage)

		let taskId2 = JSONArray[1]["taskId"] as? Int
		let percentage2 = JSONArray[1]["percentage"] as? Double
		
		XCTAssertEqual(taskId2, task2.taskId)
		XCTAssertEqual(percentage2, task2.percentage)

		let taskId3 = JSONArray[2]["taskId"] as? Int
		let percentage3 = JSONArray[2]["percentage"] as? Double
		
		XCTAssertEqual(taskId3, task3.taskId)
		XCTAssertEqual(percentage3, task3.percentage)
	}
	
	func testArrayOfArrayOfMappable() {
		let base1 = "1"
		let base2 = "2"
		let base3 = "3"
		let base4 = "4"
		
		let array1 = [["base": base1], ["base": base2], ["base": base3]]
		let array2 = [["base": base4]]
		let JSON = ["twoDimensionalArray":[array1, array2]]
		
		let arrayTest = Mapper<ArrayTest>().map(JSON: JSON)
		
		XCTAssertNotNil(arrayTest)
		XCTAssertEqual(arrayTest?.twoDimensionalArray?[0][0].base, base1)
		XCTAssertEqual(arrayTest?.twoDimensionalArray?[0][1].base, base2)
		XCTAssertEqual(arrayTest?.twoDimensionalArray?[0][2].base, base3)
		XCTAssertEqual(arrayTest?.twoDimensionalArray?[1][0].base, base4)
		
		XCTAssertEqual(arrayTest?.twoDimensionalArray?[0].count, array1.count)
		XCTAssertEqual(arrayTest?.twoDimensionalArray?[1].count, array2.count)
		
		let backToJSON = Mapper<ArrayTest>().toJSON(arrayTest!)
		XCTAssertNotNil(backToJSON)
		
		let arrayTest2 = Mapper<ArrayTest>().map(JSON: backToJSON)
		XCTAssertNotNil(arrayTest2)
		XCTAssertEqual(arrayTest2?.twoDimensionalArray?[0][0].base, arrayTest?.twoDimensionalArray?[0][0].base)
		XCTAssertEqual(arrayTest2?.twoDimensionalArray?[0][1].base, arrayTest?.twoDimensionalArray?[0][1].base)
	}

	func testShouldPreventOverwritingMappableProperty() {
		let json: [String: Any] = [
			"name": "Entry 1",
			"bigList": [["name": "item 1"], ["name": "item 2"], ["name": "item 3"]]
		]
		let model = CachedModel()
		_ = Mapper().map(JSON: json, toObject: model)

		XCTAssertEqual(model.name, "Entry 1")
		XCTAssertEqual(model.bigList?.count, 3)

		let json2: [String: Any] = ["name": "Entry 1"]
		_ = Mapper().map(JSON: json2, toObject: model)

		XCTAssertEqual(model.name, "Entry 1")
		XCTAssertEqual(model.bigList?.count, 3)
	}
}

class Status: Mappable {
	var status: Int?
	
	required init?(map: Map){
		
	}

	func mapping(map: Map) {
		status <- map["code"]
	}
}

class Plan: Mappable {
	var tasks: [Task]?
	var dictionaryOfTasks: [String: [Task]]?
	
	required init?(map: Map){
		
	}
	
	func mapping(map: Map) {
		tasks <- map["tasks"]
		dictionaryOfTasks <- map["dictionaryOfTasks"]
	}
}

class Task: Mappable {
	var taskId: Int?
	var percentage: Double?
	
	init(){
		
	}
	
	required init?(map: Map){
		
	}

	func mapping(map: Map) {
		taskId <- map["taskId"]
		percentage <- map["percentage"]
	}
}

class TaskDictionary: Mappable {
	var test: String?
	var tasks: [String : Task]?
	
	required init?(map: Map){
		
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
	
	init(){
		
	}
	
	init?(map: Map){
		
	}

	mutating func mapping(map: Map) {
		name <- map["name"]
		UUID <- map["UUID"]
		major <- map["major"]
		minor <- map["minor"]
	}
}

enum Sex: String {
	case Male = "Male"
	case Female = "Female"
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
  	var sex: Sex?
    var arr: [Any] = []
    var arrOptional: [Any]?
    var dict: [String : Any] = [:]
    var dictOptional: [String : Any]?
	var dictString: [String : String]?
    var friendDictionary: [String : User]?
    var friend: User?
    var friends: [User]? = []

	init(){
		
	}
	
	required init?(map: Map){
		
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
		sex              <- map["sex"]
		arr              <- map["arr"]
		arrOptional      <- map["arrOpt"]
		dict             <- map["dict"]
		dictOptional     <- map["dictOpt"]
		friend           <- map["friend"]
		friends          <- map["friends"]
		friendDictionary <- map["friendDictionary"]
		dictString		 <- map["dictString"]
	}
}


enum ExampleEnum: Int {
	case a
	case b
	case c
}

class ExampleEnumArray: Mappable {
	var enums: [ExampleEnum] = []

	required init?(map: Map){
		
	}

	func mapping(map: Map) {
		enums <- map["enums"]
	}
}

class ExampleEnumDictionary: Mappable {
	var enums: [String: ExampleEnum] = [:]

	required init?(map: Map){
		
	}

	func mapping(map: Map) {
		enums <- map["enums"]
	}
}

class ArrayTest: Mappable {
	
	var twoDimensionalArray: Array<Array<Base>>?
	
	required init?(map: Map){}
	
	func mapping(map: Map) {
		twoDimensionalArray <- map["twoDimensionalArray"]
	}
}

class CachedModel: Mappable {
	var name: String?
	var bigList: [CachedItem]?

	init() {}

	required init?(map: Map){}

	func mapping(map: Map) {
		name <- map["name"]
		bigList <- map["bigList"]
	}
}

struct CachedItem: Mappable {
	var name: String?

	init?(map: Map){}

	mutating func mapping(map: Map) {
		name <- map["name"]
	}
}
