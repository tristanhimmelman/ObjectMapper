//
//  ClassClusterTests.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2015-09-18.
//  Copyright © 2015 hearst. All rights reserved.
//

import XCTest
import Nimble
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
			expect(vehicle).notTo(beNil())
			expect(vehicle as? Car).notTo(beNil())
			expect((vehicle as? Car)?.name).to(equal(carName))		}
    }
	
	func testClassClustersFromJSONString() {
		let carName = "Honda"
		let JSON = "{\"name\": \"\(carName)\", \"type\": \"car\"}"
		
		if let vehicle = Mapper<Vehicle>().map(JSON){
			expect(vehicle).notTo(beNil())
			expect(vehicle as? Car).notTo(beNil())
			expect((vehicle as? Car)?.name).to(equal(carName))		}
	}
	
	func testClassClusterArray() {
		let carName = "Honda"
		let JSON = [["name": carName, "type": "car"], ["type": "bus"], ["type": "vehicle"]]
		
		if let vehicles = Mapper<Vehicle>().mapArray(JSON){
			expect(vehicles).notTo(beNil())
			expect(vehicles.count).to(equal(3))
			expect(vehicles[0] as? Car).notTo(beNil())
			expect(vehicles[1] as? Bus).notTo(beNil())
			expect(vehicles[2]).notTo(beNil())
			expect((vehicles[0] as? Car)?.name).to(equal(carName))
		}
	}
}

class Vehicle: MappableCluster {
	
	var type: String?
	
	required init?(_ map: Map){

	}
	
	static func newInstance(map: Map) -> Mappable? {
		if let type = map["type"].currentValue as? String {
			if type == "car" {
				return Car(map)
			} else if type == "bus" {
				return Bus(map)
			}
		}
		return nil
	}
	
	func mapping(map: Map) {
		type <- map["type"]
		print("mapping vehicle")
	}
}

class Car: Vehicle {
	
	var name: String?
	
	required init?(_ map: Map){
		super.init(map)
	}
	
	override func mapping(map: Map) {
		super.mapping(map)
		
		name <- map["name"]
		print("mapping car")
	}
}

class Bus: Vehicle {
	required init?(_ map: Map){
		super.init(map)
	}
	
	override func mapping(map: Map) {
		super.mapping(map)
		print("mapping bus")
	}
}
