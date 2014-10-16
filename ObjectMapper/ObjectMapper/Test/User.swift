//
//  TopVideos.swift
//  BaseClient
//
//  Created by Tristan Himmelman on 2014-10-10.
//  Copyright (c) 2014 hearst. All rights reserved.
//

import UIKit

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
    var drinker: Bool = false
    var smoker: Bool?
    var arr: [AnyObject] = []
    var arrOptional: [AnyObject]?
    var dict: [String : AnyObject] = [:]
    var dictOptional: [String : AnyObject]?
    var friend: User?
    var friends: [User]? = []
    var gender: Gender?
    var birthdayInt: Int?
    var birthday: NSDate = NSDate()
    var birthdayOpt: NSDate = NSDate()
    
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
    
    class func testBasicParsing() {
        
        
        let testUsername = "John Doe"
        let testIdentifier = "user8723"
        let testPhoto = 13
        let testAge = 1227
        let testWeight = 123.23
        let testDrinker = true
        let testSmoker = false
        let testArray = [ "bla", true, 42 ]
        let testDirectory = [
            "key1" : "value1",
            "key2" : false,
            "key3" : 142
        ]
        
        var subUserJSONString = "{\"username\":\"\(testUsername)\",\"identifier\":\"\(testIdentifier)\",\"photoCount\":\(testPhoto),\"age\":\(testAge),\"drinker\":\(testDrinker),\"smoker\":\(testSmoker), \"arr\":[ \"bla\", true, 42 ]}"
        
        var friendsString = ",\"friend\" : \(subUserJSONString), \"friends\" : [\(subUserJSONString)]"
        
        let userJSONString = "{\"username\":\"\(testUsername)\",\"identifier\":\"\(testIdentifier)\",\"photoCount\":\(testPhoto),\"age\":\(testAge),\"drinker\":\(testDrinker),\"smoker\":\(testSmoker), \"arr\":[ \"bla\", true, 42 ], \"dict\":{ \"key1\" : \"value1\", \"key2\" : false, \"key3\" : 142 }, \"arrOpt\":[ \"bla\", true, 42 ], \"dictOpt\":{ \"key1\" : \"value1\", \"key2\" : false, \"key3\" : 142 }, \"birthday\": 1398956159, \"birthdayOpt\": 1398956160, \"weight\": \(testWeight)}"
        
        let mapper = Mapper()
        let parsedUser = mapper.map(userJSONString, to: User.self)
        
        println(parsedUser.description)
        
        
        let dict = mapper.toJSON(parsedUser)
        var err: NSError?
        if NSJSONSerialization.isValidJSONObject(dict) {
            var jsonData: NSData? = NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.PrettyPrinted, error: &err)
            if let error = err {
                println(error)
            }
            if let json = jsonData {
                var string = NSString(data: json, encoding: NSUTF8StringEncoding)
                println(string)
            }
        }
        
        //        println("\n\nJSON Dict:\n\(dict)")
        
        //        XCTAssertEqualObjects(testUsername, parsedUser.username, "Username should be the same")
        //        XCTAssertEqualObjects(testIdentifier, parsedUser.identifier, "Identifier should be the same")
        //        XCTAssertEqualObjects(testPhoto, parsedUser.photoCount, "photo count should be the same")
        //        XCTAssertEqualObjects(testAge, parsedUser.age, "Age should be the same")
        //        XCTAssertEqualObjects(testDrinker, parsedUser.drinker, "Should be drinking")
        //        XCTAssertEqualObjects(testSmoker, parsedUser.smoker, "Should be smoking")
        //        XCTAssertEqualObjects(testArray, parsedUser.arr, "Array should be the same")
        //        XCTAssertEqualObjects(testDirectory, parsedUser.dict, "Dictionary should be the same")
        //        XCTAssertEqualObjects(testArray, parsedUser.arrOptional, "Array should be the same")
        //        XCTAssertEqualObjects(testDirectory, parsedUser.dictOptional, "Dictionary should be the same")
    }
}
