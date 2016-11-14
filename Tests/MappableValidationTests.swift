//
//  MappableValidationTests.swift
//  ObjectMapper
//
//  Created by Milen Halachev on 11/14/16.
//  Copyright © 2016 hearst. All rights reserved.
//

import Foundation
import XCTest
import ObjectMapper

class MappableValidationTests: XCTestCase {
	
	func testInvalidMappableValidation() {
		
		let JSON = "{\"numericString\":777}"
		let sample = Mapper<Sample>().map(JSONString: JSON)
		XCTAssertNil(sample)
	}
	
	func testValidMappableValidation() {
		
		let JSON = "{\"numericString\":\"777\"}"
		let sample = Mapper<Sample>().map(JSONString: JSON)
		XCTAssertNotNil(sample)
	}
}

class Sample: Mappable {
	
	//
	var numericString: String
	
	required init?(map: Map) {
		
		self.numericString = "default invalid value"
	}
	
	func mapping(map: Map) {
	
		self.numericString <- map["numericString"]
	}
	
	func validateMapping(map: Map) -> Bool {
		
		guard
		//it should not contain the default invalid value
		self.numericString != "default invalid value",
			
		//it sohuld contain only numeric characters
		self.numericString.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
		else {
			
			return false
		}
		
		return true
	}
}
