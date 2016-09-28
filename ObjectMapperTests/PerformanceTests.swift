//
//  PerformanceTests.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2015-09-21.
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

class PerformanceTests: XCTestCase {
	
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
	
	func createJSONString(_ count: Int = 1000) -> String {
		let subPersonJSON = "{\"identifier\" : \"user8723\", \"drinker\" : true, \"age\": 17, \"username\" : \"sub user\" }"
		
		let personJSONString = "{\"username\":\"John Doe\",\"identifier\":\"identifier\",\"photoCount\":12,\"age\":1227,\"drinker\":true,\"smoker\":false, \"arr\":[ \"bla\", true, 42 ], \"dict\":{ \"key1\" : \"value1\", \"key2\" : false, \"key3\" : 142 }, \"arrOpt\":[ \"bla\", true, 42 ], \"dictOpt\":{ \"key1\" : \"value1\", \"key2\" : false, \"key3\" : 142 }, \"weight\": 122.22, \"float\": 123.331, \"friend\": \(subPersonJSON), \"friendDictionary\":{ \"bestFriend\": \(subPersonJSON)}}"
		
		var JSONString = "["
		for _ in 0...count {
			JSONString += "\(personJSONString),"
		}
		JSONString += "\(personJSONString)]"
		return JSONString
	}
    
    func testPerformance() {
        let JSONString = createJSONString()
		
        self.measure {
            // Put the code you want to measure the time of here.
			_ = Mapper<Person>().mapArray(JSONString: JSONString)
        }
    }
	
	func testPerformanceCluster() {
		let JSONString = createJSONString()
		
		self.measure {
			// Put the code you want to measure the time of here.
			_ = Mapper<PersonCluster>().mapArray(JSONString: JSONString)
		}
	}
}

class Person: Mappable {
	
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
	var dict: [String: AnyObject] = [:]
	var dictKey1: String?
	var dictOptional: [String: AnyObject]?
	var dictString: [String: String]?
	var friendDictionary: [String: Person]?
	var friend: Person?
	var friends: [Person]? = []
	
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
		arr              <- map["arr"]
		arrOptional      <- map["arrOpt"]
		dict             <- map["dict"]
		dictKey1         <- map["dict.key1"]
		dictOptional     <- map["dictOpt"]
		friend           <- map["friend"]
		friends          <- map["friends"]
		friendDictionary <- map["friendDictionary"]
		dictString		 <- map["dictString"]
	}
}

class PersonCluster: StaticMappable {
	
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
	var dictKey1: String?
	var dictOptional: [String: AnyObject]?
	var dictString: [String: String]?
	var friendDictionary: [String: Person]?
	var friend: Person?
	var friends: [Person]? = []
	
	init(){
		
	}
	
	static func objectForMapping(map: Map) -> BaseMappable? {
		return PersonCluster()
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
		dictKey1         <- map["dict.key1"]
		dictOptional     <- map["dictOpt"]
		friend           <- map["friend"]
		friends          <- map["friends"]
		friendDictionary <- map["friendDictionary"]
		dictString		 <- map["dictString"]
	}
}
