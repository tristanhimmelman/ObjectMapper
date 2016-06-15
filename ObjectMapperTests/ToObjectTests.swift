//
//  ReferenceTypesFromJSON.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2015-11-29.
//  Copyright © 2015 hearst. All rights reserved.
//

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
		
		let mappedObject = Mapper<Person>().map(JSONString)
		
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
		
		let mappedObject = Mapper<Person>().map(initialJSONString)
		let initialSpouse = mappedObject?.spouse
		
		XCTAssertNotNil(mappedObject)
		
		let updatedObject = Mapper<Person>().map(updatedJSONString, toObject: mappedObject!)
		
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
		
		let mappedObject = Mapper<Person>().map(initialJSONString)
		let initialChild = mappedObject?.children?[childKey]
		
		XCTAssertNotNil(mappedObject)
		XCTAssertNotNil(initialChild)
		XCTAssertEqual(initialChild?.name, initialChildName)
		
		_ = Mapper<Person>().map(updatedJSONString, toObject: mappedObject!)
		
		let updatedChild = mappedObject?.children?[childKey]
		XCTAssert(initialChild === updatedChild, "Expected mapping to update the existing object not create a new one")
		XCTAssertEqual(updatedChild?.name, updatedChildName)
		XCTAssertEqual(initialChild?.name, updatedChildName)
	}
	
	class Person: Mappable {
		var name: String?
		var spouse: Person?
		var children: [String : Person]?
		
		required init?(_ map: Map) {
			
		}
		
		func mapping(_ map: Map) {
			name		<- map["name"]
			spouse		<- map["spouse"]
			children	<- map["children"]
		}
	}
}
