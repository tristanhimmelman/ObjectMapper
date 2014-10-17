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
        
        let userJSONString = "{\"username\":\"\(username)\",\"identifier\":\"\(identifier)\",\"photoCount\":\(photoCount),\"age\":\(age),\"drinker\":\(drinker),\"smoker\":\(smoker), \"arr\":[ \"bla\", true, 42 ], \"dict\":{ \"key1\" : \"value1\", \"key2\" : false, \"key3\" : 142 }, \"arrOpt\":[ \"bla\", true, 42 ], \"dictOpt\":{ \"key1\" : \"value1\", \"key2\" : false, \"key3\" : 142 }, \"birthday\": 1398956159, \"birthdayOpt\": 1398956159, \"weight\": \(weight), \"float\": \(float)}"
        
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
        
        let dict = mapper.toJSONString(user)
    }
}

class User: MapperProtocol {
    
    enum Gender: Int {
        case Male
        case Female
        case Other
    }
    
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
    var friend: User?
    var friends: [User]? = []
    var gender: Gender?
    var birthday: NSDate = NSDate()
    var birthdayOpt: NSDate?
    
    required init() {
        gender = .Male
        friends = []
    }
    
    class func map(mapper: Mapper, object: User) {
        object.username     <= mapper["username"]
        object.identifier   <= mapper["identifier"]
        object.photoCount   <= mapper["photoCount"]
        object.age          <= mapper["age"]
        object.weight       <= mapper["weight"]
        object.float        <= mapper["float"]
        object.drinker      <= mapper["drinker"]
        object.smoker       <= mapper["smoker"]
        object.arr          <= mapper["arr"]
        object.arrOptional  <= mapper["arrOpt"]
        object.dict         <= mapper["dict"]
        object.dictOptional <= mapper["dictOpt"]
        object.friend       <= mapper["friend"]
        object.friends      <= mapper["friends"]
        object.birthday     <= (mapper["birthday"], DateTransform<NSDate, Int>())
        object.birthdayOpt  <= (mapper["birthdayOpt"], DateTransform<NSDate, Int>())
    }
    
    var description : String {
        return "username: \(username) \nid:\(identifier) \nage: \(age) \nphotoCount: \(photoCount) \ndrinker: \(drinker) \nsmoker: \(smoker) \narr: \(arr) \narrOptional: \(arrOptional) \ndict: \(dict) \ndictOptional: \(dictOptional) \nfriend: \(friend)\nfriends: \(friends)\nbirthday: \(birthday)\nbirthdayOpt: \(birthdayOpt)\nfemale: \(gender)\nweight: \(weight)"
    }
}
