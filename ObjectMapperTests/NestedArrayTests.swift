//
//  NestedArrayTests.swift
//  ObjectMapper
//
//  Created by Li Jiantang on 23/10/2015.
//  Copyright © 2015 hearst. All rights reserved.
//

import XCTest
import ObjectMapper
import Nimble


class NestedArrayTests: XCTestCase {
	
	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
		
		MapRequiredField.assume = { (condition: Bool, message: String) in
			XCTAssert(condition, message)
		}
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	func testArrayDoubleWayMapping() {
		
		class Employments: MappableModel {
			
			var currentEmployerName: String?
			var currentJobTitle: String?
			var previousEmplyerName: String?
			var previousJobTitle: String?
			var age: Int?
			
			override func mapping(map: Map) {
				
				switch map.mappingType {
				case .FromJSON:
					currentEmployerName <- map["employments.0.employer.name"]
					currentJobTitle <- map["employments.0.position"]
					previousEmplyerName <- map["employments.1.employer.name"]
					previousJobTitle <- map["employments.1.position"]
					age <- map["age", required: true]
				case .ToJSON:
					// server only cares current employments
					currentEmployerName <- map["currentEmployments.0.employer.name"]
					currentJobTitle <- map["currentEmployments.0.position"]
					
					// this is a required field
					age <- map["age"]
				}
			}
		}
		
		let jsonArray: [String: AnyObject] = [
			"employments" : [
				[
					"position": "Developer",
					"employer": [
						"name": "Carma"
					]
				],
				[
					"position": "Forkman",
					"employer": [
						"name": "Linkedin"
					]
				]
			],
			"age": 30 // comment out this line to see the requirement assert error
		]
		
		let mapper = Mapper<Employments>()
		
		let employments: Employments! = mapper.map(jsonArray)
		
		expect(employments).notTo(beNil())
		expect(employments.currentEmployerName).to(equal("Carma"))
		expect(employments.currentJobTitle).to(equal("Developer"))
		expect(employments.previousEmplyerName).to(equal("Linkedin"))
		expect(employments.previousJobTitle).to(equal("Forkman"))
		
		let jsonMappedBack = mapper.toJSON(employments)
		let remappedEmployments: Employments! = mapper.map(jsonMappedBack)
		
		expect(remappedEmployments).notTo(beNil())
		
		let employmentsValue = getValue(forKey: "currentEmployments", fromCollection: jsonMappedBack)!
		
		// the value should be array
		expect(employmentsValue is [AnyObject]).to(beTruthy())
		
	}
	
	func testMultipleArrayMapping() {
		
		class MapValue: MappableModel {
			
			var intValue: String?
			
			override func mapping(map: Map) {
				intValue <- map["sequence.0.int.1"]
			}
		}
		
		let jsonArray = [
			"sequence": [
				[
					"int": ["1", "2", "3", "4"]
				]
			]
		]
		
		let mapper = Mapper<MapValue>()
		
		let map: MapValue! = mapper.map(jsonArray)
		
		expect(Int(map.intValue!)!).to(equal(2))
	}
	
	/// for now we don't support root array mapping 
	/// like this: let jsonArray = [["1", "2", "3", "4"], ["1", "2", "3", "4"]]
	func testNestedArrayMapping() {
		
		class MapValue: MappableModel {
			
			var intValue: String?
			
			override func mapping(map: Map) {
				intValue <- map["sequence.0.1"]
			}
		}
		
		let jsonArray = [
			"sequence": [
				["1", "2", "3", "4"]
			]
		]
		
		let mapper = Mapper<MapValue>()
		
		let map: MapValue! = mapper.map(jsonArray)
		
		expect(Int(map.intValue!)!).to(equal(2))
	}
	
	// get value from dictionary or array
	private func getValue(forKey key: String, fromCollection collection: AnyObject?) -> AnyObject? {
		
		if let dictionary = collection as? [String: AnyObject] {
			
			return dictionary[key]
		} else if let array = collection as? [AnyObject], index = Int(key) {
			
			if array.count > index {
				return array[index]
			}
		}
		
		return nil
	}
	
}

class MappableModel: Mappable {
	
	required init?(_ map: Map) {
		
	}
	
	func mapping(map: Map) {
		
	}
}
