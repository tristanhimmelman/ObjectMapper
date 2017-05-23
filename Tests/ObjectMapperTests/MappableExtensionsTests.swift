//
//  MappableExtensionsTests.swift
//  ObjectMapper
//
//  Created by Scott Hoyt on 10/25/15.
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

struct TestMappable: Mappable, Equatable, Hashable {
	static let valueForString = "This string should work"
	static let workingJSONString = "{ \"value\" : \"\(valueForString)\" }"
	static let workingJSON: [String: Any] = ["value": valueForString]
	static let workingJSONArrayString = "[\(workingJSONString)]"
	
	var value: String?
	
	init() {}
	init?(map: Map) {	}
	
	mutating func mapping(map: Map) {
		value <- map["value"]
	}
	
	var hashValue: Int {
		if let value = value {
			return value.hashValue
		}
		return NSIntegerMax
	}
}

func ==(lhs: TestMappable, rhs: TestMappable) -> Bool {
	return lhs.value == rhs.value
}

class MappableExtensionsTests: XCTestCase {
	
	var testMappable: TestMappable!
	
	override func setUp() {
		super.setUp()
		testMappable = TestMappable()
		testMappable.value = TestMappable.valueForString
	}
	
	func testInitFromString() {
		let mapped = TestMappable(JSONString: TestMappable.workingJSONString)
		
		XCTAssertNotNil(mapped)
		XCTAssertEqual(mapped?.value, TestMappable.valueForString)
	}
	
	func testToJSONAndBack() {
		let mapped = TestMappable(JSON: testMappable.toJSON())
		XCTAssertEqual(mapped, testMappable)
	}
	
	func testArrayFromString() {
		let mapped = [TestMappable](JSONString: TestMappable.workingJSONArrayString)!
		XCTAssertEqual(mapped, [testMappable])
	}
	
	func testArrayToJSONAndBack() {
		let mapped = [TestMappable](JSONArray: [testMappable].toJSON())
		XCTAssertEqual(mapped, [testMappable])
	}
	
	func testSetInitFailsWithEmptyString() {
		XCTAssertNil(Set<TestMappable>(JSONString: ""))
	}
	
	func testSetFromString() {
		let mapped = Set<TestMappable>(JSONString: TestMappable.workingJSONArrayString)!
		XCTAssertEqual(mapped, Set<TestMappable>([testMappable]))
	}
	
	func testSetToJSONAndBack() {
		let mapped = Set<TestMappable>(JSONArray: Set([testMappable]).toJSON())
		XCTAssertEqual(mapped, [testMappable])
	}
}
