//
//  NestedKeysTests.swift
//  ObjectMapper
//
//  Created by Syo Ikeda on 3/10/15.
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
		let JSON: [String: Any] = [
			"non.nested.key": "string",
			"nested": [
				"int64": NSNumber(value: INT64_MAX),
				"bool": true,
				"int": 255,
				"double": 100.0 as Double,
				"float": 50.0 as Float,
				"string": "String!",

				"nested": [
					"int64Array": [NSNumber(value: INT64_MAX), NSNumber(value: INT64_MAX - 1), NSNumber(value: INT64_MAX - 10)],
					"boolArray": [false, true, false],
					"intArray": [1, 2, 3],
					"doubleArray": [1.0, 2.0, 3.0],
					"floatArray": [1.0 as Float, 2.0 as Float, 3.0 as Float],
					"stringArray": ["123", "ABC"],

					"int64Dict": ["1": NSNumber(value: INT64_MAX)],
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

		let value: NestedKeys! = mapper.map(JSONObject: JSON)
		XCTAssertNotNil(value)
		
		let JSONFromValue = mapper.toJSON(value)
		let valueFromParsedJSON: NestedKeys! = mapper.map(JSON: JSONFromValue)
		XCTAssertNotNil(valueFromParsedJSON)

		XCTAssertEqual(value.nonNestedString, valueFromParsedJSON.nonNestedString)
		
		XCTAssertEqual(value.int64, valueFromParsedJSON.int64)
		XCTAssertEqual(value.bool, valueFromParsedJSON.bool)
		XCTAssertEqual(value.int, valueFromParsedJSON.int)
		XCTAssertEqual(value.double, valueFromParsedJSON.double)
		XCTAssertEqual(value.float, valueFromParsedJSON.float)
		XCTAssertEqual(value.string, valueFromParsedJSON.string)

		XCTAssertEqual(value.int64Array, valueFromParsedJSON.int64Array)
		XCTAssertEqual(value.boolArray, valueFromParsedJSON.boolArray)
		XCTAssertEqual(value.intArray, valueFromParsedJSON.intArray)
		XCTAssertEqual(value.doubleArray, valueFromParsedJSON.doubleArray)
		XCTAssertEqual(value.floatArray, valueFromParsedJSON.floatArray)
		XCTAssertEqual(value.stringArray, valueFromParsedJSON.stringArray)

		XCTAssertEqual(value.int64Dict, valueFromParsedJSON.int64Dict)
		XCTAssertEqual(value.boolDict, valueFromParsedJSON.boolDict)
		XCTAssertEqual(value.intDict, valueFromParsedJSON.intDict)
		XCTAssertEqual(value.doubleDict, valueFromParsedJSON.doubleDict)
		XCTAssertEqual(value.floatDict, valueFromParsedJSON.floatDict)
		XCTAssertEqual(value.stringDict, valueFromParsedJSON.stringDict)

		XCTAssertEqual(value.int64Enum, valueFromParsedJSON.int64Enum)
		XCTAssertEqual(value.intEnum, valueFromParsedJSON.intEnum)
		XCTAssertEqual(value.doubleEnum, valueFromParsedJSON.doubleEnum)
		XCTAssertEqual(value.floatEnum, valueFromParsedJSON.floatEnum)
		XCTAssertEqual(value.stringEnum, valueFromParsedJSON.stringEnum)

		XCTAssertEqual(value.object, valueFromParsedJSON.object)
		XCTAssertEqual(value.objectArray, valueFromParsedJSON.objectArray)
		XCTAssertEqual(value.objectDict, valueFromParsedJSON.objectDict)
	}

	func testNestedKeysWithDelimiter() {
		let JSON: [String: Any] = [
			"non.nested->key": "string",
			"com.tristanhimmelman.ObjectMapper.nested": [
				"com.tristanhimmelman.ObjectMapper.int64": NSNumber(value: INT64_MAX),
				"com.tristanhimmelman.ObjectMapper.bool": true,
				"com.tristanhimmelman.ObjectMapper.int": 255,
				"com.tristanhimmelman.ObjectMapper.double": 100.0 as Double,
				"com.tristanhimmelman.ObjectMapper.float": 50.0 as Float,
				"com.tristanhimmelman.ObjectMapper.string": "String!",

				"com.tristanhimmelman.ObjectMapper.nested": [
					"int64Array": [NSNumber(value: INT64_MAX), NSNumber(value: INT64_MAX - 1), NSNumber(value: INT64_MAX - 10)],
					"boolArray": [false, true, false],
					"intArray": [1, 2, 3],
					"doubleArray": [1.0, 2.0, 3.0],
					"floatArray": [1.0 as Float, 2.0 as Float, 3.0 as Float],
					"stringArray": ["123", "ABC"],

					"int64Dict": ["1": NSNumber(value: INT64_MAX)],
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

					"com.tristanhimmelman.ObjectMapper.nested": [
						"object": ["value": 987],
						"objectArray": [ ["value": 123], ["value": 456] ],
						"objectDict": ["key": ["value": 999]]
					]
				]
			]
		]

		let mapper = Mapper<DelimiterNestedKeys>()

		let value: DelimiterNestedKeys! = mapper.map(JSONObject: JSON)
		XCTAssertNotNil(value)

		XCTAssertEqual(value.nonNestedString, "string")
		
		XCTAssertEqual(value.int64, NSNumber(value: INT64_MAX))
		XCTAssertEqual(value.bool, true)
		XCTAssertEqual(value.int, 255)
		XCTAssertEqual(value.double, 100.0 as Double)
		XCTAssertEqual(value.float, 50.0 as Float)
		XCTAssertEqual(value.string, "String!")

		let int64Array = [NSNumber(value: INT64_MAX), NSNumber(value: INT64_MAX - 1), NSNumber(value: INT64_MAX - 10)]
		XCTAssertEqual(value.int64Array, int64Array)
		XCTAssertEqual(value.boolArray, [false, true, false])
		XCTAssertEqual(value.intArray, [1, 2, 3])
		XCTAssertEqual(value.doubleArray, [1.0, 2.0, 3.0])
		XCTAssertEqual(value.floatArray, [1.0 as Float, 2.0 as Float, 3.0 as Float])
		XCTAssertEqual(value.stringArray, ["123", "ABC"])

		XCTAssertEqual(value.int64Dict, ["1": NSNumber(value: INT64_MAX)])
		XCTAssertEqual(value.boolDict, ["2": true])
		XCTAssertEqual(value.intDict, ["3": 999])
		XCTAssertEqual(value.doubleDict, ["4": 999.999])
		XCTAssertEqual(value.floatDict, ["5": 123.456 as Float])
		XCTAssertEqual(value.stringDict, ["6": "InDict"])

		XCTAssertEqual(value.int64Enum, Int64Enum.b)
		XCTAssertEqual(value.intEnum, IntEnum.b)
//		 Skip tests due to float issue - #591
//		XCTAssertEqual(value.doubleEnum, DoubleEnum.b)
//		XCTAssertEqual(value.floatEnum, FloatEnum.b)
		XCTAssertEqual(value.stringEnum, StringEnum.B)

		XCTAssertEqual(value.object?.value, 987)
		XCTAssertEqual(value.objectArray.map { $0.value }, [123, 456])
		XCTAssertEqual(value.objectDict["key"]?.value, 999)
		
		let JSONFromValue = mapper.toJSON(value)
		let valueFromParsedJSON: DelimiterNestedKeys! = mapper.map(JSON: JSONFromValue)
		XCTAssertNotNil(valueFromParsedJSON)

		XCTAssertEqual(value.nonNestedString, valueFromParsedJSON.nonNestedString)
		
		XCTAssertEqual(value.int64, valueFromParsedJSON.int64)
		XCTAssertEqual(value.bool, valueFromParsedJSON.bool)
		XCTAssertEqual(value.int, valueFromParsedJSON.int)
		XCTAssertEqual(value.double, valueFromParsedJSON.double)
		XCTAssertEqual(value.float, valueFromParsedJSON.float)
		XCTAssertEqual(value.string, valueFromParsedJSON.string)

		XCTAssertEqual(value.int64Array, valueFromParsedJSON.int64Array)
		XCTAssertEqual(value.boolArray, valueFromParsedJSON.boolArray)
		XCTAssertEqual(value.intArray, valueFromParsedJSON.intArray)
		XCTAssertEqual(value.doubleArray, valueFromParsedJSON.doubleArray)
		XCTAssertEqual(value.floatArray, valueFromParsedJSON.floatArray)
		XCTAssertEqual(value.stringArray, valueFromParsedJSON.stringArray)

		XCTAssertEqual(value.int64Dict, valueFromParsedJSON.int64Dict)
		XCTAssertEqual(value.boolDict, valueFromParsedJSON.boolDict)
		XCTAssertEqual(value.intDict, valueFromParsedJSON.intDict)
		XCTAssertEqual(value.doubleDict, valueFromParsedJSON.doubleDict)
		XCTAssertEqual(value.floatDict, valueFromParsedJSON.floatDict)
		XCTAssertEqual(value.stringDict, valueFromParsedJSON.stringDict)

		XCTAssertEqual(value.int64Enum, valueFromParsedJSON.int64Enum)
		XCTAssertEqual(value.intEnum, valueFromParsedJSON.intEnum)
		XCTAssertEqual(value.doubleEnum, valueFromParsedJSON.doubleEnum)
		XCTAssertEqual(value.floatEnum, valueFromParsedJSON.floatEnum)
		XCTAssertEqual(value.stringEnum, valueFromParsedJSON.stringEnum)

		XCTAssertEqual(value.object, valueFromParsedJSON.object)
		XCTAssertEqual(value.objectArray, valueFromParsedJSON.objectArray)
		XCTAssertEqual(value.objectDict, valueFromParsedJSON.objectDict)
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

	required init?(map: Map){
		
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

class DelimiterNestedKeys: NestedKeys {
	override func mapping(map: Map) {
		nonNestedString <- map["non.nested->key", nested: false, delimiter: "->"]

		int64   <- map["com.tristanhimmelman.ObjectMapper.nested->com.tristanhimmelman.ObjectMapper.int64", delimiter: "->"]
		bool    <- map["com.tristanhimmelman.ObjectMapper.nested->com.tristanhimmelman.ObjectMapper.bool", delimiter: "->"]
		int     <- map["com.tristanhimmelman.ObjectMapper.nested->com.tristanhimmelman.ObjectMapper.int", delimiter: "->"]
		double  <- map["com.tristanhimmelman.ObjectMapper.nested->com.tristanhimmelman.ObjectMapper.double", delimiter: "->"]
		float   <- map["com.tristanhimmelman.ObjectMapper.nested->com.tristanhimmelman.ObjectMapper.float", delimiter: "->"]
		string  <- map["com.tristanhimmelman.ObjectMapper.nested->com.tristanhimmelman.ObjectMapper.string", delimiter: "->"]

		int64Array  <- map["com.tristanhimmelman.ObjectMapper.nested->com.tristanhimmelman.ObjectMapper.nested->int64Array", delimiter: "->"]
		boolArray   <- map["com.tristanhimmelman.ObjectMapper.nested->com.tristanhimmelman.ObjectMapper.nested->boolArray", delimiter: "->"]
		intArray    <- map["com.tristanhimmelman.ObjectMapper.nested->com.tristanhimmelman.ObjectMapper.nested->intArray", delimiter: "->"]
		doubleArray <- map["com.tristanhimmelman.ObjectMapper.nested->com.tristanhimmelman.ObjectMapper.nested->doubleArray", delimiter: "->"]
		floatArray  <- map["com.tristanhimmelman.ObjectMapper.nested->com.tristanhimmelman.ObjectMapper.nested->floatArray", delimiter: "->"]
		stringArray <- map["com.tristanhimmelman.ObjectMapper.nested->com.tristanhimmelman.ObjectMapper.nested->stringArray", delimiter: "->"]

		int64Dict   <- map["com.tristanhimmelman.ObjectMapper.nested->com.tristanhimmelman.ObjectMapper.nested->int64Dict", delimiter: "->"]
		boolDict    <- map["com.tristanhimmelman.ObjectMapper.nested->com.tristanhimmelman.ObjectMapper.nested->boolDict", delimiter: "->"]
		intDict     <- map["com.tristanhimmelman.ObjectMapper.nested->com.tristanhimmelman.ObjectMapper.nested->intDict", delimiter: "->"]
		doubleDict  <- map["com.tristanhimmelman.ObjectMapper.nested->com.tristanhimmelman.ObjectMapper.nested->doubleDict", delimiter: "->"]
		floatDict   <- map["com.tristanhimmelman.ObjectMapper.nested->com.tristanhimmelman.ObjectMapper.nested->floatDict", delimiter: "->"]
		stringDict  <- map["com.tristanhimmelman.ObjectMapper.nested->com.tristanhimmelman.ObjectMapper.nested->stringDict", delimiter: "->"]

		int64Enum   <- map["com.tristanhimmelman.ObjectMapper.nested->com.tristanhimmelman.ObjectMapper.nested->int64Enum", delimiter: "->"]
		intEnum     <- map["com.tristanhimmelman.ObjectMapper.nested->com.tristanhimmelman.ObjectMapper.nested->intEnum", delimiter: "->"]
		doubleEnum  <- map["com.tristanhimmelman.ObjectMapper.nested->com.tristanhimmelman.ObjectMapper.nested->doubleEnum", delimiter: "->"]
		floatEnum   <- map["com.tristanhimmelman.ObjectMapper.nested->com.tristanhimmelman.ObjectMapper.nested->floatEnum", delimiter: "->"]
		stringEnum  <- map["com.tristanhimmelman.ObjectMapper.nested->com.tristanhimmelman.ObjectMapper.nested->stringEnum", delimiter: "->"]

		object      <- map["com.tristanhimmelman.ObjectMapper.nested->com.tristanhimmelman.ObjectMapper.nested->com.tristanhimmelman.ObjectMapper.nested->object", delimiter: "->"]
		objectArray <- map["com.tristanhimmelman.ObjectMapper.nested->com.tristanhimmelman.ObjectMapper.nested->com.tristanhimmelman.ObjectMapper.nested->objectArray", delimiter: "->"]
		objectDict  <- map["com.tristanhimmelman.ObjectMapper.nested->com.tristanhimmelman.ObjectMapper.nested->com.tristanhimmelman.ObjectMapper.nested->objectDict", delimiter: "->"]
	}
}

class Object: Mappable, Equatable {
	var value: Int = Int.min
	
	required init?(map: Map){
		
	}
	
	func mapping(map: Map) {
		value <- map["value"]
	}
}

func == (lhs: Object, rhs: Object) -> Bool {
	return lhs.value == rhs.value
}

enum Int64Enum: NSNumber {
	case a = 0
	case b = 1000
}

enum IntEnum: Int {
	case a = 0
	case b = 255
}

enum DoubleEnum: Double {
	case a = 0.0
	case b = 100.0
}

enum FloatEnum: Float {
	case a = 0.0
	case b = 100.0
}

enum StringEnum: String {
	case A = "String A"
	case B = "String B"
}
