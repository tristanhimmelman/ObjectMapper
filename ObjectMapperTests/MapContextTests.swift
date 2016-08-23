//
//  MapContextTests.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2016-05-10.
//  Copyright © 2016 hearst. All rights reserved.
//

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
		let JSON = ["name":"Tristan"]
		let context = Context(shouldMap: true)
		
		let person = Mapper<Person>(context: context).map(JSON)
		
		XCTAssertNotNil(person)
		XCTAssertNotNil(person?.name)
    }
	
	func testMappingWithoutContext() {
		let JSON = ["name" : "Tristan"]
		
		let person = Mapper<Person>().map(JSON)
		
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
		
		required init?(_ map: Map){
			
		}
		
		func mapping(_ map: Map) {
			if (map.context as? Context)?.shouldMap == true {
				name <- map["name"]
			}
		}
	}
}
