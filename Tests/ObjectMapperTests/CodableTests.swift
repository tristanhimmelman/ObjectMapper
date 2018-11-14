//
//  CodableTests.swift
//  ObjectMapper
//
//  Created by Jari Kalinainen on 11.10.18.
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

class CodableTests: XCTestCase {
	
	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	func testCodableTransform() {
		let JSON: [String: Any] = [ "value": [ "one": "1", "two": 2, "three": true ]]
		
		let mapper = Mapper<ImmutableMappableObject>()
		
		let object: ImmutableMappableObject! = mapper.map(JSON: JSON)
		XCTAssertNotNil(object)
		XCTAssertNil(object.nilValue) // without transform this is nil
		XCTAssertNotNil(object.value)
		XCTAssertNotNil(object.value?.one)
		XCTAssertNotNil(object.value?.two)
		XCTAssertNotNil(object.value?.three)
	}
	
}

class ImmutableMappableObject: ImmutableMappable {
	
	var value: CodableModel?
	var nilValue: CodableModel?
	
	required init(map: Map) throws {
		nilValue = try? map.value("value")
		value = try? map.value("value", using: CodableTransform<CodableModel>())
	}

	func mapping(map: Map) {
		nilValue <- map["value"]
		value	<- (map["value"], using: CodableTransform<CodableModel>())
	}
}

struct CodableModel: Codable {
	let one: String
	let two: Int
	let three: Bool
}
