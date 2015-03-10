//
//  NestedKeysTests.swift
//  ObjectMapper
//
//  Created by Syo Ikeda on 3/10/15.
//  Copyright (c) 2015 hearst. All rights reserved.
//

import Foundation
import XCTest
import ObjectMapper

class NestedKeysTests: XCTestCase {

	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}

	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}

	func testNestedKeys() {
		let JSON: [String: AnyObject] = [
			"nested": [
				"int64": NSNumber(longLong: INT64_MAX),
				"bool": true,
				"int": 255,
				"double": 100.0 as Double,
				"float": 50.0 as Float,
				"string": "String!",

				"nested": [
					"int64Array": [NSNumber(longLong: INT64_MAX), NSNumber(longLong: INT64_MAX - 1), NSNumber(longLong: INT64_MAX - 10)],
					"boolArray": [false, true, false],
					"intArray": [1, 2, 3],
					"doubleArray": [1.0, 2.0, 3.0],
					"floatArray": [1.0 as Float, 2.0 as Float, 3.0 as Float],
					"stringArray": ["123", "ABC"],

					"int64Dict": ["1": NSNumber(longLong: INT64_MAX)],
					"boolDict": ["2": true],
					"intDict": ["3": 999],
					"doubleDict": ["4": 999.999],
					"floatDict": ["5": 123.456 as Float],
					"stringDict": ["6": "InDict"],

					"nested": [
						"object": ["value": 987],
						"objectArray": [ ["value": 123], ["value": 456] ],
						"objectDict": ["key": ["value": 999]]
					]
				]
			]
		]

		let mapper = Mapper<NestedKeys>()

		let value = mapper.map(JSON)
		let JSONFromValue = mapper.toJSON(value)
		let valueFromParsedJSON = mapper.map(JSONFromValue)

		XCTAssert(value.int64 == valueFromParsedJSON.int64)
		XCTAssert(value.bool == valueFromParsedJSON.bool)
		XCTAssert(value.int == valueFromParsedJSON.int)
		XCTAssert(value.double == valueFromParsedJSON.double)
		XCTAssert(value.float == valueFromParsedJSON.float)
		XCTAssert(value.string == valueFromParsedJSON.string)

		XCTAssert(value.int64Array == valueFromParsedJSON.int64Array)
		XCTAssert(value.boolArray == valueFromParsedJSON.boolArray)
		XCTAssert(value.intArray == valueFromParsedJSON.intArray)
		XCTAssert(value.doubleArray == valueFromParsedJSON.doubleArray)
		XCTAssert(value.floatArray == valueFromParsedJSON.floatArray)
		XCTAssert(value.stringArray == valueFromParsedJSON.stringArray)

		XCTAssert(value.int64Dict == valueFromParsedJSON.int64Dict)
		XCTAssert(value.boolDict == valueFromParsedJSON.boolDict)
		XCTAssert(value.intDict == valueFromParsedJSON.intDict)
		XCTAssert(value.doubleDict == valueFromParsedJSON.doubleDict)
		XCTAssert(value.floatDict == valueFromParsedJSON.floatDict)
		XCTAssert(value.stringDict == valueFromParsedJSON.stringDict)

		XCTAssert(value.object == valueFromParsedJSON.object)
		XCTAssert(value.objectArray == valueFromParsedJSON.objectArray)
		XCTAssert(value.objectDict == valueFromParsedJSON.objectDict)
	}

}

class NestedKeys: Mappable {
	var int64: NSNumber?
	var bool: Bool?
	var int: Int?
	var double: Double?
	var float: Float?
	var string: String?

	var int64Array: [NSNumber] = []
	var boolArray: [Bool] = []
	var intArray: [Int] = []
	var doubleArray: [Double] = []
	var floatArray: [Float] = []
	var stringArray: [String] = []

	var int64Dict: [String: NSNumber] = [:]
	var boolDict: [String: Bool] = [:]
	var intDict: [String: Int] = [:]
	var doubleDict: [String: Double] = [:]
	var floatDict: [String: Float] = [:]
	var stringDict: [String: String] = [:]

	var object: Object?
	var objectArray: [Object] = []
	var objectDict: [String: Object] = [:]

	required init?(_ map: Map) {
		mapping(map)
	}

	func mapping(map: Map) {
		int64	<- map["nested.int64"]
		bool	<- map["nested.bool"]
		int		<- map["nested.int"]
		double	<- map["nested.double"]
		float	<- map["nested.float"]
		string	<- map["nested.string"]

		int64Array	<- map["nested.nested.int64Array"]
		boolArray	<- map["nested.nested.boolArray"]
		intArray	<- map["nested.nested.intArray"]
		doubleArray	<- map["nested.nested.doubleArray"]
		floatArray	<- map["nested.nested.floatArray"]
		stringArray	<- map["nested.nested.stringArray"]

		int64Dict	<- map["nested.nested.int64Dict"]
		boolDict	<- map["nested.nested.boolDict"]
		intDict		<- map["nested.nested.intDict"]
		doubleDict	<- map["nested.nested.doubleDict"]
		floatDict	<- map["nested.nested.floatDict"]
		stringDict	<- map["nested.nested.stringDict"]

		object		<- map["nested.nested.nested.object"]
		objectArray	<- map["nested.nested.nested.objectArray"]
		objectDict	<- map["nested.nested.nested.objectDict"]
	}
}

class Object: Mappable, Equatable {
	var value: Int = Int.min

	required init?(_ map: Map) {
		mapping(map)
	}

	func mapping(map: Map) {
		value <- map["value"]
	}
}

func == (lhs: Object, rhs: Object) -> Bool {
	return lhs.value == rhs.value
}
