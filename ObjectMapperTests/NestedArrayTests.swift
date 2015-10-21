//
//  NestedArrayTests.swift
//  ObjectMapper
//
//  Created by Ruben Samsonyan on 10/21/15.
//  Copyright © 2015 hearst. All rights reserved.
//

import Foundation
import XCTest
import ObjectMapper
import Nimble

class NestedArrayTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
	
	func testNestedArray() {
		let JSON: [String: AnyObject] = [ "nested": [ ["value": 123], ["value": 456] ] ]
		
		let mapper = Mapper<NestedArray>()
		
		let value: NestedArray! = mapper.map(JSON)
		expect(value).notTo(beNil())
		
		let JSONFromValue = mapper.toJSON(value)
		let valueFromParsedJSON: NestedArray! = mapper.map(JSONFromValue)
		expect(valueFromParsedJSON).notTo(beNil())
		
		expect(value.value_0).to(equal(valueFromParsedJSON.value_0))
		expect(value.value_1).to(equal(valueFromParsedJSON.value_1))
		
	}

}

class NestedArray: Mappable {
	
	var value_0: Int?
	var value_1: Int?
	
	required init?(_ map: Map){
		
	}
	
	func mapping(map: Map) {
		
		value_0	<- map["nested.0.value"]
		value_1	<- map["nested.1.value"]
		
	}
}