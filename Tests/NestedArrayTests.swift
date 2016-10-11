//
//  NestedArrayTests.swift
//  ObjectMapper
//
//  Created by Ruben Samsonyan on 10/21/15.
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

class NestedArrayTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
	
	func testNestedArray() {
		let JSON: [String: Any] = [ "nested": [ ["value": 123], ["value": 456] ] ]
		
		let mapper = Mapper<NestedArray>()
		
		let value: NestedArray! = mapper.map(JSON: JSON)
		XCTAssertNotNil(value)
		
		let JSONFromValue = mapper.toJSON(value)
		let valueFromParsedJSON: NestedArray! = mapper.map(JSON: JSONFromValue)
		XCTAssertNotNil(valueFromParsedJSON)
		
		XCTAssertEqual(value.value_0, valueFromParsedJSON.value_0)
		XCTAssertEqual(value.value_1, valueFromParsedJSON.value_1)
	}
	
	func testNestedObjectArray() {
		let value = 456
		let JSON: [String: Any] = [ "nested": [ ["value": 123], ["value": value] ] ]
		
		let mapper = Mapper<NestedArray>()
		
		let mappedObject: NestedArray! = mapper.map(JSON: JSON)
		XCTAssertNotNil(mappedObject)
		
		XCTAssertEqual(mappedObject.nestedObject!.value, value)
		XCTAssertEqual(mappedObject.nestedObjectValue, value)
	}
}

class NestedArray: Mappable {
	
	var value_0: Int?
	var value_1: Int?
	
	var nestedObject: NestedObject?

	var nestedObjectValue: Int?
	
	required init?(map: Map){
		
	}
	
	func mapping(map: Map) {
		value_0	<- map["nested.0.value"]
		value_1	<- map["nested.1.value"]
		
		nestedObject <- map["nested.1"]
		nestedObjectValue <- map["nested.1.value"]
	}
}

class NestedObject: Mappable {
	var value: Int?
	
	required init?(map: Map){}
	
	func mapping(map: Map) {
		value	<- map["value"]
	}
}
