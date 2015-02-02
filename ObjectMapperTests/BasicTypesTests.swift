//
//  BasicTypesTests.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2014-12-04.
//  Copyright (c) 2014 hearst. All rights reserved.
//

import UIKit
import XCTest
import ObjectMapper

class BasicTypesTests: XCTestCase {

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
	
	func testMappingBoolToJSON(){
		var value: Bool = true
		var object = BasicTypes()
		object.bool = value
		object.boolOptional = value
		
		let JSON = Mapper().toJSONString(object, prettyPrint: true)
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {

			XCTAssertEqual(mappedObject.bool, value, "Bool failed")
			if let val = mappedObject.boolOptional {
				XCTAssertEqual(val, value, "Optional Bool failed")
			}
		}
	}
	
	func testMappingIntToJSON(){
		var value: Int = 11
		var object = BasicTypes()
		object.int = value
		object.intOptional = value
		
		let JSON = Mapper().toJSONString(object, prettyPrint: true)
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			
			XCTAssertEqual(mappedObject.int, value, "Int failed")
			if let val = mappedObject.intOptional {
				XCTAssertEqual(val, value, "Optional Int failed")
			}
		}
	}

	func testMappingDoubleToJSON(){
		var value: Double = 11
		var object = BasicTypes()
		object.double = value
		object.doubleOptional = value
		
		let JSON = Mapper().toJSONString(object, prettyPrint: true)
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			
			XCTAssertEqual(mappedObject.double, value, "Double failed")
			if let val = mappedObject.doubleOptional {
				XCTAssertEqual(val, value, "Optional Double failed")
			}
		}
	}

	func testMappingFloatToJSON(){
		var value: Float = 11
		var object = BasicTypes()
		object.float = value
		object.floatOptional = value
		
		let JSON = Mapper().toJSONString(object, prettyPrint: true)
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			
			XCTAssertEqual(mappedObject.float, value, "Float failed")
			if let val = mappedObject.floatOptional {
				XCTAssertEqual(val, value, "Optional Float failed")
			}
		}
	}
	
	func testMappingStringToJSON(){
		var value: String = "STRINGNGNGG"
		var object = BasicTypes()
		object.string = value
		object.stringOptional = value
		
		let JSON = Mapper().toJSONString(object, prettyPrint: true)
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			
			XCTAssertEqual(mappedObject.string, value, "String failed")
			if let val = mappedObject.stringOptional {
				XCTAssertEqual(val, value, "Optional String failed")
			}
		}
	}
	
	// MARK: Test mapping Arrays to JSON and back (with basic types in them Bool, Int, Double, Float, String)
	
	func testMappingBoolArrayToJSON(){
		var value: Bool = true
		var object = BasicTypes()
		object.arrayBool = [value]
		object.arrayBoolOptional = [value]
		
		let JSON = Mapper().toJSONString(object, prettyPrint: true)
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			var firstObject = mappedObject.arrayBool[0]
			XCTAssertEqual(firstObject, value, "Bool Array failed")
			if let val = mappedObject.arrayBoolOptional?[0] {
				XCTAssertEqual(val, value, "Optional Bool Array failed")
			}
		}
	}
	
	func testMappingIntArrayToJSON(){
		var value: Int = 1
		var object = BasicTypes()
		object.arrayInt = [value]
		object.arrayIntOptional = [value]
		
		let JSON = Mapper().toJSONString(object, prettyPrint: true)
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			var firstObject = mappedObject.arrayInt[0]
			XCTAssertEqual(firstObject, value, "Int Array failed")
			if let val = mappedObject.arrayIntOptional?[0] {
				XCTAssertEqual(val, value, "Optional Int Array failed")
			}
		}
	}
	
	func testMappingDoubleArrayToJSON(){
		var value: Double = 1.0
		var object = BasicTypes()
		object.arrayDouble = [value]
		object.arrayDoubleOptional = [value]
		
		let JSON = Mapper().toJSONString(object, prettyPrint: true)
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			var firstObject = mappedObject.arrayDouble[0]
			XCTAssertEqual(firstObject, value, "Double Array failed")
			if let val = mappedObject.arrayDoubleOptional?[0] {
				XCTAssertEqual(val, value, "Optional Double Array failed")
			}
		}
	}
	
	func testMappingFloatArrayToJSON(){
		var value: Float = 1.001
		var object = BasicTypes()
		object.arrayFloat = [value]
		object.arrayFloatOptional = [value]
		
		let JSON = Mapper().toJSONString(object, prettyPrint: true)
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			var firstObject = mappedObject.arrayFloat[0]
			XCTAssertEqual(firstObject, value, "Float Array failed")
			if let val = mappedObject.arrayFloatOptional?[0] {
				XCTAssertEqual(val, value, "Optional Float Array failed")
			}
		}
	}
	
	func testMappingStringArrayToJSON(){
		var value: String = "Stringgggg"
		var object = BasicTypes()
		object.arrayString = [value]
		object.arrayStringOptional = [value]
		
		let JSON = Mapper().toJSONString(object, prettyPrint: true)
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			var firstObject = mappedObject.arrayString[0]
			XCTAssertEqual(firstObject, value, "Float Array failed")
			if let val = mappedObject.arrayStringOptional?[0] {
				XCTAssertEqual(val, value, "Optional Float Array failed")
			}
		}
	}
	
	// MARK: Test mapping Dictionaries to JSON and back (with basic types in them Bool, Int, Double, Float, String)
	
	func testMappingBoolDictionaryToJSON(){
		var key = "key"
		var value: Bool = true
		var object = BasicTypes()
		object.dictBool = [key:value]
		object.dictBoolOptional = [key:value]
		
		let JSON = Mapper().toJSONString(object, prettyPrint: true)
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			if let val = mappedObject.dictBoolOptional?[key] {
				XCTAssertEqual(val, value, "Optional Bool Dictionary failed")
			}
			if let val = mappedObject.dictBool[key] {
				XCTAssertEqual(val, value, "Bool Dictionary failed")
			}
		}
	}
	
	func testMappingIntDictionaryToJSON(){
		var key = "key"
		var value: Int = 11
		var object = BasicTypes()
		object.dictInt = [key:value]
		object.dictIntOptional = [key:value]
		
		let JSON = Mapper().toJSONString(object, prettyPrint: true)
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			if let val = mappedObject.dictIntOptional?[key] {
				XCTAssertEqual(val, value, "Optional Int Dictionary failed")
			}
			if let val = mappedObject.dictInt[key] {
				XCTAssertEqual(val, value, "Int Dictionary failed")
			}
		}
	}
	
	func testMappingDoubleDictionaryToJSON(){
		var key = "key"
		var value: Double = 11
		var object = BasicTypes()
		object.dictDouble = [key:value]
		object.dictDoubleOptional = [key:value]
		
		let JSON = Mapper().toJSONString(object, prettyPrint: true)
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			if let val = mappedObject.dictDoubleOptional?[key] {
				XCTAssertEqual(val, value, "Optional Double Dictionary failed")
			}
			if let val = mappedObject.dictDouble[key] {
				XCTAssertEqual(val, value, "Double Dictionary failed")
			}
		}
	}
	
	func testMappingFloatDictionaryToJSON(){
		var key = "key"
		var value: Float = 11
		var object = BasicTypes()
		object.dictFloat = [key:value]
		object.dictFloatOptional = [key:value]
		
		let JSON = Mapper().toJSONString(object, prettyPrint: true)
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			if let val = mappedObject.dictFloatOptional?[key] {
				XCTAssertEqual(val, value, "Optional Float Dictionary failed")
			}
			if let val = mappedObject.dictFloat[key] {
				XCTAssertEqual(val, value, "Float Dictionary failed")
			}
		}
	}
	
	func testMappingStringDictionaryToJSON(){
		var key = "key"
		var value = "value"
		var object = BasicTypes()
		object.dictString = [key:value]
		object.dictStringOptional = [key:value]
		
		let JSON = Mapper().toJSONString(object, prettyPrint: true)
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			if let val = mappedObject.dictStringOptional?[key] {
				XCTAssertEqual(val, value, "Optional String Dictionary failed")
			}
			if let val = mappedObject.dictString[key] {
				XCTAssertEqual(val, value, "String Dictionary failed")
			}
		}
	}
}

