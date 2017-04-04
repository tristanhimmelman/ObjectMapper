//
//  MapKeyConvertibleTests.swift
//  ObjectMapper
//
//  Created by Mark Woollard on 04/04/2017.
//  Copyright © 2017 hearst. All rights reserved.
//

import Foundation
import XCTest
import ObjectMapper

class MapKeyConvertibleTests: XCTestCase {
	
	let JSON: [String: Any] = [
		"prop1": "MapKeyConvertible",
		"prop2": 255,
		"prop3": true,
	]
	
	enum Keys: String, MapKeyConvertible {
		case prop1
		case prop2
		case prop3
	}
	
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test() {
		let map = Map(mappingType: .fromJSON, JSON: JSON)
		
		let prop1: String = try! map.value(Keys.prop1)
		let prop2: Int = try! map.value(Keys.prop2)
		let prop3: Bool = try! map.value(Keys.prop3)
		
		XCTAssertEqual(prop1, "MapKeyConvertible")
		XCTAssertEqual(prop2, 255)
		XCTAssertEqual(prop3, true)
    }
	
}
