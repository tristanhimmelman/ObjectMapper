//
//  ImmutableObjectTests.swift
//  ObjectMapper
//
//  Created by Loïs Di Qual on 2/8/16.
//  Copyright © 2016 hearst. All rights reserved.
//

import Foundation
import XCTest
import ObjectMapper

class ImmutableObjectTests: XCTestCase {
	func testImmutableMappable() {
		let mapper = Mapper<Immutable>()
		let JSON = [
			
			// Basic types
			"prop1": "Immutable!",
			"prop2": 255,
			"prop3": true,
			// prop4 has a default value
			
			// String
			"prop5": "prop5",
			"prop6": "prop6",
			"prop7": "prop7",
			
			// [String]
			"prop8": ["prop8"],
			"prop9": ["prop9"],
			"prop10": ["prop10"],
			
			// [String: String]
			"prop11": ["key": "prop11"],
			"prop12": ["key": "prop12"],
			"prop13": ["key": "prop13"],
			
			// Base
			"prop14": ["base": "prop14"],
			"prop15": ["base": "prop15"],
			"prop16": ["base": "prop16"],
			
			// [Base]
			"prop17": [["base": "prop17"]],
			"prop18": [["base": "prop18"]],
			"prop19": [["base": "prop19"]],
			
			// [String: Base]
			"prop20": ["key": ["base": "prop20"]],
			"prop21": ["key": ["base": "prop21"]],
			"prop22": ["key": ["base": "prop22"]],
		]
		
		let immutable: Immutable! = mapper.map(JSON)
		XCTAssertNotNil(immutable)
		XCTAssertEqual(immutable.prop1, "Immutable!")
		XCTAssertEqual(immutable.prop2, 255)
		XCTAssertEqual(immutable.prop3, true)
		XCTAssertEqual(immutable.prop4, DBL_MAX)
		
		XCTAssertEqual(immutable.prop5, "prop5_TRANSFORMED")
		XCTAssertEqual(immutable.prop6, "prop6_TRANSFORMED")
		XCTAssertEqual(immutable.prop7, "prop7_TRANSFORMED")
		
		XCTAssertEqual(immutable.prop8, ["prop8_TRANSFORMED"])
		XCTAssertEqual(immutable.prop9!, ["prop9_TRANSFORMED"])
		XCTAssertEqual(immutable.prop10, ["prop10_TRANSFORMED"])
		
		XCTAssertEqual(immutable.prop11, ["key": "prop11_TRANSFORMED"])
		XCTAssertEqual(immutable.prop12!, ["key": "prop12_TRANSFORMED"])
		XCTAssertEqual(immutable.prop13, ["key": "prop13_TRANSFORMED"])
		
		XCTAssertEqual(immutable.prop14.base, "prop14")
		XCTAssertEqual(immutable.prop15?.base, "prop15")
		XCTAssertEqual(immutable.prop16.base, "prop16")
		
		XCTAssertEqual(immutable.prop17[0].base, "prop17")
		XCTAssertEqual(immutable.prop18![0].base, "prop18")
		XCTAssertEqual(immutable.prop19[0].base, "prop19")
		
		XCTAssertEqual(immutable.prop20["key"]!.base, "prop20")
		XCTAssertEqual(immutable.prop21!["key"]!.base, "prop21")
		XCTAssertEqual(immutable.prop22["key"]!.base, "prop22")
		
		let JSON2 = [ "prop1": "prop1", "prop2": NSNull() ]
		let immutable2 = mapper.map(JSON2)
		XCTAssertNil(immutable2)
		
		let JSONFromObject = mapper.toJSON(immutable)
		let objectFromJSON = mapper.map(JSONFromObject)
		XCTAssertNotNil(objectFromJSON)
		assertImmutableObjectsEqual(objectFromJSON!, immutable)
	}
}

struct Immutable {
	let prop1: String
	let prop2: Int
	let prop3: Bool
	let prop4: Double
	
	let prop5: String
	let prop6: String?
	let prop7: String!
	
	let prop8: [String]
	let prop9: [String]?
	let prop10: [String]!
	
	let prop11: [String: String]
	let prop12: [String: String]?
	let prop13: [String: String]!
	
	let prop14: Base
	let prop15: Base?
	let prop16: Base!
	
	let prop17: [Base]
	let prop18: [Base]?
	let prop19: [Base]!
	
	let prop20: [String: Base]
	let prop21: [String: Base]?
	let prop22: [String: Base]!
}

