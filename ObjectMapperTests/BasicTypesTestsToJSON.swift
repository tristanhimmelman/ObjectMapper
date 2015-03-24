//
//  BasicTypesTests.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2014-12-04.
//  Copyright (c) 2014 hearst. All rights reserved.
//

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
	
	func testMappingBoolToJSON(){
		var value: Bool = true
		var object = BasicTypes()
		object.bool = value
		object.boolOptional = value
		object.boolImplicityUnwrapped = value
		
		let JSON = Mapper().toJSONString(object, prettyPrint: true)
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			XCTAssertEqual(mappedObject.bool, value, "Bool failed")
			XCTAssertEqual(mappedObject.boolOptional!, value, "Optional Bool failed")
			XCTAssertEqual(mappedObject.boolImplicityUnwrapped, value, "Implicitly unwrapped optional Bool failed")
		} else {
			XCTAssert(false, "Bool to JSON failed")
		}
	}
	
	func testMappingIntToJSON(){
		var value: Int = 11
		var object = BasicTypes()
		object.int = value
		object.intOptional = value
		object.intImplicityUnwrapped = value
		
		let JSON = Mapper().toJSONString(object, prettyPrint: true)
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			XCTAssertEqual(mappedObject.int, value, "Int failed")
			XCTAssertEqual(mappedObject.intOptional!, value, "Optional Int failed")
			XCTAssertEqual(mappedObject.intImplicityUnwrapped, value, "Implicity unwrapped optional Int failed")
		} else {
			XCTAssert(false, "Int to JSON failed")
		}
	}

	func testMappingDoubleToJSON(){
		var value: Double = 11
		var object = BasicTypes()
		object.double = value
		object.doubleOptional = value
		object.doubleImplicityUnwrapped = value
		
		let JSON = Mapper().toJSONString(object, prettyPrint: true)
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			XCTAssertEqual(mappedObject.double, value, "Double failed")
			XCTAssertEqual(mappedObject.doubleOptional!, value, "Optional Double failed")
			XCTAssertEqual(mappedObject.doubleImplicityUnwrapped, value, "Implicity unwrapped optional Double failed")
		} else {
			XCTAssert(false, "Double to JSON failed")
		}
	}

	func testMappingFloatToJSON(){
		var value: Float = 11
		var object = BasicTypes()
		object.float = value
		object.floatOptional = value
		object.floatImplicityUnwrapped = value
		
		let JSON = Mapper().toJSONString(object, prettyPrint: true)
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			XCTAssertEqual(mappedObject.float, value, "Float failed")
			XCTAssertEqual(mappedObject.floatOptional!, value, "Optional Float failed")
			XCTAssertEqual(mappedObject.floatImplicityUnwrapped, value, "Implicity unwrapped optional Float failed")
		} else {
			XCTAssert(false, "Float to JSON failed")
		}
	}
	
	func testMappingStringToJSON(){
		var value: String = "STRINGNGNGG"
		var object = BasicTypes()
		object.string = value
		object.stringOptional = value
		object.stringImplicityUnwrapped = value
		
		let JSON = Mapper().toJSONString(object, prettyPrint: true)
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			XCTAssertEqual(mappedObject.string, value, "String failed")
			XCTAssertEqual(mappedObject.stringOptional!, value, "Optional String failed")
			XCTAssertEqual(mappedObject.stringImplicityUnwrapped, value, "Implicity unwrapped optional String failed")
		} else {
			XCTAssert(false, "String to JSON failed")
		}
	}
	
	func testMappingAnyObjectToJSON(){
		var value: String = "STRINGNGNGG"
		var object = BasicTypes()
		object.anyObject = value
		object.anyObjectOptional = value
		object.anyObjectImplicitlyUnwrapped = value
		
		let JSON = Mapper().toJSONString(object, prettyPrint: true)
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			XCTAssertEqual(mappedObject.anyObject as! String, value, "AnyObject failed")
			XCTAssertEqual(mappedObject.anyObjectOptional! as! String, value, "Optional AnyObject failed")
			XCTAssertEqual(mappedObject.anyObjectImplicitlyUnwrapped as! String, value, "Implicity unwrapped Optional AnyObject failed")
		} else {
			XCTAssert(false, "String to JSON failed")
		}
	}
	
	// MARK: Test mapping Arrays to JSON and back (with basic types in them Bool, Int, Double, Float, String)
	
	func testMappingBoolArrayToJSON(){
		var value: Bool = true
		var object = BasicTypes()
		object.arrayBool = [value]
		object.arrayBoolOptional = [value]
		object.arrayBoolImplicityUnwrapped = [value]
		
		let JSON = Mapper().toJSONString(object, prettyPrint: true)
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			XCTAssertEqual(mappedObject.arrayBool[0], value, "Bool Array failed")
			XCTAssertEqual(mappedObject.arrayBoolOptional![0], value, "Optional Bool Array failed")
			XCTAssertEqual(mappedObject.arrayBoolImplicityUnwrapped[0], value, "Implicity unwrapped optional Bool Array failed")
		} else {
			XCTAssert(false, "Bool Array to JSON failed")
		}
	}
	
	func testMappingIntArrayToJSON(){
		var value: Int = 1
		var object = BasicTypes()
		object.arrayInt = [value]
		object.arrayIntOptional = [value]
		object.arrayIntImplicityUnwrapped = [value]
		
		let JSON = Mapper().toJSONString(object, prettyPrint: true)
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			XCTAssertEqual(mappedObject.arrayInt[0], value, "Int Array failed")
			XCTAssertEqual(mappedObject.arrayIntOptional![0], value, "Optional Int Array failed")
			XCTAssertEqual(mappedObject.arrayIntImplicityUnwrapped[0], value, "Implicity unwrapped optional Int Array failed")
		} else {
			XCTAssert(false, "Int Array to JSON failed")
		}
	}
	
	func testMappingDoubleArrayToJSON(){
		var value: Double = 1.0
		var object = BasicTypes()
		object.arrayDouble = [value]
		object.arrayDoubleOptional = [value]
		object.arrayDoubleImplicityUnwrapped = [value]
		
		let JSON = Mapper().toJSONString(object, prettyPrint: true)
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			XCTAssertEqual(mappedObject.arrayDouble[0], value, "Double Array failed")
			XCTAssertEqual(mappedObject.arrayDoubleOptional![0], value, "Optional Double Array failed")
			XCTAssertEqual(mappedObject.arrayDoubleImplicityUnwrapped[0], value, "Implicity unwrapped optional Double Array failed")
		} else {
			XCTAssert(false, "Double Array to JSON failed")
		}
	}
	
	func testMappingFloatArrayToJSON(){
		var value: Float = 1.001
		var object = BasicTypes()
		object.arrayFloat = [value]
		object.arrayFloatOptional = [value]
		object.arrayFloatImplicityUnwrapped = [value]
		
		let JSON = Mapper().toJSONString(object, prettyPrint: true)
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			XCTAssertEqual(mappedObject.arrayFloat[0], value, "Float Array failed")
			XCTAssertEqual(mappedObject.arrayFloatOptional![0], value, "Optional Float Array failed")
			XCTAssertEqual(mappedObject.arrayFloatImplicityUnwrapped[0], value, "Implicity unwrapped optional Float Array failed")
		} else {
			XCTAssert(false, "Float Array to JSON failed")
		}
	}
	
	func testMappingStringArrayToJSON(){
		var value: String = "Stringgggg"
		var object = BasicTypes()
		object.arrayString = [value]
		object.arrayStringOptional = [value]
		object.arrayStringImplicityUnwrapped = [value]
		
		let JSON = Mapper().toJSONString(object, prettyPrint: true)
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			XCTAssertEqual(mappedObject.arrayString[0], value, "String Array failed")
			XCTAssertEqual(mappedObject.arrayStringOptional![0], value, "Optional String Array failed")
			XCTAssertEqual(mappedObject.arrayStringImplicityUnwrapped[0], value, "Implicity unwrapped optional String Array failed")
		} else {
			XCTAssert(false, "String Array to JSON failed")
		}
	}
	
	func testMappingAnyObjectArrayToJSON(){
		var value: String = "Stringgggg"
		var object = BasicTypes()
		object.arrayAnyObject = [value]
		object.arrayAnyObjectOptional = [value]
		object.arrayAnyObjectImplicitlyUnwrapped = [value]
		
		let JSON = Mapper().toJSONString(object, prettyPrint: true)
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			XCTAssertEqual(mappedObject.arrayAnyObject[0] as! String, value, "AnyObject Array failed")
			XCTAssertEqual(mappedObject.arrayAnyObjectOptional![0] as! String, value, "Optional AnyObject Array failed")
			XCTAssertEqual(mappedObject.arrayAnyObjectImplicitlyUnwrapped[0] as! String, value, "Implicity Unwrapped Optional AnyObject Array failed")
		} else {
			XCTAssert(false, "String Array to JSON failed")
		}
	}
	
	// MARK: Test mapping Dictionaries to JSON and back (with basic types in them Bool, Int, Double, Float, String)
	
	func testMappingBoolDictionaryToJSON(){
		var key = "key"
		var value: Bool = true
		var object = BasicTypes()
		object.dictBool = [key:value]
		object.dictBoolOptional = [key:value]
		object.dictBoolImplicityUnwrapped = [key:value]
		
		let JSON = Mapper().toJSONString(object, prettyPrint: true)
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			XCTAssertEqual(mappedObject.dictBool[key]!, value, "Bool Dictionary failed")
			XCTAssertEqual(mappedObject.dictBoolOptional![key]!, value, "Optional Bool Dictionary failed")
			XCTAssertEqual(mappedObject.dictBoolImplicityUnwrapped![key]!, value, "Implicity unwrapped optional Bool Dictionary failed")
		} else {
			XCTAssert(false, "Bool Dictionary to JSON failed")
		}
	}
	
	func testMappingIntDictionaryToJSON(){
		var key = "key"
		var value: Int = 11
		var object = BasicTypes()
		object.dictInt = [key:value]
		object.dictIntOptional = [key:value]
		object.dictIntImplicityUnwrapped = [key:value]
		
		let JSON = Mapper().toJSONString(object, prettyPrint: true)
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			XCTAssertEqual(mappedObject.dictInt[key]!, value, "Int Dictionary failed")
			XCTAssertEqual(mappedObject.dictIntOptional![key]!, value, "Optional Int Dictionary failed")
			XCTAssertEqual(mappedObject.dictIntImplicityUnwrapped[key]!, value, "Implicity unwrapped optional Int Dictionary failed")
		} else {
			XCTAssert(false, "Int Dictionary to JSON failed")
		}
	}
	
	func testMappingDoubleDictionaryToJSON(){
		var key = "key"
		var value: Double = 11
		var object = BasicTypes()
		object.dictDouble = [key:value]
		object.dictDoubleOptional = [key:value]
		object.dictDoubleImplicityUnwrapped = [key:value]
		
		let JSON = Mapper().toJSONString(object, prettyPrint: true)
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			XCTAssertEqual(mappedObject.dictDouble[key]!, value, "Double Dictionary failed")
			XCTAssertEqual(mappedObject.dictDoubleOptional![key]!, value, "Optional Double Dictionary failed")
			XCTAssertEqual(mappedObject.dictDoubleImplicityUnwrapped[key]!, value, "Implicity unwrapped optional Double Dictionary failed")
		} else {
			XCTAssert(false, "Double Dictionary to JSON failed")
		}
	}
	
	func testMappingFloatDictionaryToJSON(){
		var key = "key"
		var value: Float = 11
		var object = BasicTypes()
		object.dictFloat = [key:value]
		object.dictFloatOptional = [key:value]
		object.dictFloatImplicityUnwrapped = [key:value]
		
		let JSON = Mapper().toJSONString(object, prettyPrint: true)
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			XCTAssertEqual(mappedObject.dictFloat[key]!, value, "Float Dictionary failed")
			XCTAssertEqual(mappedObject.dictFloatOptional![key]!, value, "Optional Float Dictionary failed")
			XCTAssertEqual(mappedObject.dictFloatImplicityUnwrapped[key]!, value, "Implicity unwrapped optional Float Dictionary failed")
		} else {
			XCTAssert(false, "Float Dictionary to JSON failed")
		}
	}
	
	func testMappingStringDictionaryToJSON(){
		var key = "key"
		var value = "value"
		var object = BasicTypes()
		object.dictString = [key:value]
		object.dictStringOptional = [key:value]
		object.dictStringImplicityUnwrapped = [key:value]
		
		let JSON = Mapper().toJSONString(object, prettyPrint: true)
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			XCTAssertEqual(mappedObject.dictString[key]!, value, "String Dictionary failed")
			XCTAssertEqual(mappedObject.dictStringOptional![key]!, value, "Optional String Dictionary failed")
			XCTAssertEqual(mappedObject.dictStringImplicityUnwrapped[key]!, value, "Implicity unwrapped optional String Dictionary failed")
		} else {
			XCTAssert(false, "String Dictionary to JSON failed")
		}
	}

	func testMappingAnyObjectDictionaryToJSON(){
		var key = "key"
		var value = "value"
		var object = BasicTypes()
		object.dictAnyObject = [key:value]
		object.dictAnyObjectOptional = [key:value]
		object.dictAnyObjectImplicitlyUnwrapped = [key:value]
		
		let JSON = Mapper().toJSONString(object, prettyPrint: true)
		var mappedObject = mapper.map(string: JSON)
		
		if let mappedObject = mappedObject {
			XCTAssertEqual(mappedObject.dictAnyObject[key]! as! String, value, "AnyObject Dictionary failed")
			XCTAssertEqual(mappedObject.dictAnyObjectOptional![key]! as! String, value, "Optional AnyObject Dictionary failed")
			XCTAssertEqual(mappedObject.dictAnyObjectImplicitlyUnwrapped[key]! as! String, value, "Implicity unwrapped optional AnyObject Dictionary failed")
		} else {
			XCTAssert(false, "String Dictionary to JSON failed")
		}
	}

	func testObjectToModelDictionnaryOfPrimitives() {
		var object = TestCollectionOfPrimitives()
		object.dictStringString = ["string": "string"]
		object.dictStringBool = ["string": false]
		object.dictStringInt = ["string": 1]
		object.dictStringDouble = ["string": 1.2]
		object.dictStringFloat = ["string": 1.3]
		
		let json = Mapper<TestCollectionOfPrimitives>().toJSON(object)
		
		XCTAssertTrue((json["dictStringString"] as! [String:String]).count == 1)
		XCTAssertTrue((json["dictStringBool"] as! [String:Bool]).count == 1)
		XCTAssertTrue((json["dictStringInt"] as! [String:Int]).count == 1)
		XCTAssertTrue((json["dictStringDouble"] as! [String:Double]).count == 1)
		XCTAssertTrue((json["dictStringFloat"] as! [String:Float]).count == 1)
		let dict:[String: String] = json["dictStringString"] as! [String:String]
		let value = dict["string"]! as String
		XCTAssertTrue(value == "string")
	}
}
