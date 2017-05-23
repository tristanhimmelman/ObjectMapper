//
//  ClassClusterTests.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2015-09-18.
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

class ClassClusterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
	
    func testClassClusters() {
		let carName = "Honda"
		let JSON = ["name": carName, "type": "car"]
		
		if let vehicle = Mapper<Vehicle>().map(JSON: JSON){
			XCTAssertNotNil(vehicle)
			XCTAssertNotNil(vehicle as? Car)
			XCTAssertEqual((vehicle as? Car)?.name, carName)
		}
    }
	
	func testClassClustersFromJSONString() {
		let carName = "Honda"
		let JSON = "{\"name\": \"\(carName)\", \"type\": \"car\"}"
		
		if let vehicle = Mapper<Vehicle>().map(JSONString: JSON){
			XCTAssertNotNil(vehicle)
			XCTAssertNotNil(vehicle as? Car)
			XCTAssertEqual((vehicle as? Car)?.name, carName)
		}
	}
	
	func testClassClusterArray() {
		let carName = "Honda"
		let JSON = [["name": carName, "type": "car"], ["type": "bus"], ["type": "vehicle"]]
		
		let vehicles = Mapper<Vehicle>().mapArray(JSONArray: JSON)
		XCTAssertNotNil(vehicles)
		XCTAssertTrue(vehicles.count == 3)
		XCTAssertNotNil(vehicles[0] as? Car)
		XCTAssertNotNil(vehicles[1] as? Bus)
		XCTAssertNotNil(vehicles[2])
		XCTAssertEqual((vehicles[0] as? Car)?.name, carName)
	}
}

class Vehicle: StaticMappable {
	
	var type: String?
	
	class func objectForMapping(map: Map) -> BaseMappable? {
		if let type: String = map["type"].value() {
			switch type {
				case "car":
					return Car()
				case "bus":
					return Bus()
				default:
					return Vehicle()
			}
		}
		return nil
	}

	init(){
		
	}
	
	func mapping(map: Map) {
		type <- map["type"]
	}
}

class Car: Vehicle {
	
	var name: String?
	
	override class func objectForMapping(map: Map) -> BaseMappable? {
		return nil
	}
	
	override func mapping(map: Map) {
		super.mapping(map: map)
		
		name <- map["name"]
	}
}

class Bus: Vehicle {

	override func mapping(map: Map) {
		super.mapping(map: map)
	}
}
