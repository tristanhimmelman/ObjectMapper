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
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
//    func testExample() {
//        // This is an example of a functional test case.
//        XCTAssert(true, "Pass")
//    }
//    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock() {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
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
        let birthday = NSDate(timeIntervalSince1970: 1398956159)
        let directory = [
            "key1" : "value1",
            "key2" : false,
            "key3" : 142
        ]
        
        
        let subUserJSON = "{\"identifier\" : \"user8723\", \"drinker\" : true, \"age\": 17,\"birthdayOpt\" : 1398956159, \"username\" : \"sub user\" }"
        
        let userJSONString = "{\"username\":\"\(username)\",\"identifier\":\"\(identifier)\",\"photoCount\":\(photoCount),\"age\":\(age),\"drinker\":\(drinker),\"smoker\":\(smoker), \"arr\":[ \"bla\", true, 42 ], \"dict\":{ \"key1\" : \"value1\", \"key2\" : false, \"key3\" : 142 }, \"arrOpt\":[ \"bla\", true, 42 ], \"dictOpt\":{ \"key1\" : \"value1\", \"key2\" : false, \"key3\" : 142 }, \"birthday\": 1398956159, \"birthdayOpt\": 1398956159, \"weight\": \(weight), \"float\": \(float), \"friend\": \(subUserJSON), \"friendDictionary\":{ \"bestFriend\": \(subUserJSON)}}"
		
        let user = Mapper().map(userJSONString, to: User.self)
        
        XCTAssertEqual(username, user.username, "Username should be the same")
        XCTAssertEqual(identifier, user.identifier!, "Identifier should be the same")
        XCTAssertEqual(photoCount, user.photoCount, "PhotoCount should be the same")
        XCTAssertEqual(age, user.age!, "Age should be the same")
        XCTAssertEqual(weight, user.weight!, "Weight should be the same")
        XCTAssertEqual(float, user.float!, "float should be the same")
        XCTAssertEqual(drinker, user.drinker, "Drinker should be the same")
        XCTAssertEqual(smoker, user.smoker!, "Smoker should be the same")
        XCTAssertEqual(birthday, user.birthday, "Birthday should be the same")
        XCTAssertEqual(birthday, user.birthdayOpt!, "Birthday should be the same")
        
        println(Mapper().toJSONString(user, prettyPrint: true))
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
        user.birthday = NSDate()
        user.imageURL = NSURL(string: "http://google.com/image/1234")
        
        let json = Mapper().toJSONString(user, prettyPrint: true)
        println(json)
        var parsedUser = Mapper().map(json, to: User.self)
        
        XCTAssertEqual(user.username, parsedUser.username, "Username should be the same")
        XCTAssertEqual(user.identifier!, parsedUser.identifier!, "Identifier should be the same")
        XCTAssertEqual(user.photoCount, parsedUser.photoCount, "PhotoCount should be the same")
        XCTAssertEqual(user.age!, parsedUser.age!, "Age should be the same")
        XCTAssertEqual(user.weight!, parsedUser.weight!, "Weight should be the same")
        XCTAssertEqual(user.drinker, parsedUser.drinker, "Drinker should be the same")
        XCTAssertEqual(user.smoker!, parsedUser.smoker!, "Smoker should be the same")
        XCTAssertEqual(user.imageURL!, parsedUser.imageURL!, "Image URL should be the same")
//        XCTAssert(user.birthday.compare(parsedUser.birthday) == .OrderedSame, "Birthday should be the same")
        
    }
    
    func testUnknownPropertiesIgnored() {
        let userJSONString = "{\"username\":\"bob\",\"identifier\":\"bob1987\", \"foo\" : \"bar\", \"fooArr\" : [ 1, 2, 3], \"fooObj\" : { \"baz\" : \"qux\" } }"
        let user = Mapper().map(userJSONString, to: User.self)
        
        XCTAssert(user != nil, "User should not be nil")
    }
    
    func testInvalidJsonResultsInNilObject() {
        let userJSONString = "{\"username\":\"bob\",\"identifier\":\"bob1987\"" // missing ending brace

        let user = Mapper().map(userJSONString, to: User.self)
        
        XCTAssert(user == nil, "User should be nil due to invalid JSON")
    }
}

class User: MapperProtocol {
    
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
    var friendDictionary: [String : User]?
    var friend: User?
    var friends: [User]? = []
    var birthday: NSDate = NSDate()
    var birthdayOpt: NSDate?
    var imageURL: NSURL?
    
    required init() {
		
    }
	
	func map(mapper: Mapper) {
		username         <= mapper["username"]
		identifier       <= mapper["identifier"]
		photoCount       <= mapper["photoCount"]
		age              <= mapper["age"]
		weight           <= mapper["weight"]
		float            <= mapper["float"]
		drinker          <= mapper["drinker"]
		smoker           <= mapper["smoker"]
		arr              <= mapper["arr"]
		arrOptional      <= mapper["arrOpt"]
		dict             <= mapper["dict"]
		dictOptional     <= mapper["dictOpt"]
		friend           <= mapper["friend"]
		friends          <= mapper["friends"]
		friendDictionary <= mapper["friendDictionary"]
		birthday         <= (mapper["birthday"], DateTransform<NSDate, Double>())
		birthdayOpt      <= (mapper["birthdayOpt"], DateTransform<NSDate, Double>())
		imageURL         <= (mapper["imageURL"], URLTransform<NSURL, String>())
	}
	
    var description : String {
        return "username: \(username) \nid:\(identifier) \nage: \(age) \nphotoCount: \(photoCount) \ndrinker: \(drinker) \nsmoker: \(smoker) \narr: \(arr) \narrOptional: \(arrOptional) \ndict: \(dict) \ndictOptional: \(dictOptional) \nfriend: \(friend)\nfriends: \(friends)\nbirthday: \(birthday)\nbirthdayOpt: \(birthdayOpt)\nweight: \(weight)"
    }
}
