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
        let link = NSURL(string: "http://www.example.com/")!
        
        let subUserJSON = "{\"identifier\" : \"user8723\", \"drinker\" : true, \"age\": 17,\"birthdayOpt\" : 1398956159, \"username\" : \"sub user\" }"
        
        let userJSONString = "{\"username\":\"\(username)\",\"identifier\":\"\(identifier)\",\"photoCount\":\(photoCount),\"age\":\(age),\"drinker\":\(drinker),\"smoker\":\(smoker), \"arr\":[ \"bla\", true, 42 ], \"dict\":{ \"key1\" : \"value1\", \"key2\" : false, \"key3\" : 142 }, \"arrOpt\":[ \"bla\", true, 42 ], \"dictOpt\":{ \"key1\" : \"value1\", \"key2\" : false, \"key3\" : 142 }, \"birthday\": 1398956159, \"birthdayOpt\": 1398956159, \"link\": \"http://www.example.com/\", \"weight\": \(weight), \"float\": \(float), \"friend\": \(subUserJSON), \"friendDictionary\":{ \"bestFriend\": \(subUserJSON)}}"
        
        let mapper = Mapper()
        let user = mapper.map(userJSONString, to: User.self)
        
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
        XCTAssertEqual(link, user.link!, "link should be the same")
        
        println(mapper.toJSONString(user, prettyPrint: true))
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
//        XCTAssert(user.birthday.compare(parsedUser.birthday) == .OrderedSame, "Birthday should be the same")
        
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
    var link: NSURL?
    
    required init() {
        friends = []
    }
    
    class func map(mapper: Mapper, object: User) {
        object.username         <= mapper["username"]
        object.identifier       <= mapper["identifier"]
        object.photoCount       <= mapper["photoCount"]
        object.age              <= mapper["age"]
        object.weight           <= mapper["weight"]
        object.float            <= mapper["float"]
        object.drinker          <= mapper["drinker"]
        object.smoker           <= mapper["smoker"]
        object.arr              <= mapper["arr"]
        object.arrOptional      <= mapper["arrOpt"]
        object.dict             <= mapper["dict"]
        object.dictOptional     <= mapper["dictOpt"]
        object.friend           <= mapper["friend"]
        object.friends          <= mapper["friends"]
        object.friendDictionary <= mapper["friendDictionary"]
        object.birthday         <= (mapper["birthday"], DateTransform<NSDate, Double>())
        object.birthdayOpt      <= (mapper["birthdayOpt"], DateTransform<NSDate, Double>())
        object.link             <= (mapper["link"], URLTransform<NSURL, String>())
    }
    
    var description : String {
        return "username: \(username) \nid:\(identifier) \nage: \(age) \nphotoCount: \(photoCount) \ndrinker: \(drinker) \nsmoker: \(smoker) \narr: \(arr) \narrOptional: \(arrOptional) \ndict: \(dict) \ndictOptional: \(dictOptional) \nfriend: \(friend)\nfriends: \(friends)\nbirthday: \(birthday)\nbirthdayOpt: \(birthdayOpt)\nlink: \(link)\nweight: \(weight)"
    }
}

class URLTransform<ObjectType, JSONType>: MapperTransform<ObjectType, JSONType> {
    
    override func transformFromJSON(value: AnyObject?) -> ObjectType? {
        if let str = value as? String {
            return (NSURL(string: str) as ObjectType)
        }
        return nil
    }
    
    override func transformToJSON(value: ObjectType?) -> JSONType? {
        if let url = value as? NSURL {
            return (url.absoluteString as JSONType)
        }
        return nil
    }
}
