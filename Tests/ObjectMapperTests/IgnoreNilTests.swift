//
//  IgnoreNilTests.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2016-06-06.
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
		let firstName = "Tristan"
		let lastName = "Himmelman"
		var user = User()
		user.firstName = firstName
		user.lastName = lastName
		
		let JSON = "{\"first_name\" : null, \"last_name\" : null}"
		user = Mapper<User>(ignoreNil: true).map(JSONString: JSON, toObject: user)
		
		XCTAssertNil(user.firstName)
		XCTAssertEqual(user.lastName, lastName)
	}
	
	func testIgnoreNilField(){
		let firstName = "Tristan"
		let lastName = "Himmelman"
		var user = User()
		user.firstName = firstName
		user.lastName = lastName
		
		let JSON = "{\"first_name\" : nil, \"last_name\" : nil}"
		user = Mapper<User>(ignoreNil: true).map(JSONString: JSON, toObject: user)
		
		XCTAssertNil(user.firstName)
		XCTAssertEqual(user.lastName, lastName)	}

	private class User: Mappable {
		var firstName: String?
		var lastName: String?
		
		init(){}
		
		required init?(map: Map){
			
		}
		
		func mapping(map: Map){
			firstName <- map["first_name", ignoreNil: false]
			lastName <- map["last_name"]
		}
	}
}
