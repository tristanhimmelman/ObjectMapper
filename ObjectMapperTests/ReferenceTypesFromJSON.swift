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

class ReferenceTypesTestsFromJSON: XCTestCase {
	
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
	
	func testUpdatingPersonFromJSON(){
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
}

class Person: Mappable {
	var name: String?
	var spouse: Person?
	
	required init?(_ map: Map) {
		
	}
	
	func mapping(map: Map) {
		name	<- map["name"]
		spouse	<- map["spouse"]
	}
}