//
//  PerformanceTests.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2015-09-21.
//
//  The MIT License (MIT)
//
//  Copyright (c) 2014-2018 Tristan Himmelman
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
	
	let JSONTestString: String = {
		let subObjectJSON = "{\"string\":\"This is a string\", \"int\": 12,\"double\":12.27,\"float\":12.3212, \"bool\":false, \"arr\":[ \"bla\", true, 42 ], \"dict\":{ \"key1\" : \"value1\", \"key2\" : false, \"key3\" : 142 } }"
		
		let objectJSONString = "{\"string\":\"This is a string\", \"int\": 12,\"double\":12.27,\"float\":12.3212, \"bool\":false, \"arr\":[ \"bla\", true, 42 ], \"dict\":{ \"key1\" : \"value1\", \"key2\" : false, \"key3\" : 142 }, \"object\": \(subObjectJSON), \"objects\":{ \"key1\": \(subObjectJSON), \"key2\": \(subObjectJSON)}}"
		
		var JSONString = "["
		for _ in 0...1000 {
			JSONString += "\(objectJSONString),"
		}
		JSONString += "\(objectJSONString)]"
		return JSONString
	}()
	
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testPerformance() {
        self.measure {
            // Put the code you want to measure the time of here.
			_ = Mapper<PerformanceMappableObject>().mapArray(JSONString: self.JSONTestString)
        }
    }
	
	func testPerformanceCluster() {
		self.measure {
			// Put the code you want to measure the time of here.
			_ = Mapper<PerformanceStaticMappableObject>().mapArray(JSONString: self.JSONTestString)
		}
	}
	
	func testPerformanceImmutable() {
		self.measure {
			_ = try? Mapper<PerformanceImmutableMappableObject>().mapArray(JSONString: self.JSONTestString)
		}
	}
}

class PerformanceMappableObject: Mappable {
	
	var string: String?
	var int: Int?
	var double: Double?
	var float: Float?
	var bool: Bool?
	var array: [Any]?
	var dictionary: [String: Any]?
	var object: PerformanceMappableObject?
	var objects: [PerformanceMappableObject]?
	
	required init?(map: Map){
		
	}
	
	func mapping(map: Map) {
		string		<- map["string"]
		int			<- map["int"]
		double		<- map["double"]
		float		<- map["float"]
		bool		<- map["bool"]
		array		<- map["array"]
		dictionary	<- map["dictionary"]
		object		<- map["object"]
		objects		<- map["objects"]
	}
}

class PerformanceStaticMappableObject: StaticMappable {
	
	var string: String?
	var int: Int?
	var double: Double?
	var float: Float?
	var bool: Bool?
	var array: [Any]?
	var dictionary: [String: Any]?
	var object: PerformanceStaticMappableObject?
	var objects: [PerformanceStaticMappableObject]?
	
	static func objectForMapping(map: Map) -> BaseMappable? {
		return PerformanceStaticMappableObject()
	}
	
	func mapping(map: Map) {
		string		<- map["string"]
		int			<- map["int"]
		double		<- map["double"]
		float		<- map["float"]
		bool		<- map["bool"]
		array		<- map["array"]
		dictionary	<- map["dictionary"]
		object		<- map["object"]
		objects		<- map["objects"]
	}
}

class PerformanceImmutableMappableObject: ImmutableMappable {
	
	let string: String?
	let int: Int?
	let double: Double?
	let float: Float?
	let bool: Bool?
	let array: [Any]?
	let dictionary: [String: Any]?
	let object: PerformanceImmutableMappableObject?
	let objects: [PerformanceImmutableMappableObject]?

	required init(map: Map) throws {
		string = try map.value("string")
		int = try map.value("int")
		double = try map.value("double")
		float = try map.value("float")
		bool = try map.value("bool")
		array = try map.value("array")
		dictionary = try map.value("dictionary")
		object = try map.value("object")
		objects = try map.value("objects")
	}
	
	func mapping(map: Map) {
		string		>>> map["string"]
		int			>>> map["int"]
		double		>>> map["double"]
		float		>>> map["float"]
		bool		>>> map["bool"]
		array		>>> map["array"]
		dictionary	>>> map["dictionary"]
		object		>>> map["object"]
		objects		>>> map["objects"]
	}
}


