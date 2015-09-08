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
import Nimble

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
			"non.nested.key": "string",
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

					"int64Enum": 1000,
					"intEnum": 255,
					"doubleEnum": 100.0,
					"floatEnum": 100.0,
					"stringEnum": "String B",

					"nested": [
						"object": ["value": 987],
						"objectArray": [ ["value": 123], ["value": 456] ],
						"objectDict": ["key": ["value": 999]]
					]
				]
			]
		]

		let mapper = Mapper<NestedKeys>()

		let value: NestedKeys! = mapper.map(JSON)
		expect(value).notTo(beNil())
		
		let JSONFromValue = mapper.toJSON(value)
		let valueFromParsedJSON: NestedKeys! = mapper.map(JSONFromValue)
		expect(valueFromParsedJSON).notTo(beNil())

		expect(value.nonNestedString!).to(equal(valueFromParsedJSON.nonNestedString))
		
		expect(value.int64).to(equal(valueFromParsedJSON.int64))
		expect(value.bool).to(equal(valueFromParsedJSON.bool))
		expect(value.int).to(equal(valueFromParsedJSON.int))
		expect(value.double).to(equal(valueFromParsedJSON.double))
		expect(value.float).to(equal(valueFromParsedJSON.float))
		expect(value.string).to(equal(valueFromParsedJSON.string))

		expect(value.int64Array).to(equal(valueFromParsedJSON.int64Array))
		expect(value.boolArray).to(equal(valueFromParsedJSON.boolArray))
		expect(value.intArray).to(equal(valueFromParsedJSON.intArray))
		expect(value.doubleArray).to(equal(valueFromParsedJSON.doubleArray))
		expect(value.floatArray).to(equal(valueFromParsedJSON.floatArray))
		expect(value.stringArray).to(equal(valueFromParsedJSON.stringArray))

		expect(value.int64Dict).to(equal(valueFromParsedJSON.int64Dict))
		expect(value.boolDict).to(equal(valueFromParsedJSON.boolDict))
		expect(value.intDict).to(equal(valueFromParsedJSON.intDict))
		expect(value.doubleDict).to(equal(valueFromParsedJSON.doubleDict))
		expect(value.floatDict).to(equal(valueFromParsedJSON.floatDict))
		expect(value.stringDict).to(equal(valueFromParsedJSON.stringDict))

		expect(value.int64Enum).to(equal(valueFromParsedJSON.int64Enum))
		expect(value.intEnum).to(equal(valueFromParsedJSON.intEnum))
		expect(value.doubleEnum).to(equal(valueFromParsedJSON.doubleEnum))
		expect(value.floatEnum).to(equal(valueFromParsedJSON.floatEnum))
		expect(value.stringEnum).to(equal(valueFromParsedJSON.stringEnum))

		expect(value.object).to(equal(valueFromParsedJSON.object))
		expect(value.objectArray).to(equal(valueFromParsedJSON.objectArray))
		expect(value.objectDict).to(equal(valueFromParsedJSON.objectDict))
	}

}

class NestedKeys: Mappable {
	
	var nonNestedString: String?
	
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

	var int64Enum: Int64Enum?
	var intEnum: IntEnum?
	var doubleEnum: DoubleEnum?
	var floatEnum: FloatEnum?
	var stringEnum: StringEnum?

	var object: Object?
	var objectArray: [Object] = []
	var objectDict: [String: Object] = [:]

	required init?(_ map: Map){
		
	}

	func mapping(map: Map) {
		nonNestedString <- map["non.nested.key", nested: false]
		
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

		int64Enum	<- map["nested.nested.int64Enum"]
		intEnum		<- map["nested.nested.intEnum"]
		doubleEnum	<- map["nested.nested.doubleEnum"]
		floatEnum	<- map["nested.nested.floatEnum"]
		stringEnum	<- map["nested.nested.stringEnum"]

		object		<- map["nested.nested.nested.object"]
		objectArray	<- map["nested.nested.nested.objectArray"]
		objectDict	<- map["nested.nested.nested.objectDict"]
	}
}

class Object: Mappable, Equatable {
	var value: Int = Int.min
	
	required init?(_ map: Map){
		
	}
	
	func mapping(map: Map) {
		value <- map["value"]
	}
}

func == (lhs: Object, rhs: Object) -> Bool {
	return lhs.value == rhs.value
}

enum Int64Enum: NSNumber {
	case A = 0
	case B = 1000
}

enum IntEnum: Int {
	case A = 0
	case B = 255
}

enum DoubleEnum: Double {
	case A = 0.0
	case B = 100.0
}

enum FloatEnum: Float {
	case A = 0.0
	case B = 100.0
}

enum StringEnum: String {
	case A = "String A"
	case B = "String B"
}
