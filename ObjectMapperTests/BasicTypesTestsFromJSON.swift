//
//  BasicTypesFromJSON.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2015-02-17.
//  Copyright (c) 2015 hearst. All rights reserved.
//

import UIKit
import XCTest
import ObjectMapper

class BasicTypesTestsFromJSON: XCTestCase {

	let mapper = Mapper<BasicTypes>()
	
	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	// MARK: Test mapping to JSON and back (basic types: Bool, Int, Double, Float, String)
	
	func testMappingBoolFromJSON(){
		var value: Bool = true
		let JSON = "{\"bool\" : \(value), \"boolOpt\" : \(value), \"boolImp\" : \(value)}"
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			
			XCTAssertEqual(mappedObject.bool, value, "Bool failed")
			XCTAssertEqual(mappedObject.boolImplicityUnwrapped, value, "Implicitly unwrapped optional Bool failed")
			if let val = mappedObject.boolOptional {
				XCTAssertEqual(val, value, "Optional Bool failed")
			}
		} else {
			XCTAssert(false, "JSON to Bool failed")
		}
	}
	
	func testMappingIntToJSON(){
		var value: Int = 11
		let JSON = "{\"int\" : \(value), \"intOpt\" : \(value), \"intImp\" : \(value)}"
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			
			XCTAssertEqual(mappedObject.int, value, "Int failed")
			XCTAssertEqual(mappedObject.intImplicityUnwrapped, value, "Implicity unwrapped optional Int failed")
			if let val = mappedObject.intOptional {
				XCTAssertEqual(val, value, "Optional Int failed")
			}
		} else {
			XCTAssert(false, "JSON to Int failed")
		}
	}
	
	func testMappingDoubleToJSON(){
		var value: Double = 11
		let JSON = "{\"double\" : \(value), \"doubleOpt\" : \(value), \"doubleImp\" : \(value)}"

		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			
			XCTAssertEqual(mappedObject.double, value, "Double failed")
			XCTAssertEqual(mappedObject.doubleImplicityUnwrapped, value, "Implicity unwrapped optional Double failed")
			if let val = mappedObject.doubleOptional {
				XCTAssertEqual(val, value, "Optional Double failed")
			}
		} else {
			XCTAssert(false, "JSON to Double failed")
		}
	}
	
	func testMappingFloatToJSON(){
		var value: Float = 11
		let JSON = "{\"float\" : \(value), \"floatOpt\" : \(value), \"floatImp\" : \(value)}"
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			
			XCTAssertEqual(mappedObject.float, value, "Float failed")
			XCTAssertEqual(mappedObject.floatImplicityUnwrapped, value, "Implicity unwrapped optional Float failed")
			if let val = mappedObject.floatOptional {
				XCTAssertEqual(val, value, "Optional Float failed")
			}
		} else {
			XCTAssert(false, "JSON to Float failed")
		}
	}
	
	func testMappingStringToJSON(){
		var value: String = "STRINGNGNGG"
		let JSON = "{\"string\" : \"\(value)\", \"stringOpt\" : \"\(value)\", \"stringImp\" : \"\(value)\"}"

		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			
			XCTAssertEqual(mappedObject.string, value, "String failed")
			XCTAssertEqual(mappedObject.stringOptional!, value, "Implicity unwrapped optional String failed")
			XCTAssertEqual(mappedObject.stringImplicityUnwrapped, value, "Implicity unwrapped optional String failed")
		} else {
			XCTAssert(false, "JSON to String failed")
		}
	}
	
	// MARK: Test mapping Arrays to JSON and back (with basic types in them Bool, Int, Double, Float, String)
	
	func testMappingBoolArrayToJSON(){
		var value: Bool = true
		let JSON = "{\"arrayBool\" : [\(value)], \"arrayBoolOpt\" : [\(value)], \"arrayBoolImp\" : [\(value)] }"

		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			var firstObject = mappedObject.arrayBool[0]
			XCTAssertEqual(firstObject, value, "Bool Array failed")
			
			firstObject = mappedObject.arrayBoolImplicityUnwrapped[0]
			XCTAssertEqual(firstObject, value, "Implicity unwrapped optional Bool Array failed")
			if let val = mappedObject.arrayBoolOptional?[0] {
				XCTAssertEqual(val, value, "Optional Bool Array failed")
			}
		} else {
			XCTAssert(false, "Bool Array to JSON failed")
		}
	}
	
	func testMappingIntArrayToJSON(){
		var value: Int = 1
		let JSON = "{\"arrayInt\" : [\(value)], \"arrayIntOpt\" : [\(value)], \"arrayIntImp\" : [\(value)] }"
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			var firstObject = mappedObject.arrayInt[0]
			XCTAssertEqual(firstObject, value, "Int Array failed")
			
			firstObject = mappedObject.arrayIntImplicityUnwrapped[0]
			XCTAssertEqual(firstObject, value, "Implicity unwrapped optional Int Array failed")
			
			if let val = mappedObject.arrayIntOptional?[0] {
				XCTAssertEqual(val, value, "Optional Int Array failed")
			}
		} else {
			XCTAssert(false, "Int Array to JSON failed")
		}
	}
	
	func testMappingDoubleArrayToJSON(){
		var value: Double = 1.0
		let JSON = "{\"arrayDouble\" : [\(value)], \"arrayDoubleOpt\" : [\(value)], \"arrayDoubleImp\" : [\(value)] }"
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			var firstObject = mappedObject.arrayDouble[0]
			XCTAssertEqual(firstObject, value, "Double Array failed")
			
			firstObject = mappedObject.arrayDoubleImplicityUnwrapped[0]
			XCTAssertEqual(firstObject, value, "Implicity unwrapped optional Double Array failed")
			if let val = mappedObject.arrayDoubleOptional?[0] {
				XCTAssertEqual(val, value, "Optional Double Array failed")
			}
		} else {
			XCTAssert(false, "Double Array to JSON failed")
		}
	}
	
	func testMappingFloatArrayToJSON(){
		var value: Float = 1.001
		let JSON = "{\"arrayFloat\" : [\(value)], \"arrayFloatOpt\" : [\(value)], \"arrayFloatImp\" : [\(value)] }"
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			var firstObject = mappedObject.arrayFloat[0]
			XCTAssertEqual(firstObject, value, "Float Array failed")
			
			firstObject = mappedObject.arrayFloatImplicityUnwrapped[0]
			XCTAssertEqual(firstObject, value, "Implicity unwrapped optional Float Array failed")
			if let val = mappedObject.arrayFloatOptional?[0] {
				XCTAssertEqual(val, value, "Optional Float Array failed")
			}
		} else {
			XCTAssert(false, "Float Array to JSON failed")
		}
	}
	
	func testMappingStringArrayToJSON(){
		var value: String = "Stringgggg"
		let JSON = "{\"arrayString\" : [\"\(value)\"], \"arrayStringOpt\" : [\"\(value)\"], \"arrayStringImp\" : [\"\(value)\"] }"
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			var firstObject = mappedObject.arrayString[0]
			XCTAssertEqual(firstObject, value, "String Array failed")
			
			firstObject = mappedObject.arrayStringImplicityUnwrapped[0]
			XCTAssertEqual(firstObject, value, "Implicity unwrapped optional String Array failed")
			if let val = mappedObject.arrayStringOptional?[0] {
				XCTAssertEqual(val, value, "Optional String Array failed")
			}
		} else {
			XCTAssert(false, "String Array to JSON failed")
		}
	}
	
	// MARK: Test mapping Dictionaries to JSON and back (with basic types in them Bool, Int, Double, Float, String)
	
	func testMappingBoolDictionaryToJSON(){
		var key = "key"
		var value: Bool = true
		let JSON = "{\"dictBool\" : { \"\(key)\" : \(value)}, \"dictBoolOpt\" : { \"\(key)\" : \(value)}, \"dictBoolImp\" : { \"\(key)\" : \(value)} }"
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			if let val = mappedObject.dictBoolOptional?[key] {
				XCTAssertEqual(val, value, "Optional Bool Dictionary failed")
			}
			if let val = mappedObject.dictBoolImplicityUnwrapped[key] {
				XCTAssertEqual(val, value, "Implicity unwrapped optional Bool Dictionary failed")
			}
			if let val = mappedObject.dictBool[key] {
				XCTAssertEqual(val, value, "Bool Dictionary failed")
			}
		} else {
			XCTAssert(false, "Bool Dictionary to JSON failed")
		}
	}
	
	func testMappingIntDictionaryToJSON(){
		var key = "key"
		var value: Int = 11
		let JSON = "{\"dictInt\" : { \"\(key)\" : \(value)}, \"dictIntOpt\" : { \"\(key)\" : \(value)}, \"dictIntImp\" : { \"\(key)\" : \(value)} }"
		
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			if let val = mappedObject.dictIntOptional?[key] {
				XCTAssertEqual(val, value, "Optional Int Dictionary failed")
			}
			if let val = mappedObject.dictIntImplicityUnwrapped[key] {
				XCTAssertEqual(val, value, "Implicity unwrapped optional Int Dictionary failed")
			}
			if let val = mappedObject.dictInt[key] {
				XCTAssertEqual(val, value, "Int Dictionary failed")
			}
		} else {
			XCTAssert(false, "Int Dictionary to JSON failed")
		}
	}
	
	func testMappingDoubleDictionaryToJSON(){
		var key = "key"
		var value: Double = 11
		let JSON = "{\"dictDouble\" : { \"\(key)\" : \(value)}, \"dictDoubleOpt\" : { \"\(key)\" : \(value)}, \"dictDoubleImp\" : { \"\(key)\" : \(value)} }"
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			if let val = mappedObject.dictDoubleOptional?[key] {
				XCTAssertEqual(val, value, "Optional Double Dictionary failed")
			}
			if let val = mappedObject.dictDoubleImplicityUnwrapped[key] {
				XCTAssertEqual(val, value, "Implicity unwrapped optional Double Dictionary failed")
			}
			if let val = mappedObject.dictDouble[key] {
				XCTAssertEqual(val, value, "Double Dictionary failed")
			}
		} else {
			XCTAssert(false, "Double Dictionary to JSON failed")
		}
	}
	
	func testMappingFloatDictionaryToJSON(){
		var key = "key"
		var value: Float = 111.1
		let JSON = "{\"dictFloat\" : { \"\(key)\" : \(value)}, \"dictFloatOpt\" : { \"\(key)\" : \(value)}, \"dictFloatImp\" : { \"\(key)\" : \(value)} }"
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			if let val = mappedObject.dictFloatOptional?[key] {
				XCTAssertEqual(val, value, "Optional Float Dictionary failed")
			}
			if let val = mappedObject.dictFloatImplicityUnwrapped[key] {
				XCTAssertEqual(val, value, "Implicity unwrapped optional Float Dictionary failed")
			}
			if let val = mappedObject.dictFloat[key] {
				XCTAssertEqual(val, value, "Float Dictionary failed")
			}
		} else {
			XCTAssert(false, "Float Dictionary to JSON failed")
		}
	}
	
	func testMappingStringDictionaryToJSON(){
		var key = "key"
		var value = "value"
		let JSON = "{\"dictString\" : { \"\(key)\" : \"\(value)\"}, \"dictStringOpt\" : { \"\(key)\" : \"\(value)\"}, \"dictStringImp\" : { \"\(key)\" : \"\(value)\"} }"
		
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			if let val = mappedObject.dictStringOptional?[key] {
				XCTAssertEqual(val, value, "Optional String Dictionary failed")
			}
			if let val = mappedObject.dictStringImplicityUnwrapped[key] {
				XCTAssertEqual(val, value, "Implicity unwrapped optional String Dictionary failed")
			}
			if let val = mappedObject.dictString[key] {
				XCTAssertEqual(val, value, "String Dictionary failed")
			}
		} else {
			XCTAssert(false, "String Dictionary to JSON failed")
		}
	}
}