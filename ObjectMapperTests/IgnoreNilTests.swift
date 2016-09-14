//
//  IgnoreNilTests.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2016-06-06.
//  Copyright © 2016 hearst. All rights reserved.
//

import XCTest
import ObjectMapper

class IgnoreNilTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
	
	func testIgnoreNullField(){
		let name = "Tristan"
		var user = User()
		user.name = name
		
		let JSON = "{\"name\" : null}"
		user = Mapper<User>().map(JSONString: JSON, toObject: user)
		
		XCTAssertEqual(user.name, name)
	}
	
	func testIgnoreNilField(){
		let name = "Tristan"
		var user = User()
		user.name = name
		
		let JSON = "{\"name\" : nil}"
		user = Mapper<User>().map(JSONString: JSON, toObject: user)
		
		XCTAssertEqual(user.name, name)
	}

	private class User: Mappable {
		var name: String?
		
		init(){}
		
		required init?(map: Map){
			
		}
		
		func mapping(map: Map){
			name <- map["name", ignoreNil: true]
		}
	}
}