class BasicTypes: Mappable {
	var bool: Bool = true
	var boolOptional: Bool?
	var int: Int = 0
	var intOptional: Int?
	var double: Double = 1.1
	var doubleOptional: Double?
	var float: Float = 1.11
	var floatOptional: Float?
	var string: String = ""
	var stringOptional: String?
	
	var arrayBool: Array<Bool> = []
	var arrayBoolOptional: Array<Bool>?
	var arrayInt: Array<Int> = []
	var arrayIntOptional: Array<Int>?
	var arrayDouble: Array<Double> = []
	var arrayDoubleOptional: Array<Double>?
	var arrayFloat: Array<Float> = []
	var arrayFloatOptional: Array<Float>?
	var arrayString: Array<String> = []
	var arrayStringOptional: Array<String>?
	
	var dictBool: Dictionary<String,Bool> = [:]
	var dictBoolOptional: Dictionary<String,Bool>?
	var dictInt: Dictionary<String,Int> = [:]
	var dictIntOptional: Dictionary<String,Int>?
	var dictDouble: Dictionary<String,Double> = [:]
	var dictDoubleOptional: Dictionary<String,Double>?
	var dictFloat: Dictionary<String,Float> = [:]
	var dictFloatOptional: Dictionary<String,Float>?
	var dictString: Dictionary<String,String> = [:]
	var dictStringOptional: Dictionary<String,String>?
	
	required init() {
	}
	
	func map(map: Map) {
		bool			<= map["bool"]
		boolOptional	<= map["boolOpt"]
		int				<= map["int"]
		intOptional		<= map["intOpt"]
		double			<= map["double"]
		doubleOptional	<= map["doubleOpt"]
		float			<= map["float"]
		floatOptional	<= map["floatOpt"]
		string			<= map["string"]
		stringOptional	<= map["stringOpt"]
		
		arrayBool			<= map["arrayBool"]
		arrayBoolOptional	<= map["arrayBoolOpt"]
		arrayInt			<= map["arrayInt"]
		arrayIntOptional	<= map["arrayIntOpt"]
		arrayDouble			<= map["arrayDouble"]
		arrayDoubleOptional	<= map["arrayDoubleOpt"]
		arrayFloat			<= map["arrayFloat"]
		arrayFloatOptional	<= map["arrayFloatOpt"]
		arrayString			<= map["arrayString"]
		arrayStringOptional	<= map["arrayStringOpt"]
		
		dictBool			<= map["dictBool"]
		dictBoolOptional	<= map["dictBoolOpt"]
		dictInt				<= map["dictInt"]
		dictIntOptional		<= map["dictIntOpt"]
		dictDouble			<= map["dictDouble"]
		dictDoubleOptional	<= map["dictDoubleOpt"]
		dictFloat			<= map["dictFloat"]
		dictFloatOptional	<= map["dictFloatOpt"]
		dictString			<= map["dictString"]
		dictStringOptional	<= map["dictStringOpt"]
	}
}


