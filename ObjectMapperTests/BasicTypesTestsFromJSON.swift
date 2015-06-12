//
//  BasicTypesFromJSON.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2015-02-17.
//  Copyright (c) 2015 hearst. All rights reserved.
//

import Foundation
import XCTest
import ObjectMapper
import Nimble

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
		let value: Bool = true
		let JSONString = "{\"bool\" : \(value), \"boolOpt\" : \(value), \"boolImp\" : \(value)}"
		
		let mappedObject = mapper.map(JSONString)

		expect(mappedObject).notTo(beNil())
		expect(mappedObject?.bool).to(equal(value))
		expect(mappedObject?.boolOptional).to(equal(value))
		expect(mappedObject?.boolImplicityUnwrapped).to(equal(value))
	}
	
	func testMappingIntFromJSON(){
		let value: Int = 11
		let JSONString = "{\"int\" : \(value), \"intOpt\" : \(value), \"intImp\" : \(value)}"
		
		let mappedObject = mapper.map(JSONString)

		expect(mappedObject).notTo(beNil())
		expect(mappedObject?.int).to(equal(value))
		expect(mappedObject?.intOptional).to(equal(value))
		expect(mappedObject?.intImplicityUnwrapped).to(equal(value))
	}
	
	func testMappingDoubleFromJSON(){
		let value: Double = 11
		let JSONString = "{\"double\" : \(value), \"doubleOpt\" : \(value), \"doubleImp\" : \(value)}"

		let mappedObject = mapper.map(JSONString)

		expect(mappedObject).notTo(beNil())
		expect(mappedObject?.double).to(equal(value))
		expect(mappedObject?.doubleOptional).to(equal(value))
		expect(mappedObject?.doubleImplicityUnwrapped).to(equal(value))
	}
	
	func testMappingFloatFromJSON(){
		let value: Float = 11
		let JSONString = "{\"float\" : \(value), \"floatOpt\" : \(value), \"floatImp\" : \(value)}"
		
		let mappedObject = mapper.map(JSONString)

		expect(mappedObject).notTo(beNil())
		expect(mappedObject?.float).to(equal(value))
		expect(mappedObject?.floatOptional).to(equal(value))
		expect(mappedObject?.floatImplicityUnwrapped).to(equal(value))
	}
	
	func testMappingStringFromJSON(){
		let value: String = "STRINGNGNGG"
		let JSONString = "{\"string\" : \"\(value)\", \"stringOpt\" : \"\(value)\", \"stringImp\" : \"\(value)\"}"

		let mappedObject = mapper.map(JSONString)

		expect(mappedObject).notTo(beNil())
		expect(mappedObject?.string).to(equal(value))
		expect(mappedObject?.stringOptional).to(equal(value))
		expect(mappedObject?.stringImplicityUnwrapped).to(equal(value))
	}
	
	func testMappingAnyObjectFromJSON(){
		let value1 = "STRING"
		let value2: Int = 1234
		let value3: Double = 11.11
		let JSONString = "{\"anyObject\" : \"\(value1)\", \"anyObjectOpt\" : \(value2), \"anyObjectImp\" : \(value3)}"
		
		let mappedObject = mapper.map(JSONString)

		expect(mappedObject).notTo(beNil())
		expect(mappedObject?.anyObject as? String).to(equal(value1))
		expect(mappedObject?.anyObjectOptional as? Int).to(equal(value2))
		expect(mappedObject?.anyObjectImplicitlyUnwrapped as? Double).to(equal(value3))
	}

	func testMappingStringFromNSStringJSON(){
		let value: String = "STRINGNGNGG"
		let JSONNSString : NSString = "{\"string\" : \"\(value)\", \"stringOpt\" : \"\(value)\", \"stringImp\" : \"\(value)\"}"
		
		let mappedObject = mapper.map(JSONNSString)
		
		expect(mappedObject).notTo(beNil())
		expect(mappedObject?.string).to(equal(value))
		expect(mappedObject?.stringOptional).to(equal(value))
		expect(mappedObject?.stringImplicityUnwrapped).to(equal(value))
	}

	// MARK: Test mapping Arrays to JSON and back (with basic types in them Bool, Int, Double, Float, String)
	
	func testMappingBoolArrayFromJSON(){
		let value: Bool = true
		let JSONString = "{\"arrayBool\" : [\(value)], \"arrayBoolOpt\" : [\(value)], \"arrayBoolImp\" : [\(value)] }"

		let mappedObject = mapper.map(JSONString)

		expect(mappedObject).notTo(beNil())
		expect(mappedObject?.arrayBool.first).to(equal(value))
		expect(mappedObject?.arrayBoolImplicityUnwrapped.first).to(equal(value))
		expect(mappedObject?.arrayBoolOptional?.first).to(equal(value))
	}
	
	func testMappingIntArrayFromJSON(){
		let value: Int = 1
		let JSONString = "{\"arrayInt\" : [\(value)], \"arrayIntOpt\" : [\(value)], \"arrayIntImp\" : [\(value)] }"

		let mappedObject = mapper.map(JSONString)

		expect(mappedObject).notTo(beNil())
		expect(mappedObject?.arrayInt.first).to(equal(value))
		expect(mappedObject?.arrayIntImplicityUnwrapped.first).to(equal(value))
		expect(mappedObject?.arrayIntOptional?.first).to(equal(value))
	}
	
	func testMappingDoubleArrayFromJSON(){
		let value: Double = 1.0
		let JSONString = "{\"arrayDouble\" : [\(value)], \"arrayDoubleOpt\" : [\(value)], \"arrayDoubleImp\" : [\(value)] }"

		let mappedObject = mapper.map(JSONString)

		expect(mappedObject).notTo(beNil())
		expect(mappedObject?.arrayDouble.first).to(equal(value))
		expect(mappedObject?.arrayDoubleImplicityUnwrapped.first).to(equal(value))
		expect(mappedObject?.arrayDoubleOptional?.first).to(equal(value))
	}
	
	func testMappingFloatArrayFromJSON(){
		let value: Float = 1.001
		let JSONString = "{\"arrayFloat\" : [\(value)], \"arrayFloatOpt\" : [\(value)], \"arrayFloatImp\" : [\(value)] }"
		
		let mappedObject = mapper.map(JSONString)

		expect(mappedObject).notTo(beNil())
		expect(mappedObject?.arrayFloat.first).to(equal(value))
		expect(mappedObject?.arrayFloatImplicityUnwrapped.first).to(equal(value))
		expect(mappedObject?.arrayFloatOptional?.first).to(equal(value))
	}
	
	func testMappingStringArrayFromJSON(){
		let value: String = "Stringgggg"
		let JSONString = "{\"arrayString\" : [\"\(value)\"], \"arrayStringOpt\" : [\"\(value)\"], \"arrayStringImp\" : [\"\(value)\"] }"
		
		let mappedObject = mapper.map(JSONString)

		expect(mappedObject).notTo(beNil())
		expect(mappedObject?.arrayString.first).to(equal(value))
		expect(mappedObject?.arrayStringImplicityUnwrapped.first).to(equal(value))
		expect(mappedObject?.arrayStringOptional?.first).to(equal(value))
	}
	
	func testMappingAnyObjectArrayFromJSON(){
		let value1 = "STRING"
		let value2: Int = 1234
		let value3: Double = 11.11
		let JSONString = "{\"arrayAnyObject\" : [\"\(value1)\"], \"arrayAnyObjectOpt\" : [\(value2)], \"arratAnyObjectImp\" : [\(value3)] }"
		
		let mappedObject = mapper.map(JSONString)

		expect(mappedObject).notTo(beNil())
		expect(mappedObject?.arrayAnyObject.first as? String).to(equal(value1))
		expect(mappedObject?.arrayAnyObjectOptional?.first as? Int).to(equal(value2))
		expect(mappedObject?.arrayAnyObjectImplicitlyUnwrapped.first as? Double).to(equal(value3))
	}
	
	// MARK: Test mapping Dictionaries to JSON and back (with basic types in them Bool, Int, Double, Float, String)
	
	func testMappingBoolDictionaryFromJSON(){
		let key = "key"
		let value: Bool = true
		let JSONString = "{\"dictBool\" : { \"\(key)\" : \(value)}, \"dictBoolOpt\" : { \"\(key)\" : \(value)}, \"dictBoolImp\" : { \"\(key)\" : \(value)} }"
		
		let mappedObject = mapper.map(JSONString)

		expect(mappedObject).notTo(beNil())
		expect(mappedObject?.dictBoolOptional?[key]).to(equal(value))
		expect(mappedObject?.dictBoolImplicityUnwrapped[key]).to(equal(value))
		expect(mappedObject?.dictBool[key]).to(equal(value))
	}
	
	func testMappingIntDictionaryFromJSON(){
		let key = "key"
		let value: Int = 11
		let JSONString = "{\"dictInt\" : { \"\(key)\" : \(value)}, \"dictIntOpt\" : { \"\(key)\" : \(value)}, \"dictIntImp\" : { \"\(key)\" : \(value)} }"
		
		let mappedObject = mapper.map(JSONString)

		expect(mappedObject).notTo(beNil())
		expect(mappedObject?.dictIntOptional?[key]).to(equal(value))
		expect(mappedObject?.dictIntImplicityUnwrapped[key]).to(equal(value))
		expect(mappedObject?.dictInt[key]).to(equal(value))
	}
	
	func testMappingDoubleDictionaryFromJSON(){
		let key = "key"
		let value: Double = 11
		let JSONString = "{\"dictDouble\" : { \"\(key)\" : \(value)}, \"dictDoubleOpt\" : { \"\(key)\" : \(value)}, \"dictDoubleImp\" : { \"\(key)\" : \(value)} }"
		
		let mappedObject = mapper.map(JSONString)

		expect(mappedObject).notTo(beNil())
		expect(mappedObject?.dictDoubleOptional?[key]).to(equal(value))
		expect(mappedObject?.dictDoubleImplicityUnwrapped[key]).to(equal(value))
		expect(mappedObject?.dictDouble[key]).to(equal(value))
	}
	
	func testMappingFloatDictionaryFromJSON(){
		let key = "key"
		let value: Float = 111.1
		let JSONString = "{\"dictFloat\" : { \"\(key)\" : \(value)}, \"dictFloatOpt\" : { \"\(key)\" : \(value)}, \"dictFloatImp\" : { \"\(key)\" : \(value)} }"

		let mappedObject = mapper.map(JSONString)

		expect(mappedObject).notTo(beNil())
		expect(mappedObject?.dictFloat[key]).to(equal(value))
		expect(mappedObject?.dictFloatOptional?[key]).to(equal(value))
		expect(mappedObject?.dictFloatImplicityUnwrapped[key]).to(equal(value))
	}
	
	func testMappingStringDictionaryFromJSON(){
		let key = "key"
		let value = "value"
		let JSONString = "{\"dictString\" : { \"\(key)\" : \"\(value)\"}, \"dictStringOpt\" : { \"\(key)\" : \"\(value)\"}, \"dictStringImp\" : { \"\(key)\" : \"\(value)\"} }"
		
		let mappedObject = mapper.map(JSONString)

		expect(mappedObject).notTo(beNil())
		expect(mappedObject?.dictString[key]).to(equal(value))
		expect(mappedObject?.dictStringOptional?[key]).to(equal(value))
		expect(mappedObject?.dictStringImplicityUnwrapped[key]).to(equal(value))
	}
	
	func testMappingAnyObjectDictionaryFromJSON(){
		let key = "key"
		let value1 = "STRING"
		let value2: Int = 1234
		let value3: Double = 11.11
		let JSONString = "{\"dictAnyObject\" : { \"\(key)\" : \"\(value1)\"}, \"dictAnyObjectOpt\" : { \"\(key)\" : \(value2)}, \"dictAnyObjectImp\" : { \"\(key)\" : \(value3)} }"
		
		let mappedObject = mapper.map(JSONString)

		expect(mappedObject).notTo(beNil())
		expect(mappedObject?.dictAnyObject[key] as? String).to(equal(value1))
		expect(mappedObject?.dictAnyObjectOptional?[key] as? Int).to(equal(value2))
		expect(mappedObject?.dictAnyObjectImplicitlyUnwrapped[key] as? Double).to(equal(value3))
	}

	func testMappingIntEnumFromJSON(){
		let value: BasicTypes.EnumInt = .Another
		let JSONString = "{\"enumInt\" : \(value.rawValue), \"enumIntOpt\" : \(value.rawValue), \"enumIntImp\" : \(value.rawValue) }"

		let mappedObject = mapper.map(JSONString)
		expect(mappedObject).notTo(beNil())
		expect(mappedObject?.enumInt).to(equal(value))
		expect(mappedObject?.enumIntOptional).to(equal(value))
		expect(mappedObject?.enumIntImplicitlyUnwrapped).to(equal(value))
	}

	func testMappingIntEnumFromJSONShouldNotCrashWithNonDefinedvalue() {
		let value = Int.min
		let JSONString = "{\"enumInt\" : \(value), \"enumIntOpt\" : \(value), \"enumIntImp\" : \(value) }"

		let mappedObject = mapper.map(JSONString)
		expect(mappedObject).notTo(beNil())
		expect(mappedObject?.enumInt).to(equal(BasicTypes.EnumInt.Default))
		expect(mappedObject?.enumIntOptional).to(beNil())
		expect(mappedObject?.enumIntImplicitlyUnwrapped).to(beNil())
	}

	func testMappingDoubleEnumFromJSON(){
		let value: BasicTypes.EnumDouble = .Another
		let JSONString = "{\"enumDouble\" : \(value.rawValue), \"enumDoubleOpt\" : \(value.rawValue), \"enumDoubleImp\" : \(value.rawValue) }"

		let mappedObject = mapper.map(JSONString)
		expect(mappedObject).notTo(beNil())
		expect(mappedObject?.enumDouble).to(equal(value))
		expect(mappedObject?.enumDoubleOptional).to(equal(value))
		expect(mappedObject?.enumDoubleImplicitlyUnwrapped).to(equal(value))
	}

	func testMappingFloatEnumFromJSON(){
		let value: BasicTypes.EnumFloat = .Another
		let JSONString = "{\"enumFloat\" : \(value.rawValue), \"enumFloatOpt\" : \(value.rawValue), \"enumFloatImp\" : \(value.rawValue) }"

		let mappedObject = mapper.map(JSONString)
		expect(mappedObject).notTo(beNil())
		expect(mappedObject?.enumFloat).to(equal(value))
		expect(mappedObject?.enumFloatOptional).to(equal(value))
		expect(mappedObject?.enumFloatImplicitlyUnwrapped).to(equal(value))
	}

	func testMappingStringEnumFromJSON(){
		let value: BasicTypes.EnumString = .Another
		let JSONString = "{\"enumString\" : \"\(value.rawValue)\", \"enumStringOpt\" : \"\(value.rawValue)\", \"enumStringImp\" : \"\(value.rawValue)\" }"

		let mappedObject = mapper.map(JSONString)
		expect(mappedObject).notTo(beNil())
		expect(mappedObject?.enumString).to(equal(value))
		expect(mappedObject?.enumStringOptional).to(equal(value))
		expect(mappedObject?.enumStringImplicitlyUnwrapped).to(equal(value))
	}

	func testMappingEnumIntArrayFromJSON(){
		let value: BasicTypes.EnumInt = .Another
		let JSONString = "{ \"arrayEnumInt\" : [\(value.rawValue)], \"arrayEnumIntOpt\" : [\(value.rawValue)], \"arrayEnumIntImp\" : [\(value.rawValue)] }"

		let mappedObject = mapper.map(JSONString)
		expect(mappedObject).notTo(beNil())
		expect(mappedObject?.arrayEnumInt.first).to(equal(value))
		expect(mappedObject?.arrayEnumIntOptional?.first).to(equal(value))
		expect(mappedObject?.arrayEnumIntImplicitlyUnwrapped?.first).to(equal(value))
	}

	func testMappingEnumIntArrayFromJSONShouldNotCrashWithNonDefinedvalue() {
		let value = Int.min
		let JSONString = "{ \"arrayEnumInt\" : [\(value)], \"arrayEnumIntOpt\" : [\(value)], \"arrayEnumIntImp\" : [\(value)] }"

		let mappedObject = mapper.map(JSONString)
		expect(mappedObject).notTo(beNil())
		expect(mappedObject?.arrayEnumInt.first).to(beNil())
		expect(mappedObject?.arrayEnumIntOptional?.first).to(beNil())
		expect(mappedObject?.arrayEnumIntImplicitlyUnwrapped?.first).to(beNil())
	}

	func testMappingEnumIntDictionaryFromJSON(){
		let key = "key"
		let value: BasicTypes.EnumInt = .Another
		let JSONString = "{ \"dictEnumInt\" : { \"\(key)\" : \(value.rawValue) }, \"dictEnumIntOpt\" : { \"\(key)\" : \(value.rawValue) }, \"dictEnumIntImp\" : { \"\(key)\" : \(value.rawValue) } }"

		let mappedObject = mapper.map(JSONString)
		expect(mappedObject).notTo(beNil())
		expect(mappedObject?.dictEnumInt[key]).to(equal(value))
		expect(mappedObject?.dictEnumIntOptional?[key]).to(equal(value))
		expect(mappedObject?.dictEnumIntImplicitlyUnwrapped?[key]).to(equal(value))
	}

	func testMappingEnumIntDictionaryFromJSONShouldNotCrashWithNonDefinedvalue() {
		let key = "key"
		let value = Int.min
		let JSONString = "{ \"dictEnumInt\" : { \"\(key)\" : \(value) }, \"dictEnumIntOpt\" : { \"\(key)\" : \(value) }, \"dictEnumIntImp\" : { \"\(key)\" : \(value) } }"

		let mappedObject = mapper.map(JSONString)
		expect(mappedObject).notTo(beNil())
		expect(mappedObject?.arrayEnumInt.first).to(beNil())
		expect(mappedObject?.dictEnumIntOptional?[key]).to(beNil())
		expect(mappedObject?.dictEnumIntImplicitlyUnwrapped?[key]).to(beNil())
	}

	func testObjectModelOptionalDictionnaryOfPrimitives() {
		let JSON: [String: [String: AnyObject]] = ["dictStringString":["string": "string"], "dictStringBool":["string": false], "dictStringInt":["string": 1], "dictStringDouble":["string": 1.1], "dictStringFloat":["string": 1.2]]
		
		let mapper = Mapper<TestCollectionOfPrimitives>()
		let testSet: TestCollectionOfPrimitives! = mapper.map(JSON)
		expect(testSet).notTo(beNil())

		expect(testSet.dictStringString).notTo(beEmpty())
		expect(testSet.dictStringInt).notTo(beEmpty())
		expect(testSet.dictStringBool).notTo(beEmpty())
		expect(testSet.dictStringDouble).notTo(beEmpty())
		expect(testSet.dictStringFloat).notTo(beEmpty())
	}
}
