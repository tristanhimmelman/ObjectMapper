//
//  DictionaryTransformTests.swift
//  ObjectMapper
//
//  Created by Milen Halachev on 7/20/16.
//  Copyright © 2016 hearst. All rights reserved.
//

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

