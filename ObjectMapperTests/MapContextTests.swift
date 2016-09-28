//
//  MapContextTests.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2016-05-10.
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

class MapContextTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMappingWithContext() {
		let JSON = ["name": "Tristan"]
		let context = Context(shouldMap: true)
		
		let person = Mapper<Person>(context: context).map(JSON: JSON)
		
		XCTAssertNotNil(person)
		XCTAssertNotNil(person?.name)
    }
	
	func testMappingWithContextViaMappableExtension() {
		let JSON = ["name": "Tristan"]
		let context = Context(shouldMap: true)
		
		let person = Person(JSON: JSON, context: context)
		
		XCTAssertNotNil(person)
		XCTAssertNotNil(person?.name)
	}
	
	func testMappingWithoutContext() {
		let JSON = ["name": "Tristan"]
		
		let person = Mapper<Person>().map(JSON: JSON)
		
		XCTAssertNotNil(person)
		XCTAssertNil(person?.name)
	}
	
	struct Context: MapContext {
		var shouldMap = false
		
		init(shouldMap: Bool){
			self.shouldMap = shouldMap
		}
	}
	
	class Person: Mappable {
		var name: String?
		
		required init?(map: Map){
			
		}
		
		func mapping(map: Map) {
			if (map.context as? Context)?.shouldMap == true {
				name <- map["name"]
			}
		}
	}
}
