//
//  ReferenceTypesFromJSON.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2015-11-29.
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

class ToObjectTests: XCTestCase {
	
	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	func testMappingPersonFromJSON(){
		let name = "ASDF"
		let spouseName = "HJKL"
		let JSONString = "{\"name\" : \"\(name)\", \"spouse\" : {\"name\" : \"\(spouseName)\"}}"
		
		let mappedObject = Mapper<Person>().map(JSONString: JSONString)
		
		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.name, name)
		XCTAssertEqual(mappedObject?.spouse?.name, spouseName)
	}
	
	func testUpdatingChildObject(){
		let name = "ASDF"
		let initialSpouseName = "HJKL"
		let updatedSpouseName = "QWERTY"
		let initialJSONString = "{\"name\" : \"\(name)\", \"spouse\" : {\"name\" : \"\(initialSpouseName)\"}}"
		let updatedJSONString = "{\"name\" : \"\(name)\", \"spouse\" : {\"name\" : \"\(updatedSpouseName)\"}}"
		
		let mappedObject = Mapper<Person>().map(JSONString: initialJSONString)
		let initialSpouse = mappedObject?.spouse
		
		XCTAssertNotNil(mappedObject)
		
		let updatedObject = Mapper<Person>().map(JSONString: updatedJSONString, toObject: mappedObject!)
		
		XCTAssert(initialSpouse === updatedObject.spouse, "Expected mapping to update the existing object not create a new one")
		XCTAssertEqual(updatedObject.spouse?.name, updatedSpouseName)
		XCTAssertEqual(initialSpouse?.name,	updatedSpouseName)
	}
	
	func testUpdatingChildDictionary(){
		let childKey = "child_1"
		let initialChildName = "HJKL"
		let updatedChildName = "QWERTY"
		let initialJSONString = "{\"children\" : {\"\(childKey)\" : {\"name\" : \"\(initialChildName)\"}}}"
		let updatedJSONString = "{\"children\" : {\"\(childKey)\" : {\"name\" : \"\(updatedChildName)\"}}}"
		
		let mappedObject = Mapper<Person>().map(JSONString: initialJSONString)
		let initialChild = mappedObject?.children?[childKey]
		
		XCTAssertNotNil(mappedObject)
		XCTAssertNotNil(initialChild)
		XCTAssertEqual(initialChild?.name, initialChildName)
		
		_ = Mapper<Person>().map(JSONString: updatedJSONString, toObject: mappedObject!)
		
		let updatedChild = mappedObject?.children?[childKey]
		XCTAssert(initialChild === updatedChild, "Expected mapping to update the existing object not create a new one")
		XCTAssertEqual(updatedChild?.name, updatedChildName)
		XCTAssertEqual(initialChild?.name, updatedChildName)
	}
	
	func testToObjectFromString() {
		let username = "bob"
		let JSONString = "{\"username\":\"\(username)\"}"
		
		let user = User()
		user.username = "Tristan"
		
		_ = Mapper().map(JSONString: JSONString, toObject: user)
		
		XCTAssertEqual(user.username, username)
	}
	
	func testToObjectFromJSON() {
		let username = "bob"
		let JSON = ["username": username]
		
		let user = User()
		user.username = "Tristan"
		
		_ = Mapper().map(JSON: JSON, toObject: user)
		
		XCTAssertEqual(username, user.username)
	}
	
	func testToObjectFromAny() {
		let username = "bob"
		let userJSON = ["username": username]
		
		let user = User()
		user.username = "Tristan"
		
		_ = Mapper().map(JSONObject: userJSON as Any, toObject: user)
		
		XCTAssertEqual(user.username, username)
	}

	class Person: Mappable {
		var name: String?
		var spouse: Person?
		var children: [String: Person]?
		
		required init?(map: Map) {
			
		}
		
		func mapping(map: Map) {
			name		<- map["name"]
			spouse		<- map["spouse"]
			children	<- map["children"]
		}
	}
	
	class User: Mappable {
		
		var username: String = ""
		
		init(){
			
		}
		
		required init?(map: Map){
			
		}
		
		func mapping(map: Map) {
			username	<- map["username"]
		}
	}
}

