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
			XCTAssertEqual(mappedObject.boolOptional!, value, "Optional Bool failed")
			XCTAssertEqual(mappedObject.boolImplicityUnwrapped, value, "Implicitly unwrapped optional Bool failed")
		} else {
			XCTAssert(false, "JSON to Bool failed")
		}
	}
	
	func testMappingIntFromJSON(){
		var value: Int = 11
		let JSON = "{\"int\" : \(value), \"intOpt\" : \(value), \"intImp\" : \(value)}"
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			
			XCTAssertEqual(mappedObject.int, value, "Int failed")
			XCTAssertEqual(mappedObject.intOptional!, value, "Optional Int failed")
			XCTAssertEqual(mappedObject.intImplicityUnwrapped, value, "Implicity unwrapped optional Int failed")
		} else {
			XCTAssert(false, "JSON to Int failed")
		}
	}
	
	func testMappingDoubleFromJSON(){
		var value: Double = 11
		let JSON = "{\"double\" : \(value), \"doubleOpt\" : \(value), \"doubleImp\" : \(value)}"

		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			
			XCTAssertEqual(mappedObject.double, value, "Double failed")
			XCTAssertEqual(mappedObject.doubleOptional!, value, "Optional Double failed")
			XCTAssertEqual(mappedObject.doubleImplicityUnwrapped, value, "Implicity unwrapped optional Double failed")
		} else {
			XCTAssert(false, "JSON to Double failed")
		}
	}
	
	func testMappingFloatFromJSON(){
		var value: Float = 11
		let JSON = "{\"float\" : \(value), \"floatOpt\" : \(value), \"floatImp\" : \(value)}"
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			
			XCTAssertEqual(mappedObject.float, value, "Float failed")
			XCTAssertEqual(mappedObject.floatOptional!, value, "Optional Float failed")
			XCTAssertEqual(mappedObject.floatImplicityUnwrapped, value, "Implicity unwrapped optional Float failed")
		} else {
			XCTAssert(false, "JSON to Float failed")
		}
	}
	
	func testMappingStringFromJSON(){
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
	
	func testMappingAnyObjectFromJSON(){
		var value1 = "STRING"
		var value2: Int = 1234
		var value3: Double = 11.11
		let JSON = "{\"anyObject\" : \"\(value1)\", \"anyObjectOpt\" : \(value2), \"anyObjectImp\" : \(value3)}"
		
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			XCTAssert(mappedObject.anyObject as String == value1, "AnyObject failed")
			XCTAssertEqual(mappedObject.anyObjectOptional! as Int, value2, "Implicity unwrapped optional String failed")
			XCTAssertEqual(mappedObject.anyObjectImplicitlyUnwrapped as Double, value3, "Implicity unwrapped optional String failed")
		} else {
			XCTAssert(false, "JSON to String failed")
		}
	}
	
	// MARK: Test mapping Arrays to JSON and back (with basic types in them Bool, Int, Double, Float, String)
	
	func testMappingBoolArrayFromJSON(){
		var value: Bool = true
		let JSON = "{\"arrayBool\" : [\(value)], \"arrayBoolOpt\" : [\(value)], \"arrayBoolImp\" : [\(value)] }"

		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			var firstObject = mappedObject.arrayBool[0]
			XCTAssertEqual(firstObject, value, "Bool Array failed")
			
			firstObject = mappedObject.arrayBoolImplicityUnwrapped[0]
			XCTAssertEqual(firstObject, value, "Implicity unwrapped optional Bool Array failed")

			let val = mappedObject.arrayBoolOptional?[0]
			XCTAssertEqual(val!, value, "Optional Bool Array failed")
		} else {
			XCTAssert(false, "Bool Array to JSON failed")
		}
	}
	
	func testMappingIntArrayFromJSON(){
		var value: Int = 1
		let JSON = "{\"arrayInt\" : [\(value)], \"arrayIntOpt\" : [\(value)], \"arrayIntImp\" : [\(value)] }"
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			var firstObject = mappedObject.arrayInt[0]
			XCTAssertEqual(firstObject, value, "Int Array failed")
			
			firstObject = mappedObject.arrayIntImplicityUnwrapped[0]
			XCTAssertEqual(firstObject, value, "Implicity unwrapped optional Int Array failed")
			
			let val = mappedObject.arrayIntOptional?[0]
			XCTAssertEqual(val!, value, "Optional Int Array failed")
			
		} else {
			XCTAssert(false, "Int Array to JSON failed")
		}
	}
	
	func testMappingDoubleArrayFromJSON(){
		var value: Double = 1.0
		let JSON = "{\"arrayDouble\" : [\(value)], \"arrayDoubleOpt\" : [\(value)], \"arrayDoubleImp\" : [\(value)] }"
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			var firstObject = mappedObject.arrayDouble[0]
			XCTAssertEqual(firstObject, value, "Double Array failed")
			
			firstObject = mappedObject.arrayDoubleImplicityUnwrapped[0]
			XCTAssertEqual(firstObject, value, "Implicity unwrapped optional Double Array failed")
			
			let val = mappedObject.arrayDoubleOptional?[0]
			XCTAssertEqual(val!, value, "Optional Double Array failed")
		} else {
			XCTAssert(false, "Double Array to JSON failed")
		}
	}
	
	func testMappingFloatArrayFromJSON(){
		var value: Float = 1.001
		let JSON = "{\"arrayFloat\" : [\(value)], \"arrayFloatOpt\" : [\(value)], \"arrayFloatImp\" : [\(value)] }"
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			var firstObject = mappedObject.arrayFloat[0]
			XCTAssertEqual(firstObject, value, "Float Array failed")
			
			firstObject = mappedObject.arrayFloatImplicityUnwrapped[0]
			XCTAssertEqual(firstObject, value, "Implicity unwrapped optional Float Array failed")
			
			let val = mappedObject.arrayFloatOptional?[0]
			XCTAssertEqual(val!, value, "Optional Float Array failed")
		} else {
			XCTAssert(false, "Float Array to JSON failed")
		}
	}
	
	func testMappingStringArrayFromJSON(){
		var value: String = "Stringgggg"
		let JSON = "{\"arrayString\" : [\"\(value)\"], \"arrayStringOpt\" : [\"\(value)\"], \"arrayStringImp\" : [\"\(value)\"] }"
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			var firstObject = mappedObject.arrayString[0]
			XCTAssertEqual(firstObject, value, "String Array failed")
			
			firstObject = mappedObject.arrayStringImplicityUnwrapped[0]
			XCTAssertEqual(firstObject, value, "Implicity unwrapped optional String Array failed")

			let val = mappedObject.arrayStringOptional?[0]
			XCTAssertEqual(val!, value, "Optional String Array failed")
		} else {
			XCTAssert(false, "String Array to JSON failed")
		}
	}
	
	func testMappingAnyObjectArrayFromJSON(){
		var value1 = "STRING"
		var value2: Int = 1234
		var value3: Double = 11.11
		let JSON = "{\"arrayAnyObject\" : [\"\(value1)\"], \"arrayAnyObjectOpt\" : [\(value2)], \"arratAnyObjectImp\" : [\(value3)] }"
		
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			XCTAssert(mappedObject.arrayAnyObject[0] as String == value1, "AnyObject array failed")
			XCTAssertEqual(mappedObject.arrayAnyObjectOptional![0] as Int, value2, "Optional AnyObject array failed")
			XCTAssertEqual(mappedObject.arrayAnyObjectImplicitlyUnwrapped[0] as Double, value3, "Implicity unwrapped optional AnyObject array failed")
		} else {
			XCTAssert(false, "JSON to String failed")
		}
	}
	
	// MARK: Test mapping Dictionaries to JSON and back (with basic types in them Bool, Int, Double, Float, String)
	
	func testMappingBoolDictionaryFromJSON(){
		var key = "key"
		var value: Bool = true
		let JSON = "{\"dictBool\" : { \"\(key)\" : \(value)}, \"dictBoolOpt\" : { \"\(key)\" : \(value)}, \"dictBoolImp\" : { \"\(key)\" : \(value)} }"
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			let val1 = mappedObject.dictBoolOptional?[key]
			XCTAssertEqual(val1!, value, "Optional Bool Dictionary failed")
			
			let val2 = mappedObject.dictBoolImplicityUnwrapped[key]
			XCTAssertEqual(val2!, value, "Implicity unwrapped optional Bool Dictionary failed")
			
			let val3 = mappedObject.dictBool[key]
			XCTAssertEqual(val3!, value, "Bool Dictionary failed")
		} else {
			XCTAssert(false, "Bool Dictionary to JSON failed")
		}
	}
	
	func testMappingIntDictionaryFromJSON(){
		var key = "key"
		var value: Int = 11
		let JSON = "{\"dictInt\" : { \"\(key)\" : \(value)}, \"dictIntOpt\" : { \"\(key)\" : \(value)}, \"dictIntImp\" : { \"\(key)\" : \(value)} }"
		
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			let val1 = mappedObject.dictIntOptional?[key]
			XCTAssertEqual(val1!, value, "Optional Int Dictionary failed")
			
			let val2 = mappedObject.dictIntImplicityUnwrapped[key]
			XCTAssertEqual(val2!, value, "Implicity unwrapped optional Int Dictionary failed")
			
			let val3 = mappedObject.dictInt[key]
			XCTAssertEqual(val3!, value, "Int Dictionary failed")
		} else {
			XCTAssert(false, "Int Dictionary to JSON failed")
		}
	}
	
	func testMappingDoubleDictionaryFromJSON(){
		var key = "key"
		var value: Double = 11
		let JSON = "{\"dictDouble\" : { \"\(key)\" : \(value)}, \"dictDoubleOpt\" : { \"\(key)\" : \(value)}, \"dictDoubleImp\" : { \"\(key)\" : \(value)} }"
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			let val1 = mappedObject.dictDoubleOptional?[key]
			XCTAssertEqual(val1!, value, "Optional Double Dictionary failed")
			
			let val2 = mappedObject.dictDoubleImplicityUnwrapped[key]
			XCTAssertEqual(val2!, value, "Implicity unwrapped optional Double Dictionary failed")
			
			let val3 = mappedObject.dictDouble[key]
			XCTAssertEqual(val3!, value, "Double Dictionary failed")
		} else {
			XCTAssert(false, "Double Dictionary to JSON failed")
		}
	}
	
	func testMappingFloatDictionaryFromJSON(){
		var key = "key"
		var value: Float = 111.1
		let JSON = "{\"dictFloat\" : { \"\(key)\" : \(value)}, \"dictFloatOpt\" : { \"\(key)\" : \(value)}, \"dictFloatImp\" : { \"\(key)\" : \(value)} }"
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			let val1 = mappedObject.dictFloat[key]
			XCTAssertEqual(val1!, value, "Float Dictionary failed")
		
			let val2 = mappedObject.dictFloatOptional?[key]
			XCTAssertEqual(val2!, value, "Optional Float Dictionary failed")
			
			let val3 = mappedObject.dictFloatImplicityUnwrapped[key]
			XCTAssertEqual(val3!, value, "Implicity unwrapped optional Float Dictionary failed")
		} else {
			XCTAssert(false, "Float Dictionary to JSON failed")
		}
	}
	
	func testMappingStringDictionaryFromJSON(){
		var key = "key"
		var value = "value"
		let JSON = "{\"dictString\" : { \"\(key)\" : \"\(value)\"}, \"dictStringOpt\" : { \"\(key)\" : \"\(value)\"}, \"dictStringImp\" : { \"\(key)\" : \"\(value)\"} }"
		
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			let val1 = mappedObject.dictString[key]
			XCTAssertEqual(val1!, value, "String Dictionary failed")
			
			let val2 = mappedObject.dictStringOptional?[key]
			XCTAssertEqual(val2!, value, "Optional String Dictionary failed")
		
			let val3 = mappedObject.dictStringImplicityUnwrapped[key]
			XCTAssertEqual(val3!, value, "Implicity unwrapped optional String Dictionary failed")
		} else {
			XCTAssert(false, "String Dictionary to JSON failed")
		}
	}
	
	func testMappingAnyObjectDictionaryFromJSON(){
		var key = "key"
		var value1 = "STRING"
		var value2: Int = 1234
		var value3: Double = 11.11
		let JSON = "{\"dictAnyObject\" : { \"\(key)\" : \"\(value1)\"}, \"dictAnyObjectOpt\" : { \"\(key)\" : \(value2)}, \"dictAnyObjectImp\" : { \"\(key)\" : \(value3)} }"
		
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			let val1 = mappedObject.dictAnyObject[key] as String
			XCTAssertEqual(val1, value1, "AnyObject Dictionary failed")
			
			let val2 = mappedObject.dictAnyObjectOptional?[key] as Int
			XCTAssertEqual(val2, value2, "Optional AnyObject Dictionary failed")
			
			let val3 = mappedObject.dictAnyObjectImplicitlyUnwrapped[key] as Double
			XCTAssertEqual(val3, value3, "Implicity unwrapped optional AnyObject Dictionary failed")
		} else {
			XCTAssert(false, "String Dictionary to JSON failed")
		}
	}
}