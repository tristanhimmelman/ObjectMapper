//
//  DictionaryTransformTests.swift
//  ObjectMapper
//
//  Created by Milen Halachev on 7/20/16.
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

class DictionaryTransformTests: XCTestCase {
	
	func testDictionaryTransform() {
		
		let JSON = "{\"dictionary\":{\"1\":{\"foo\":\"uno\",\"bar\":1},\"two\":{\"foo\":\"dve\",\"bar\":2},\"bar\":{\"foo\":\"bar\",\"bar\":777}}}"
		
		guard let result = DictionaryTransformTestsObject(JSONString: JSON) else {
			
			XCTFail("Unable to parse the JSON")
			return
		}
		
		XCTAssertEqual(result.dictionary.count, 3)
		
		XCTAssertEqual(result.dictionary[.One]?.foo, "uno")
		XCTAssertEqual(result.dictionary[.One]?.bar, 1)
		
		XCTAssertEqual(result.dictionary[.Two]?.foo, "dve")
		XCTAssertEqual(result.dictionary[.Two]?.bar, 2)
		
		XCTAssertEqual(result.dictionary[.Foo]?.foo, "bar")
		XCTAssertEqual(result.dictionary[.Foo]?.bar, 777)
	}
}

class DictionaryTransformTestsObject: Mappable {
	
	var dictionary: [MyKey: MyValue] = [:]
	
	required init?(map: Map) {

		
	}
	
	func mapping(map: Map) {
		
		self.dictionary <- (map["dictionary"], DictionaryTransform<MyKey, MyValue>())
	}
}

extension DictionaryTransformTestsObject {
	
	enum MyKey: String {
		
		case One = "1"
		case Two = "two"
		case Foo = "bar"
	}
}

extension DictionaryTransformTestsObject {
	
	class MyValue: Mappable {
		
		var foo: String
		var bar: Int
		
		required init?(map: Map) {
			
			self.foo = "__foo"
			self.bar = self.foo.hash
			
			self.mapping(map: map)
			
			guard self.foo != "__foo" && self.bar != self.foo.hash else {
				
				return nil
			}
		}
		
		func mapping(map: Map) {
			
			self.foo <- map["foo"]
			self.bar <- map["bar"]
		}
	}
}

