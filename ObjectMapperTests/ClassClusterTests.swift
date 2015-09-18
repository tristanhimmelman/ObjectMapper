//
//  ClassClusterTests.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2015-09-18.
//  Copyright © 2015 hearst. All rights reserved.
//

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
		let JSON = ["name": "Honda", "type": "car"]
		
		if let vehicle = Mapper<Vehicle>().map(JSON){
			print(vehicle)
			print((vehicle as! Car).name)
		}
    }
	
	func testClassClusterArray() {
		let JSON = [["name": "Honda", "type": "car"], ["type": "bus"]]
		
		if let vehicle = Mapper<Vehicle>().mapArray(JSON){
			print(vehicle)
		}
	}
}

class Vehicle: MappableCluster {
	
	var type: String?
	
	required init?(_ map: Map){

	}
	
	func newInstance(map: Map) -> Mappable? {
		if let type = map["type"].currentValue as? String {
			if type == "car" {
				return Car(map)
			} else {
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