extension Immutable: Mappable {
	init(_ map: Map) throws {
		prop1 = try map["prop1"].valueOrFail()
		prop2 = try map["prop2"].valueOrFail()
		prop3 = try map["prop3"].valueOrFail()
		prop4 = map["prop4"].valueOr(DBL_MAX)
		
		prop5 = try map["prop5"].valueOrFailWithTransform(stringTransform)
		prop6 = map["prop6"].valueWithTransform(stringTransform)
		prop7 = map["prop7"].valueWithTransform(stringTransform)
		
		prop8 = try map["prop8"].valueOrFailWithTransform(stringTransform)
		prop9 = map["prop9"].valueWithTransform(stringTransform)
		prop10 = map["prop10"].valueWithTransform(stringTransform)
		
		prop11 = try map["prop11"].valueOrFailWithTransform(stringTransform)
		prop12 = map["prop12"].valueWithTransform(stringTransform)
		prop13 = map["prop13"].valueWithTransform(stringTransform)
		
		prop14 = try map["prop14"].valueOrFail()
		prop15 = map["prop15"].value()
		prop16 = map["prop16"].value()
		
		prop17 = try map["prop17"].valueOrFail()
		prop18 = map["prop18"].value()
		prop19 = map["prop19"].value()
		
		prop20 = try map["prop20"].valueOrFail()
		prop21 = map["prop21"].value()
		prop22 = map["prop22"].value()
	}
	
	mutating func mapping(map: Map) {
		switch map.mappingType {
		case .FromJSON:
			if let x = try? Immutable(map) {
				self = x
			}
			
		case .ToJSON:
			var prop1 = self.prop1
			var prop2 = self.prop2
			var prop3 = self.prop3
			var prop4 = self.prop4
			var prop5 = self.prop5
			var prop6 = self.prop6
			var prop7 = self.prop7
			var prop8 = self.prop8
			var prop9 = self.prop9
			var prop10 = self.prop10
			var prop11 = self.prop11
			var prop12 = self.prop12
			var prop13 = self.prop13
			var prop14 = self.prop14
			var prop15 = self.prop15
			var prop16 = self.prop16
			var prop17 = self.prop17
			var prop18 = self.prop18
			var prop19 = self.prop19
			var prop20 = self.prop20
			var prop21 = self.prop21
			var prop22 = self.prop22
			
			prop1 <- map["prop1"]
			prop2 <- map["prop2"]
			prop3 <- map["prop3"]
			prop4 <- map["prop4"]
			
			prop5 <- (map["prop5"], stringTransform)
			prop6 <- (map["prop6"], stringTransform)
			prop7 <- (map["prop7"], stringTransform)
			prop8 <- (map["prop8"], stringTransform)
			prop9 <- (map["prop9"], stringTransform)
			prop10 <- (map["prop10"], stringTransform)
			prop11 <- (map["prop11"], stringTransform)
			prop12 <- (map["prop12"], stringTransform)
			prop13 <- (map["prop13"], stringTransform)
			
			prop14 <- map["prop14"]
			prop15 <- map["prop15"]
			prop16 <- map["prop16"]
			prop17 <- map["prop17"]
			prop18 <- map["prop18"]
			prop19 <- map["prop19"]
			prop20 <- map["prop20"]
			prop21 <- map["prop21"]
			prop22 <- map["prop22"]
		}
	}
}

// Very simple transform, so we avoid comparing array of dates/enums/somethingcomplex in our unit tests
let stringTransform = TransformOf<String, String>(fromJSON: { str -> String? in
	guard let str = str else {
		return nil
	}
	return "\(str)_TRANSFORMED"
}) { str -> String? in
	return str?.stringByReplacingOccurrencesOfString("_TRANSFORMED", withString: "", options: [], range: nil)
}

private func assertImmutableObjectsEqual(lhs: Immutable, _ rhs: Immutable) {
	XCTAssertEqual(lhs.prop1, rhs.prop1)
	XCTAssertEqual(lhs.prop2, rhs.prop2)
	XCTAssertEqual(lhs.prop3, rhs.prop3)
	XCTAssertEqual(lhs.prop4, rhs.prop4)
	XCTAssertEqual(lhs.prop5, rhs.prop5)
	XCTAssertEqual(lhs.prop6, rhs.prop6)
	XCTAssertEqual(lhs.prop7, rhs.prop7)
	XCTAssertEqual(lhs.prop8, rhs.prop8)
	
	// @hack: compare arrays and objects with their string representation.
	XCTAssertEqual("\(lhs.prop9)", "\(rhs.prop9)")
	XCTAssertEqual("\(lhs.prop10)", "\(rhs.prop10)")
	XCTAssertEqual("\(lhs.prop11)", "\(rhs.prop11)")
	XCTAssertEqual("\(lhs.prop12)", "\(rhs.prop12)")
	XCTAssertEqual("\(lhs.prop13)", "\(rhs.prop13)")
	XCTAssertEqual("\(lhs.prop14)", "\(rhs.prop14)")
	XCTAssertEqual("\(lhs.prop15)", "\(rhs.prop15)")
	XCTAssertEqual("\(lhs.prop16)", "\(rhs.prop16)")
	XCTAssertEqual("\(lhs.prop17)", "\(rhs.prop17)")
	XCTAssertEqual("\(lhs.prop18)", "\(rhs.prop18)")
	XCTAssertEqual("\(lhs.prop19)", "\(rhs.prop19)")
	XCTAssertEqual("\(lhs.prop20)", "\(rhs.prop20)")
	XCTAssertEqual("\(lhs.prop21)", "\(rhs.prop21)")
	XCTAssertEqual("\(lhs.prop22)", "\(rhs.prop22)")
}
