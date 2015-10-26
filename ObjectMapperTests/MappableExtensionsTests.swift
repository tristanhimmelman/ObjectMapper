//
//  MappableExtensionsTests.swift
//  ObjectMapper
//
//  Created by Scott Hoyt on 10/25/15.
//  Copyright © 2015 hearst. All rights reserved.
//

import Foundation
import XCTest
import ObjectMapper
import Nimble

struct TestMappable : Mappable, Equatable, Hashable {
	static let valueForString = "This string should work"
	static let workingJSONString = "{ \"value\" : \"\(valueForString)\" }"
	static let workingJSON: [String: AnyObject] = ["value" : valueForString]
	static let workingJSONArrayString = "[\(workingJSONString)]"
	
	var value: String?
	
	init() {}
	init?(_ map: Map) {	}
	
	mutating func mapping(map: Map) {
		value <- map["value"]
	}
	
	var hashValue: Int {
		if let value = value {
			return value.hashValue
		}
		return [].hashValue
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
	
	func testInitFailsWithNilString() {
		expect(TestMappable(JSONString: nil)).to(beNil())
	}
	
	func testInitFailsWithNilJSON() {
		expect(TestMappable(JSON: nil)).to(beNil())
	}
	
	func testInitFromString() {
		let mapped = TestMappable(JSONString: TestMappable.workingJSONString)
		expect(mapped).toNot(beNil())
		expect(mapped?.value).to(equal(TestMappable.valueForString))
	}
	
	func testToJSONAndBack() {
		let mapped = TestMappable(JSON: testMappable.toJSON())
		expect(mapped).to(equal(testMappable))
	}
	
	func testArrayInitFailsWithNilString() {
		expect([TestMappable](JSONString: nil)).to(beNil())
	}
	
	func testArrayInitFailsWithNilArray() {
		expect([TestMappable](JSONArray: nil)).to(beNil())
	}
	
	func testArrayFromString() {
		let mapped = [TestMappable](JSONString: TestMappable.workingJSONArrayString)!
		expect(mapped).to(equal([testMappable]))
	}
	
	func testArrayToJSONAndBack() {
		let mapped = [TestMappable](JSONArray: [testMappable].toJSON())
		expect(mapped).to(equal([testMappable]))
	}
	
	func testSetInitFailsWithEmptyString() {
		expect(Set<TestMappable>(JSONString: "")).to(beNil())
	}
	
	func testSetInitFailsWithNilArray() {
		expect(Set<TestMappable>(JSONArray: nil)).to(beNil())
	}
	
	func testSetFromString() {
		let mapped = Set<TestMappable>(JSONString: TestMappable.workingJSONArrayString)!
		expect(mapped).to(equal(Set<TestMappable>([testMappable])))
	}
	
	func testSetToJSONAndBack() {
		let mapped = Set<TestMappable>(JSONArray: Set([testMappable]).toJSON())
		expect(mapped).to(equal([testMappable]))
	}

}
