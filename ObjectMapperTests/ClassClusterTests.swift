//
//  ClassClusterTests.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2015-09-18.
//  Copyright © 2015 hearst. All rights reserved.
//

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
		
		if let vehicle = Mapper<Vehicle>().map(JSON){
			XCTAssertNotNil(vehicle)
			XCTAssertNotNil(vehicle as? Car)
			XCTAssertEqual((vehicle as? Car)?.name, carName)
		}
    }
	
	func testClassClustersFromJSONString() {
		let carName = "Honda"
		let JSON = "{\"name\": \"\(carName)\", \"type\": \"car\"}"
		
		if let vehicle = Mapper<Vehicle>().map(JSON){
			XCTAssertNotNil(vehicle)
			XCTAssertNotNil(vehicle as? Car)
			XCTAssertEqual((vehicle as? Car)?.name, carName)
		}
	}
	
	func testClassClusterArray() {
		let carName = "Honda"
		let JSON = [["name": carName, "type": "car"], ["type": "bus"], ["type": "vehicle"]]
		
		if let vehicles = Mapper<Vehicle>().mapArray(JSON){
			XCTAssertNotNil(vehicles)
			XCTAssertTrue(vehicles.count == 3)
			XCTAssertNotNil(vehicles[0] as? Car)
			XCTAssertNotNil(vehicles[1] as? Bus)
			XCTAssertNotNil(vehicles[2])
			XCTAssertEqual((vehicles[0] as? Car)?.name, carName)
		}
	}
}

class Vehicle: StaticMappable {
	
	var type: String?
	
	class func objectForMapping(map: Map) -> Mappable? {
		if let type: String = map["type"].value() {
			switch type {
				case "car":
					return Car(map)
				case "bus":
					return Bus(map)
				default:
					return nil
			}
		}
		return nil
	}

	required init?(_ map: Map){
		
	}
	
	func mapping(map: Map) {
		type <- map["type"]
	}
}

class Car: Vehicle {
	
	var name: String?
	
	override class func objectForMapping(map: Map) -> Mappable? {
		return nil
	}
	
	override func mapping(map: Map) {
		super.mapping(map)
		
		name <- map["name"]
	}
}

class Bus: Vehicle {

	override func mapping(map: Map) {
		super.mapping(map)
	}
}
