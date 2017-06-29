//
//  BasicTypesFromJSON.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2015-02-17.
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
		
		let mappedObject = mapper.map(JSONString: JSONString)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.bool, value)
		XCTAssertEqual(mappedObject?.boolOptional, value)
		XCTAssertEqual(mappedObject?.boolImplicityUnwrapped, value)
	}

	/// - warning: This test doens't consider integer overflow/underflow.
	func testMappingIntegerFromJSON(){
		func parameterize<T: FixedWidthInteger>(_ type: T.Type) {
			let value: T = 123
			let json: [String: Any] = [
				"int": value,
				"intOpt": value,
				"intImp": value,
				
				"int8": value,
				"int8Opt": value,
				"int8Imp": value,
				
				"int16": value,
				"int16Opt": value,
				"int16Imp": value,
				
				"int32": value,
				"int32Opt": value,
				"int32Imp": value,
				
				"int64": value,
				"int64Opt": value,
				"int64Imp": value,
				
				"uint": value,
				"uintOpt": value,
				"uintImp": value,
				
				"uint8": value,
				"uint8Opt": value,
				"uint8Imp": value,
				
				"uint16": value,
				"uint16Opt": value,
				"uint16Imp": value,
				
				"uint32": value,
				"uint32Opt": value,
				"uint32Imp": value,
				
				"uint64": value,
				"uint64Opt": value,
				"uint64Imp": value,
			]
			let mappedObject = mapper.map(JSON: json)
			XCTAssertNotNil(mappedObject)
			
			XCTAssertEqual(mappedObject?.int, 123)
			XCTAssertEqual(mappedObject?.intOptional, 123)
			XCTAssertEqual(mappedObject?.intImplicityUnwrapped, 123)
			
			XCTAssertEqual(mappedObject?.int8, 123)
			XCTAssertEqual(mappedObject?.int8Optional, 123)
			XCTAssertEqual(mappedObject?.int8ImplicityUnwrapped, 123)
			
			XCTAssertEqual(mappedObject?.int16, 123)
			XCTAssertEqual(mappedObject?.int16Optional, 123)
			XCTAssertEqual(mappedObject?.int16ImplicityUnwrapped, 123)
			
			XCTAssertEqual(mappedObject?.int32, 123)
			XCTAssertEqual(mappedObject?.int32Optional, 123)
			XCTAssertEqual(mappedObject?.int32ImplicityUnwrapped, 123)
			
			XCTAssertEqual(mappedObject?.int64, 123)
			XCTAssertEqual(mappedObject?.int64Optional, 123)
			XCTAssertEqual(mappedObject?.int64ImplicityUnwrapped, 123)
			
			XCTAssertEqual(mappedObject?.uint, 123)
			XCTAssertEqual(mappedObject?.uintOptional, 123)
			XCTAssertEqual(mappedObject?.uintImplicityUnwrapped, 123)
			
			XCTAssertEqual(mappedObject?.uint8, 123)
			XCTAssertEqual(mappedObject?.uint8Optional, 123)
			XCTAssertEqual(mappedObject?.uint8ImplicityUnwrapped, 123)
			
			XCTAssertEqual(mappedObject?.uint16, 123)
			XCTAssertEqual(mappedObject?.uint16Optional, 123)
			XCTAssertEqual(mappedObject?.uint16ImplicityUnwrapped, 123)
			
			XCTAssertEqual(mappedObject?.uint32, 123)
			XCTAssertEqual(mappedObject?.uint32Optional, 123)
			XCTAssertEqual(mappedObject?.uint32ImplicityUnwrapped, 123)
			
			XCTAssertEqual(mappedObject?.uint64, 123)
			XCTAssertEqual(mappedObject?.uint64Optional, 123)
			XCTAssertEqual(mappedObject?.uint64ImplicityUnwrapped, 123)
		}
		
		parameterize(Int.self)
		parameterize(Int8.self)
		parameterize(Int16.self)
		parameterize(Int32.self)
		parameterize(Int64.self)
		
		parameterize(UInt.self)
		parameterize(UInt8.self)
		parameterize(UInt16.self)
		parameterize(UInt32.self)
		parameterize(UInt64.self)
	}

	func testMappingIntegerWithOverflowFromJSON(){
		let signedValue = Int.max
		let unsignedValue = UInt.max

		let json: [String: Any] = [
			"int": signedValue,
			"intOpt": signedValue,
			"intImp": signedValue,

			"int8": signedValue,
			"int8Opt": signedValue,
			"int8Imp": signedValue,

			"int16": signedValue,
			"int16Opt": signedValue,
			"int16Imp": signedValue,

			"int32": signedValue,
			"int32Opt": signedValue,
			"int32Imp": signedValue,

			"int64": signedValue,
			"int64Opt": signedValue,
			"int64Imp": signedValue,

			"uint": unsignedValue,
			"uintOpt": unsignedValue,
			"uintImp": unsignedValue,

			"uint8": unsignedValue,
			"uint8Opt": unsignedValue,
			"uint8Imp": unsignedValue,

			"uint16": unsignedValue,
			"uint16Opt": unsignedValue,
			"uint16Imp": unsignedValue,

			"uint32": unsignedValue,
			"uint32Opt": unsignedValue,
			"uint32Imp": unsignedValue,

			"uint64": unsignedValue,
			"uint64Opt": unsignedValue,
			"uint64Imp": unsignedValue,
		]
		let mappedObject = mapper.map(JSON: json)
		XCTAssertNotNil(mappedObject)

		XCTAssertEqual(mappedObject?.int, Int.max)
		XCTAssertEqual(mappedObject?.intOptional, Int.max)
		XCTAssertEqual(mappedObject?.intImplicityUnwrapped, Int.max)

		XCTAssertEqual(mappedObject?.int8, 0)
		XCTAssertEqual(mappedObject?.int8Optional, nil)
		XCTAssertEqual(mappedObject?.int8ImplicityUnwrapped, nil)

		XCTAssertEqual(mappedObject?.int16, 0)
		XCTAssertEqual(mappedObject?.int16Optional, nil)
		XCTAssertEqual(mappedObject?.int16ImplicityUnwrapped, nil)

#if arch(x86_64) || arch(arm64)
		XCTAssertEqual(mappedObject?.int32, 0)
		XCTAssertEqual(mappedObject?.int32Optional, nil)
		XCTAssertEqual(mappedObject?.int32ImplicityUnwrapped, nil)

		XCTAssertEqual(mappedObject?.int64, Int64.max)
		XCTAssertEqual(mappedObject?.int64Optional, Int64.max)
		XCTAssertEqual(mappedObject?.int64ImplicityUnwrapped, Int64.max)
#else
		XCTAssertEqual(mappedObject?.int32, Int32.max)
		XCTAssertEqual(mappedObject?.int32Optional, Int32.max)
		XCTAssertEqual(mappedObject?.int32ImplicityUnwrapped, Int32.max)

		XCTAssertEqual(mappedObject?.int64, Int64(Int32.max))
		XCTAssertEqual(mappedObject?.int64Optional, Int64(Int32.max))
		XCTAssertEqual(mappedObject?.int64ImplicityUnwrapped, Int64(Int32.max))
#endif

		XCTAssertEqual(mappedObject?.uint, UInt.max)
		XCTAssertEqual(mappedObject?.uintOptional, UInt.max)
		XCTAssertEqual(mappedObject?.uintImplicityUnwrapped, UInt.max)

		XCTAssertEqual(mappedObject?.uint8, 0)
		XCTAssertEqual(mappedObject?.uint8Optional, nil)
		XCTAssertEqual(mappedObject?.uint8ImplicityUnwrapped, nil)

		XCTAssertEqual(mappedObject?.uint16, 0)
		XCTAssertEqual(mappedObject?.uint16Optional, nil)
		XCTAssertEqual(mappedObject?.uint16ImplicityUnwrapped, nil)

#if arch(x86_64) || arch(arm64)
		XCTAssertEqual(mappedObject?.uint32, 0)
		XCTAssertEqual(mappedObject?.uint32Optional, nil)
		XCTAssertEqual(mappedObject?.uint32ImplicityUnwrapped, nil)

		XCTAssertEqual(mappedObject?.uint64, UInt64.max)
		XCTAssertEqual(mappedObject?.uint64Optional, UInt64.max)
		XCTAssertEqual(mappedObject?.uint64ImplicityUnwrapped, UInt64.max)
#else
		XCTAssertEqual(mappedObject?.uint32, UInt32.max)
		XCTAssertEqual(mappedObject?.uint32Optional, UInt32.max)
		XCTAssertEqual(mappedObject?.uint32ImplicityUnwrapped, UInt32.max)

		XCTAssertEqual(mappedObject?.uint64, UInt64(UInt32.max))
		XCTAssertEqual(mappedObject?.uint64Optional, UInt64(UInt32.max))
		XCTAssertEqual(mappedObject?.uint64ImplicityUnwrapped, UInt64(UInt32.max))
#endif
	}
	
	func testMappingDoubleFromJSON(){
		let value: Double = 11
		let JSONString = "{\"double\" : \(value), \"doubleOpt\" : \(value), \"doubleImp\" : \(value)}"

		let mappedObject = mapper.map(JSONString: JSONString)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.double, value)
		XCTAssertEqual(mappedObject?.doubleOptional, value)
		XCTAssertEqual(mappedObject?.doubleImplicityUnwrapped, value)
	}
	
	func testMappingFloatFromJSON(){
		let value: Float = 11
		let JSONString = "{\"float\" : \(value), \"floatOpt\" : \(value), \"floatImp\" : \(value)}"
		
		let mappedObject = mapper.map(JSONString: JSONString)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.float, value)
		XCTAssertEqual(mappedObject?.floatOptional, value)
		XCTAssertEqual(mappedObject?.floatImplicityUnwrapped, value)
	}
	
	func testMappingStringFromJSON(){
		let value: String = "STRINGNGNGG"
		let JSONString = "{\"string\" : \"\(value)\", \"stringOpt\" : \"\(value)\", \"stringImp\" : \"\(value)\"}"

		let mappedObject = mapper.map(JSONString: JSONString)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.string, value)
		XCTAssertEqual(mappedObject?.stringOptional, value)
		XCTAssertEqual(mappedObject?.stringImplicityUnwrapped, value)
	}
	
	func testMappingAnyObjectFromJSON(){
		let value1 = "STRING"
		let value2: Int = 1234
		let value3: Double = 11.11
		let JSONString = "{\"anyObject\" : \"\(value1)\", \"anyObjectOpt\" : \(value2), \"anyObjectImp\" : \(value3)}"
		
		let mappedObject = mapper.map(JSONString: JSONString)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.anyObject as? String, value1)
		XCTAssertEqual(mappedObject?.anyObjectOptional as? Int, value2)
		XCTAssertEqual(mappedObject?.anyObjectImplicitlyUnwrapped as? Double, value3)
	}

	func testMappingStringFromNSStringJSON(){
		let value: String = "STRINGNGNGG"
		let JSONNSString : NSString = "{\"string\" : \"\(value)\", \"stringOpt\" : \"\(value)\", \"stringImp\" : \"\(value)\"}" as NSString
		
		let mappedObject = mapper.map(JSONString: JSONNSString as String)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.string, value)
		XCTAssertEqual(mappedObject?.stringOptional, value)
		XCTAssertEqual(mappedObject?.stringImplicityUnwrapped, value)
	}

	// MARK: Test mapping Arrays to JSON and back (with basic types in them Bool, Int, Double, Float, String)
	
	func testMappingBoolArrayFromJSON(){
		let value: Bool = true
		let JSONString = "{\"arrayBool\" : [\(value)], \"arrayBoolOpt\" : [\(value)], \"arrayBoolImp\" : [\(value)] }"

		let mappedObject = mapper.map(JSONString: JSONString)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.arrayBool.first, value)
		XCTAssertEqual(mappedObject?.arrayBoolOptional?.first, value)
		XCTAssertEqual(mappedObject?.arrayBoolImplicityUnwrapped.first, value)
	}
	
	func testMappingIntArrayFromJSON(){
		let value: Int = 1
		let JSONString = "{\"arrayInt\" : [\(value)], \"arrayIntOpt\" : [\(value)], \"arrayIntImp\" : [\(value)] }"

		let mappedObject = mapper.map(JSONString: JSONString)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.arrayInt.first, value)
		XCTAssertEqual(mappedObject?.arrayIntOptional?.first, value)
		XCTAssertEqual(mappedObject?.arrayIntImplicityUnwrapped.first, value)
	}
	
	func testMappingDoubleArrayFromJSON(){
		let value: Double = 1.0
		let JSONString = "{\"arrayDouble\" : [\(value)], \"arrayDoubleOpt\" : [\(value)], \"arrayDoubleImp\" : [\(value)] }"

		let mappedObject = mapper.map(JSONString: JSONString)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.arrayDouble.first, value)
		XCTAssertEqual(mappedObject?.arrayDoubleOptional?.first, value)
		XCTAssertEqual(mappedObject?.arrayDoubleImplicityUnwrapped.first, value)
	}
	
	func testMappingFloatArrayFromJSON(){
		let value: Float = 1.001
		let JSONString = "{\"arrayFloat\" : [\(value)], \"arrayFloatOpt\" : [\(value)], \"arrayFloatImp\" : [\(value)] }"
		
		let mappedObject = mapper.map(JSONString: JSONString)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.arrayFloat.first, value)
		XCTAssertEqual(mappedObject?.arrayFloatOptional?.first, value)
		XCTAssertEqual(mappedObject?.arrayFloatImplicityUnwrapped?.first, value)
	}
	
	func testMappingStringArrayFromJSON(){
		let value: String = "Stringgggg"
		let JSONString = "{\"arrayString\" : [\"\(value)\"], \"arrayStringOpt\" : [\"\(value)\"], \"arrayStringImp\" : [\"\(value)\"] }"
		
		let mappedObject = mapper.map(JSONString: JSONString)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.arrayString.first, value)
		XCTAssertEqual(mappedObject?.arrayStringOptional?.first, value)
		XCTAssertEqual(mappedObject?.arrayStringImplicityUnwrapped.first, value)
	}
	
	func testMappingAnyObjectArrayFromJSON(){
		let value1 = "STRING"
		let value2: Int = 1234
		let value3: Double = 11.11
		let JSONString = "{\"arrayAnyObject\" : [\"\(value1)\"], \"arrayAnyObjectOpt\" : [\(value2)], \"arrayAnyObjectImp\" : [\(value3)] }"
		
		let mappedObject = mapper.map(JSONString: JSONString)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.arrayAnyObject.first as? String, value1)
		XCTAssertEqual(mappedObject?.arrayAnyObjectOptional?.first as? Int, value2)
		XCTAssertEqual(mappedObject?.arrayAnyObjectImplicitlyUnwrapped.first as? Double, value3)
	}
	
	// MARK: Test mapping Dictionaries to JSON and back (with basic types in them Bool, Int, Double, Float, String)
	
	func testMappingBoolDictionaryFromJSON(){
		let key = "key"
		let value: Bool = true
		let JSONString = "{\"dictBool\" : { \"\(key)\" : \(value)}, \"dictBoolOpt\" : { \"\(key)\" : \(value)}, \"dictBoolImp\" : { \"\(key)\" : \(value)} }"
		
		let mappedObject = mapper.map(JSONString: JSONString)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.dictBool[key], value)
		XCTAssertEqual(mappedObject?.dictBoolOptional?[key], value)
		XCTAssertEqual(mappedObject?.dictBoolImplicityUnwrapped[key], value)
	}
	
	func testMappingIntDictionaryFromJSON(){
		let key = "key"
		let value: Int = 11
		let JSONString = "{\"dictInt\" : { \"\(key)\" : \(value)}, \"dictIntOpt\" : { \"\(key)\" : \(value)}, \"dictIntImp\" : { \"\(key)\" : \(value)} }"
		
		let mappedObject = mapper.map(JSONString: JSONString)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.dictInt[key], value)
		XCTAssertEqual(mappedObject?.dictIntOptional?[key], value)
		XCTAssertEqual(mappedObject?.dictIntImplicityUnwrapped[key], value)
	}
	
	func testMappingDoubleDictionaryFromJSON(){
		let key = "key"
		let value: Double = 11
		let JSONString = "{\"dictDouble\" : { \"\(key)\" : \(value)}, \"dictDoubleOpt\" : { \"\(key)\" : \(value)}, \"dictDoubleImp\" : { \"\(key)\" : \(value)} }"
		
		let mappedObject = mapper.map(JSONString: JSONString)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.dictDouble[key], value)
		XCTAssertEqual(mappedObject?.dictDoubleOptional?[key], value)
		XCTAssertEqual(mappedObject?.dictDoubleImplicityUnwrapped[key], value)
	}
	
	func testMappingFloatDictionaryFromJSON(){
		let key = "key"
		let value: Float = 111.1
		let JSONString = "{\"dictFloat\" : { \"\(key)\" : \(value)}, \"dictFloatOpt\" : { \"\(key)\" : \(value)}, \"dictFloatImp\" : { \"\(key)\" : \(value)} }"

		let mappedObject = mapper.map(JSONString: JSONString)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.dictFloat[key], value)
		XCTAssertEqual(mappedObject?.dictFloatOptional?[key], value)
		XCTAssertEqual(mappedObject?.dictFloatImplicityUnwrapped?[key], value)
	}
	
	func testMappingStringDictionaryFromJSON(){
		let key = "key"
		let value = "value"
		let JSONString = "{\"dictString\" : { \"\(key)\" : \"\(value)\"}, \"dictStringOpt\" : { \"\(key)\" : \"\(value)\"}, \"dictStringImp\" : { \"\(key)\" : \"\(value)\"} }"
		
		let mappedObject = mapper.map(JSONString: JSONString)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.dictString[key], value)
		XCTAssertEqual(mappedObject?.dictStringOptional?[key], value)
		XCTAssertEqual(mappedObject?.dictStringImplicityUnwrapped?[key], value)
	}
	
	func testMappingAnyObjectDictionaryFromJSON(){
		let key = "key"
		let value1 = "STRING"
		let value2: Int = 1234
		let value3: Double = 11.11
		let JSONString = "{\"dictAnyObject\" : { \"\(key)\" : \"\(value1)\"}, \"dictAnyObjectOpt\" : { \"\(key)\" : \(value2)}, \"dictAnyObjectImp\" : { \"\(key)\" : \(value3)} }"
		
		let mappedObject = mapper.map(JSONString: JSONString)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.dictAnyObject[key] as? String, value1)
		XCTAssertEqual(mappedObject?.dictAnyObjectOptional?[key] as? Int, value2)
		XCTAssertEqual(mappedObject?.dictAnyObjectImplicitlyUnwrapped[key] as? Double, value3)
	}

	func testMappingIntEnumFromJSON(){
		let value: BasicTypes.EnumInt = .Another
		let JSONString = "{\"enumInt\" : \(value.rawValue), \"enumIntOpt\" : \(value.rawValue), \"enumIntImp\" : \(value.rawValue) }"

		let mappedObject = mapper.map(JSONString: JSONString)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.enumInt, value)
		XCTAssertEqual(mappedObject?.enumIntOptional, value)
		XCTAssertEqual(mappedObject?.enumIntImplicitlyUnwrapped, value)
	}

	func testMappingIntEnumFromJSONShouldNotCrashWithNonDefinedvalue() {
		let value = Int.min
		let JSONString = "{\"enumInt\" : \(value), \"enumIntOpt\" : \(value), \"enumIntImp\" : \(value) }"

		let mappedObject = mapper.map(JSONString: JSONString)
		
		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.enumInt, BasicTypes.EnumInt.Default)
		XCTAssertNil(mappedObject?.enumIntOptional)
		XCTAssertNil(mappedObject?.enumIntImplicitlyUnwrapped)
	}

	func testMappingDoubleEnumFromJSON(){
		let value: BasicTypes.EnumDouble = .Another
		let JSONString = "{\"enumDouble\" : \(value.rawValue), \"enumDoubleOpt\" : \(value.rawValue), \"enumDoubleImp\" : \(value.rawValue) }"

		let mappedObject = mapper.map(JSONString: JSONString)
		
		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.enumDouble, value)
		XCTAssertEqual(mappedObject?.enumDoubleOptional, value)
		XCTAssertEqual(mappedObject?.enumDoubleImplicitlyUnwrapped, value)
	}

	func testMappingFloatEnumFromJSON(){
		let value: BasicTypes.EnumFloat = .Another
		let JSONString = "{\"enumFloat\" : \(value.rawValue), \"enumFloatOpt\" : \(value.rawValue), \"enumFloatImp\" : \(value.rawValue) }"

		let mappedObject = mapper.map(JSONString: JSONString)
		
		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.enumFloat, value)
		XCTAssertEqual(mappedObject?.enumFloatOptional, value)
		XCTAssertEqual(mappedObject?.enumFloatImplicitlyUnwrapped, value)
	}

	func testMappingStringEnumFromJSON(){
		let value: BasicTypes.EnumString = .Another
		let JSONString = "{\"enumString\" : \"\(value.rawValue)\", \"enumStringOpt\" : \"\(value.rawValue)\", \"enumStringImp\" : \"\(value.rawValue)\" }"

		let mappedObject = mapper.map(JSONString: JSONString)
		
		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.enumString, value)
		XCTAssertEqual(mappedObject?.enumStringOptional, value)
		XCTAssertEqual(mappedObject?.enumStringImplicitlyUnwrapped, value)
	}

	func testMappingEnumIntArrayFromJSON(){
		let value: BasicTypes.EnumInt = .Another
		let JSONString = "{ \"arrayEnumInt\" : [\(value.rawValue)], \"arrayEnumIntOpt\" : [\(value.rawValue)], \"arrayEnumIntImp\" : [\(value.rawValue)] }"

		let mappedObject = mapper.map(JSONString: JSONString)
		
		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.arrayEnumInt.first, value)
		XCTAssertEqual(mappedObject?.arrayEnumIntOptional?.first, value)
		XCTAssertEqual(mappedObject?.arrayEnumIntImplicitlyUnwrapped.first, value)
	}

	func testMappingEnumIntArrayFromJSONShouldNotCrashWithNonDefinedvalue() {
		let value = Int.min
		let JSONString = "{ \"arrayEnumInt\" : [\(value)], \"arrayEnumIntOpt\" : [\(value)], \"arrayEnumIntImp\" : [\(value)] }"

		let mappedObject = mapper.map(JSONString: JSONString)
		
		XCTAssertNotNil(mappedObject)
		XCTAssertNil(mappedObject?.arrayEnumInt.first)
		XCTAssertNil(mappedObject?.arrayEnumIntOptional?.first)
		XCTAssertNil(mappedObject?.arrayEnumIntImplicitlyUnwrapped.first)
	}

	func testMappingEnumIntDictionaryFromJSON(){
		let key = "key"
		let value: BasicTypes.EnumInt = .Another
		let JSONString = "{ \"dictEnumInt\" : { \"\(key)\" : \(value.rawValue) }, \"dictEnumIntOpt\" : { \"\(key)\" : \(value.rawValue) }, \"dictEnumIntImp\" : { \"\(key)\" : \(value.rawValue) } }"

		let mappedObject = mapper.map(JSONString: JSONString)
		
		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.dictEnumInt[key], value)
		XCTAssertEqual(mappedObject?.dictEnumIntOptional?[key], value)
		XCTAssertEqual(mappedObject?.dictEnumIntImplicitlyUnwrapped[key], value)
	}

	func testMappingEnumIntDictionaryFromJSONShouldNotCrashWithNonDefinedvalue() {
		let key = "key"
		let value = Int.min
		let JSONString = "{ \"dictEnumInt\" : { \"\(key)\" : \(value) }, \"dictEnumIntOpt\" : { \"\(key)\" : \(value) }, \"dictEnumIntImp\" : { \"\(key)\" : \(value) } }"

		let mappedObject = mapper.map(JSONString: JSONString)
		
		XCTAssertNotNil(mappedObject)
		XCTAssertNil(mappedObject?.dictEnumInt[key])
		XCTAssertNil(mappedObject?.dictEnumIntOptional?[key])
		XCTAssertNil(mappedObject?.dictEnumIntImplicitlyUnwrapped[key])
	}

	func testObjectModelOptionalDictionnaryOfPrimitives() {
		let JSON: [String: [String: Any]] = ["dictStringString":["string": "string"], "dictStringBool":["string": false], "dictStringInt":["string": 1], "dictStringDouble":["string": 1.1], "dictStringFloat":["string": Float(1.2)]]
		
		let mapper = Mapper<TestCollectionOfPrimitives>()
		let testSet: TestCollectionOfPrimitives! = mapper.map(JSON: JSON)

		XCTAssertNotNil(testSet)

		XCTAssertTrue(testSet.dictStringString.count > 0)
		XCTAssertTrue(testSet.dictStringInt.count > 0)
		XCTAssertTrue(testSet.dictStringBool.count > 0)
		XCTAssertTrue(testSet.dictStringDouble.count > 0)
		XCTAssertTrue(testSet.dictStringFloat.count > 0)
	}
}
