//
//  MappableExtensionsTests.swift
//  ObjectMapper
//
//  Created by Scott Hoyt on 10/25/15.
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

class CustomDictionary<KeyType: Hashable, ValueType>: Mappable {
	var _dictionary: [KeyType: ValueType]

	init() {
		_dictionary = [:]
	}

	required init?(map: Map) {
		_dictionary = [:]
	}

	func mapping(map: Map) {
		_dictionary <- map["dict"]
	}

	subscript(key: KeyType) -> ValueType? {
		get {
			return _dictionary[key]
		}
		set {
			if newValue == nil {
				self.removeValueForKey(key: key)
			} else {
				self.updateValue(value: newValue!, forKey: key)
			}
		}
	}

	@discardableResult
	func updateValue(value: ValueType, forKey key: KeyType) -> ValueType? {
		let oldValue = _dictionary.updateValue(value, forKey: key)
		return oldValue
	}

	func removeValueForKey(key: KeyType) {
		_dictionary.removeValue(forKey: key)
	}
}

class CustomDictionaryWrapper: Mappable {
	private var foo: [String: CustomDictionary<String, TestMappable>] = [:]

	init(_ foo: [String: CustomDictionary<String, TestMappable>]) {
		self.foo = foo
	}

	required init?(map: Map) {
	}

	func mapping(map: Map) {
		foo <- map["questionSubmissions"]
	}
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
	
	func testCustomDictionary() {
		let customDict = CustomDictionary<String, TestMappable>()
		var firstMappable = TestMappable()
		firstMappable.value = "taco"
		customDict["first"] = firstMappable
		var secondMappable = TestMappable()
		secondMappable.value = "burrito"
		customDict["second"] = secondMappable
		var normalDict = [String: CustomDictionary<String, TestMappable>]()
		normalDict["foo"] = customDict
		let foo = CustomDictionaryWrapper(normalDict)
		let json = Mapper().toJSONString(foo)
		XCTAssertNotNil(json)
	}
}
