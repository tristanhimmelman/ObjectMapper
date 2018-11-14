//
//  BasicTypesTests.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2014-12-04.
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

class BasicTypesTestsToJSON: XCTestCase {

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
	
	func testShouldIncludeNilValues(){
		let object = BasicTypes()
		
		let JSONWithNil = Mapper<BasicTypes>(shouldIncludeNilValues: true).toJSONString(object, prettyPrint: true)
		let JSONWithoutNil = Mapper<BasicTypes>(shouldIncludeNilValues: false).toJSONString(object, prettyPrint: true)
		
		//TODO This test could be improved
		XCTAssertNotNil(JSONWithNil)
		XCTAssertTrue((JSONWithNil!.count) > 5)
		XCTAssertTrue((JSONWithNil!.count) != (JSONWithoutNil!.count))
	}
	
	func testMappingBoolToJSON(){
		let value: Bool = true
		let object = BasicTypes()
		object.bool = value
		object.boolOptional = value
		object.boolImplicityUnwrapped = value
		
		let JSONString = Mapper().toJSONString(object, prettyPrint: true)
		let mappedObject = mapper.map(JSONString: JSONString!)
		
		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.bool, value)
		XCTAssertEqual(mappedObject?.boolOptional, value)
		XCTAssertEqual(mappedObject?.boolImplicityUnwrapped, value)
	}
	
	func testMappingIntegerToJSON(){
		let object = BasicTypes()

		object.int = 123
		object.intOptional = 123
		object.intImplicityUnwrapped = 123

		object.int8 = 123
		object.int8Optional = 123
		object.int8ImplicityUnwrapped = 123

		object.int16 = 123
		object.int16Optional = 123
		object.int16ImplicityUnwrapped = 123

		object.int32 = 123
		object.int32Optional = 123
		object.int32ImplicityUnwrapped = 123

		object.int64 = 123
		object.int64Optional = 123
		object.int64ImplicityUnwrapped = 123

		object.uint = 123
		object.uintOptional = 123
		object.uintImplicityUnwrapped = 123

		object.uint8 = 123
		object.uint8Optional = 123
		object.uint8ImplicityUnwrapped = 123

		object.uint16 = 123
		object.uint16Optional = 123
		object.uint16ImplicityUnwrapped = 123

		object.uint32 = 123
		object.uint32Optional = 123
		object.uint32ImplicityUnwrapped = 123

		object.uint64 = 123
		object.uint64Optional = 123
		object.uint64ImplicityUnwrapped = 123

		let JSONString = Mapper().toJSONString(object, prettyPrint: true)
		let mappedObject = mapper.map(JSONString: JSONString!)

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

	func testMappingDoubleToJSON(){
		let value: Double = 11
		let object = BasicTypes()
		object.double = value
		object.doubleOptional = value
		object.doubleImplicityUnwrapped = value
		
		let JSONString = Mapper().toJSONString(object, prettyPrint: true)
		let mappedObject = mapper.map(JSONString: JSONString!)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.double, value)
		XCTAssertEqual(mappedObject?.doubleOptional, value)
		XCTAssertEqual(mappedObject?.doubleImplicityUnwrapped, value)
	}

	func testMappingFloatToJSON(){
		let value: Float = 11
		let object = BasicTypes()
		object.float = value
		object.floatOptional = value
		object.floatImplicityUnwrapped = value
		
		let JSONString = Mapper().toJSONString(object, prettyPrint: true)
		let mappedObject = mapper.map(JSONString: JSONString!)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.float, value)
		XCTAssertEqual(mappedObject?.floatOptional, value)
		XCTAssertEqual(mappedObject?.floatImplicityUnwrapped, value)
	}
	
	func testMappingStringToJSON(){
		let value: String = "STRINGNGNGG"
		let object = BasicTypes()
		object.string = value
		object.stringOptional = value
		object.stringImplicityUnwrapped = value
		
		let JSONString = Mapper().toJSONString(object, prettyPrint: true)
		let mappedObject = mapper.map(JSONString: JSONString!)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.string, value)
		XCTAssertEqual(mappedObject?.stringOptional, value)
		XCTAssertEqual(mappedObject?.stringImplicityUnwrapped, value)
	}
	
	func testMappingAnyObjectToJSON(){
		let value: String = "STRINGNGNGG"
		let object = BasicTypes()
		object.anyObject = value
		object.anyObjectOptional = value
		object.anyObjectImplicitlyUnwrapped = value
		
		let JSONString = Mapper().toJSONString(object, prettyPrint: true)
		let mappedObject = mapper.map(JSONString: JSONString!)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.anyObject as? String, value)
		XCTAssertEqual(mappedObject?.anyObjectOptional as? String, value)
		XCTAssertEqual(mappedObject?.anyObjectImplicitlyUnwrapped as? String, value)
	}
	
	// MARK: Test mapping Arrays to JSON and back (with basic types in them Bool, Int, Double, Float, String)
	
	func testMappingEmptyArrayToJSON(){
		let object = BasicTypes()
		object.arrayBool = []
		object.arrayBoolOptional = []
		object.arrayBoolImplicityUnwrapped = []
		
		let JSONString = Mapper().toJSONString(object, prettyPrint: true)
		let mappedObject = mapper.map(JSONString: JSONString!)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject!.arrayBool, [])
		XCTAssertEqual(mappedObject!.arrayBoolOptional!, [])
		XCTAssertEqual(mappedObject!.arrayBoolImplicityUnwrapped, [])
	}
	
	func testMappingBoolArrayToJSON(){
		let value: Bool = true
		let object = BasicTypes()
		object.arrayBool = [value]
		object.arrayBoolOptional = [value]
		object.arrayBoolImplicityUnwrapped = [value]
		
		let JSONString = Mapper().toJSONString(object, prettyPrint: true)
		let mappedObject = mapper.map(JSONString: JSONString!)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.arrayBool.first, value)
		XCTAssertEqual(mappedObject?.arrayBoolOptional?.first, value)
		XCTAssertEqual(mappedObject?.arrayBoolImplicityUnwrapped.first, value)
	}
	
	func testMappingIntArrayToJSON(){
		let value: Int = 1
		let object = BasicTypes()
		object.arrayInt = [value]
		object.arrayIntOptional = [value]
		object.arrayIntImplicityUnwrapped = [value]
		
		let JSONString = Mapper().toJSONString(object, prettyPrint: true)
		let mappedObject = mapper.map(JSONString: JSONString!)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.arrayInt.first, value)
		XCTAssertEqual(mappedObject?.arrayIntOptional?.first, value)
		XCTAssertEqual(mappedObject?.arrayIntImplicityUnwrapped.first, value)
	}
	
	func testMappingDoubleArrayToJSON(){
		let value: Double = 1.0
		let object = BasicTypes()
		object.arrayDouble = [value]
		object.arrayDoubleOptional = [value]
		object.arrayDoubleImplicityUnwrapped = [value]
		
		let JSONString = Mapper().toJSONString(object, prettyPrint: true)
		let mappedObject = mapper.map(JSONString: JSONString!)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.arrayDouble.first, value)
		XCTAssertEqual(mappedObject?.arrayDoubleOptional?.first, value)
		XCTAssertEqual(mappedObject?.arrayDoubleImplicityUnwrapped.first, value)
	}
	
	func testMappingFloatArrayToJSON(){
		let value: Float = 1.001
		let object = BasicTypes()
		object.arrayFloat = [value]
		object.arrayFloatOptional = [value]
		object.arrayFloatImplicityUnwrapped = [value]
		
		let JSONString = Mapper().toJSONString(object, prettyPrint: true)
		let mappedObject = mapper.map(JSONString: JSONString!)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.arrayFloat.first, value)
		XCTAssertEqual(mappedObject?.arrayFloatOptional?.first, value)
		XCTAssertEqual(mappedObject?.arrayFloatImplicityUnwrapped.first, value)
	}
	
	func testMappingStringArrayToJSON(){
		let value: String = "Stringgggg"
		let object = BasicTypes()
		object.arrayString = [value]
		object.arrayStringOptional = [value]
		object.arrayStringImplicityUnwrapped = [value]
		
		let JSONString = Mapper().toJSONString(object, prettyPrint: true)
		let mappedObject = mapper.map(JSONString: JSONString!)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.arrayString.first, value)
		XCTAssertEqual(mappedObject?.arrayStringOptional?.first, value)
		XCTAssertEqual(mappedObject?.arrayStringImplicityUnwrapped.first, value)
	}
	
	func testMappingAnyObjectArrayToJSON(){
		let value: String = "Stringgggg"
		let object = BasicTypes()
		object.arrayAnyObject = [value]
		object.arrayAnyObjectOptional = [value]
		object.arrayAnyObjectImplicitlyUnwrapped = [value]
		
		let JSONString = Mapper().toJSONString(object, prettyPrint: true)
		let mappedObject = mapper.map(JSONString: JSONString!)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.arrayAnyObject.first as? String, value)
		XCTAssertEqual(mappedObject?.arrayAnyObjectOptional?.first as? String, value)
		XCTAssertEqual(mappedObject?.arrayAnyObjectImplicitlyUnwrapped.first as? String, value)
	}
	
	// MARK: Test mapping Dictionaries to JSON and back (with basic types in them Bool, Int, Double, Float, String)
	
	func testMappingEmptyDictionaryToJSON(){
		let object = BasicTypes()
		object.dictBool = [:]
		object.dictBoolOptional = [:]
		object.dictBoolImplicityUnwrapped = [:]
		
		let JSONString = Mapper().toJSONString(object, prettyPrint: true)
		let mappedObject = mapper.map(JSONString: JSONString!)
		
		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject!.dictBool, [:])
		XCTAssertEqual(mappedObject!.dictBoolOptional!, [:])
		XCTAssertEqual(mappedObject!.dictBoolImplicityUnwrapped, [:])
	}
	
	func testMappingBoolDictionaryToJSON(){
		let key = "key"
		let value: Bool = true
		let object = BasicTypes()
		object.dictBool = [key:value]
		object.dictBoolOptional = [key:value]
		object.dictBoolImplicityUnwrapped = [key:value]
		
		let JSONString = Mapper().toJSONString(object, prettyPrint: true)
		let mappedObject = mapper.map(JSONString: JSONString!)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.dictBool[key], value)
		XCTAssertEqual(mappedObject?.dictBoolOptional?[key], value)
		XCTAssertEqual(mappedObject?.dictBoolImplicityUnwrapped[key], value)
	}
	
	func testMappingIntDictionaryToJSON(){
		let key = "key"
		let value: Int = 11
		let object = BasicTypes()
		object.dictInt = [key:value]
		object.dictIntOptional = [key:value]
		object.dictIntImplicityUnwrapped = [key:value]
		
		let JSONString = Mapper().toJSONString(object, prettyPrint: true)
		let mappedObject = mapper.map(JSONString: JSONString!)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.dictInt[key], value)
		XCTAssertEqual(mappedObject?.dictIntOptional?[key], value)
		XCTAssertEqual(mappedObject?.dictIntImplicityUnwrapped[key], value)
	}
	
	func testMappingDoubleDictionaryToJSON(){
		let key = "key"
		let value: Double = 11
		let object = BasicTypes()
		object.dictDouble = [key:value]
		object.dictDoubleOptional = [key:value]
		object.dictDoubleImplicityUnwrapped = [key:value]
		
		let JSONString = Mapper().toJSONString(object, prettyPrint: true)
		let mappedObject = mapper.map(JSONString: JSONString!)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.dictDouble[key], value)
		XCTAssertEqual(mappedObject?.dictDoubleOptional?[key], value)
		XCTAssertEqual(mappedObject?.dictDoubleImplicityUnwrapped[key], value)
	}
	
	func testMappingFloatDictionaryToJSON(){
		let key = "key"
		let value: Float = 11
		let object = BasicTypes()
		object.dictFloat = [key:value]
		object.dictFloatOptional = [key:value]
		object.dictFloatImplicityUnwrapped = [key:value]
		
		let JSONString = Mapper().toJSONString(object, prettyPrint: true)
		let mappedObject = mapper.map(JSONString: JSONString!)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.dictFloat[key], value)
		XCTAssertEqual(mappedObject?.dictFloatOptional?[key], value)
		XCTAssertEqual(mappedObject?.dictFloatImplicityUnwrapped[key], value)
	}
	
	func testMappingStringDictionaryToJSON(){
		let key = "key"
		let value = "value"
		let object = BasicTypes()
		object.dictString = [key:value]
		object.dictStringOptional = [key:value]
		object.dictStringImplicityUnwrapped = [key:value]
		
		let JSONString = Mapper().toJSONString(object, prettyPrint: true)
		let mappedObject = mapper.map(JSONString: JSONString!)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.dictString[key], value)
		XCTAssertEqual(mappedObject?.dictStringOptional?[key], value)
		XCTAssertEqual(mappedObject?.dictStringImplicityUnwrapped[key], value)
	}

	func testMappingAnyObjectDictionaryToJSON(){
		let key = "key"
		let value = "value"
		let object = BasicTypes()
		object.dictAnyObject = [key:value]
		object.dictAnyObjectOptional = [key:value]
		object.dictAnyObjectImplicitlyUnwrapped = [key:value]
		
		let JSONString = Mapper().toJSONString(object, prettyPrint: true)
		let mappedObject = mapper.map(JSONString: JSONString!)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.dictAnyObject[key] as? String, value)
		XCTAssertEqual(mappedObject?.dictAnyObjectOptional?[key] as? String, value)
		XCTAssertEqual(mappedObject?.dictAnyObjectImplicitlyUnwrapped[key] as? String, value)
	}

	func testMappingIntEnumToJSON(){
		let value = BasicTypes.EnumInt.Another
		let object = BasicTypes()
		object.enumInt = value
		object.enumIntOptional = value
		object.enumIntImplicitlyUnwrapped = value

		let JSONString = Mapper().toJSONString(object, prettyPrint: true)
		let mappedObject = mapper.map(JSONString: JSONString!)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.enumInt, value)
		XCTAssertEqual(mappedObject?.enumIntOptional, value)
		XCTAssertEqual(mappedObject?.enumIntImplicitlyUnwrapped, value)
	}

	func testMappingDoubleEnumToJSON(){
		let value = BasicTypes.EnumDouble.Another
		let object = BasicTypes()
		object.enumDouble = value
		object.enumDoubleOptional = value
		object.enumDoubleImplicitlyUnwrapped = value

		let JSONString = Mapper().toJSONString(object, prettyPrint: true)
		let mappedObject = mapper.map(JSONString: JSONString!)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.enumDouble, value)
		XCTAssertEqual(mappedObject?.enumDoubleOptional, value)
		XCTAssertEqual(mappedObject?.enumDoubleImplicitlyUnwrapped, value)
	}

	func testMappingFloatEnumToJSON(){
		let value = BasicTypes.EnumFloat.Another
		let object = BasicTypes()
		object.enumFloat = value
		object.enumFloatOptional = value
		object.enumFloatImplicitlyUnwrapped = value

		let JSONString = Mapper().toJSONString(object, prettyPrint: true)
		let mappedObject = mapper.map(JSONString: JSONString!)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.enumFloat, value)
		XCTAssertEqual(mappedObject?.enumFloatOptional, value)
		XCTAssertEqual(mappedObject?.enumFloatImplicitlyUnwrapped, value)
	}

	func testMappingStringEnumToJSON(){
		let value = BasicTypes.EnumString.Another
		let object = BasicTypes()
		object.enumString = value
		object.enumStringOptional = value
		object.enumStringImplicitlyUnwrapped = value

		let JSONString = Mapper().toJSONString(object, prettyPrint: true)
		let mappedObject = mapper.map(JSONString: JSONString!)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.enumString, value)
		XCTAssertEqual(mappedObject?.enumStringOptional, value)
		XCTAssertEqual(mappedObject?.enumStringImplicitlyUnwrapped, value)
	}

	func testMappingEnumIntArrayToJSON(){
		let value = BasicTypes.EnumInt.Another
		let object = BasicTypes()
		object.arrayEnumInt = [value]
		object.arrayEnumIntOptional = [value]
		object.arrayEnumIntImplicitlyUnwrapped = [value]

		let JSONString = Mapper().toJSONString(object, prettyPrint: true)
		let mappedObject = mapper.map(JSONString: JSONString!)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.arrayEnumInt.first, value)
		XCTAssertEqual(mappedObject?.arrayEnumIntOptional?.first, value)
		XCTAssertEqual(mappedObject?.arrayEnumIntImplicitlyUnwrapped.first, value)
	}

	func testMappingEnumIntDictionaryToJSON(){
		let key = "key"
		let value = BasicTypes.EnumInt.Another
		let object = BasicTypes()
		object.dictEnumInt = [key: value]
		object.dictEnumIntOptional = [key: value]
		object.dictEnumIntImplicitlyUnwrapped = [key: value]

		let JSONString = Mapper().toJSONString(object, prettyPrint: true)
		let mappedObject = mapper.map(JSONString: JSONString!)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.dictEnumInt[key], value)
		XCTAssertEqual(mappedObject?.dictEnumIntOptional?[key], value)
		XCTAssertEqual(mappedObject?.dictEnumIntImplicitlyUnwrapped[key], value)
	}

	func testObjectToModelDictionnaryOfPrimitives() {
		let object = TestCollectionOfPrimitives()
		object.dictStringString = ["string": "string"]
		object.dictStringBool = ["string": false]
		object.dictStringInt = ["string": 1]
		object.dictStringDouble = ["string": 1.2]
		object.dictStringFloat = ["string": 1.3]
		
		let json = Mapper<TestCollectionOfPrimitives>().toJSON(object)

		XCTAssertTrue((json["dictStringString"] as? [String:String])?.count ?? 0 > 0)
		XCTAssertTrue((json["dictStringBool"] as? [String:Bool])?.count ?? 0 > 0)
		XCTAssertTrue((json["dictStringInt"] as? [String:Int])?.count ?? 0 > 0)
		XCTAssertTrue((json["dictStringDouble"] as? [String:Double])?.count ?? 0 > 0)
		XCTAssertTrue((json["dictStringFloat"] as? [String:Float])?.count ?? 0 > 0)
		XCTAssertEqual((json["dictStringString"] as? [String:String])?["string"], "string")
	}
}
