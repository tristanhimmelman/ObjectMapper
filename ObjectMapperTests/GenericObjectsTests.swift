//
//  GenericObjectsTests.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2016-09-26.
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

import XCTest
import ObjectMapper

class GenericObjectsTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

	func testSubclass() {
		let object = Subclass()
		object.base = "base var"
		object.sub = "sub var"
		
		let json = Mapper().toJSON(object)
		let parsedObject = Mapper<Subclass>().map(JSON: json)
		
		XCTAssertEqual(object.base, parsedObject?.base)
		XCTAssertEqual(object.sub, parsedObject?.sub)
	}
	
	func testGenericSubclass() {
		let object = GenericSubclass<String>()
		object.base = "base var"
		object.sub = "sub var"
		
		let json = Mapper().toJSON(object)
		let parsedObject = Mapper<GenericSubclass<String>>().map(JSON: json)
		
		XCTAssertEqual(object.base, parsedObject?.base)
		XCTAssertEqual(object.sub, parsedObject?.sub)
	}
	
	func testSubclassWithGenericArrayInSuperclass() {
		let JSONString = "{\"genericItems\":[{\"value\":\"value0\"}, {\"value\":\"value1\"}]}"
		
		let parsedObject = Mapper<SubclassWithGenericArrayInSuperclass<AnyObject>>().map(JSONString: JSONString)
		
		let genericItems = parsedObject?.genericItems
		
		XCTAssertNotNil(genericItems)
		XCTAssertEqual(genericItems?[0].value, "value0")
		XCTAssertEqual(genericItems?[1].value, "value1")
	}
	
	
	func testMappingAGenericObject(){
		let code: Int = 22
		let JSONString = "{\"result\":{\"code\":\(code)}}"
		
		let response = Mapper<Response<Status>>().map(JSONString: JSONString)
		
		let status = response?.result?.status
		
		XCTAssertNotNil(status)
		XCTAssertEqual(status, code)
	}
	
	
	func testMappingAGenericObjectViaMappableExtension(){
		let code: Int = 22
		let JSONString = "{\"result\":{\"code\":\(code)}}"
		
		let response = Response<Status>(JSONString: JSONString)
		
		let status = response?.result?.status
		
		XCTAssertNotNil(status)
		XCTAssertEqual(status, code)
	}
	
}

class Base: Mappable {
	
	var base: String?
	
	init(){
		
	}
	
	required init?(map: Map){
		
	}
	
	func mapping(map: Map) {
		base <- map["base"]
	}
}

class Subclass: Base {
	
	var sub: String?
	
	override init(){
		super.init()
	}
	
	required init?(map: Map){
		super.init(map: map)
	}
	
	override func mapping(map: Map) {
		super.mapping(map: map)
		
		sub <- map["sub"]
	}
}


class GenericSubclass<T>: Base {
	
	var sub: String?
	
	override init(){
		super.init()
	}
	
	required init?(map: Map){
		super.init(map: map)
	}
	
	override func mapping(map: Map) {
		super.mapping(map: map)
		
		sub <- map["sub"]
	}
}

class WithGenericArray<T: Mappable>: Mappable {
	var genericItems: [T]?
	
	required init?(map: Map){
		
	}
	
	func mapping(map: Map) {
		genericItems <- map["genericItems"]
	}
}

class ConcreteItem: Mappable {
	var value: String?
	
	required init?(map: Map){
		
	}
	
	func mapping(map: Map) {
		value <- map["value"]
	}
}

class SubclassWithGenericArrayInSuperclass<Unused>: WithGenericArray<ConcreteItem> {
	required init?(map: Map){
		super.init(map: map)
	}
}

class Response<T: Mappable>: Mappable {
	var result: T?
	
	required init?(map: Map){
		
	}
	
	func mapping(map: Map) {
		result <- map["result"]
	}
}
