//
//  ImmutableTests.swift
//  ObjectMapper
//
//  Created by Suyeol Jeon on 23/09/2016.
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

class ImmutableObjectTests: XCTestCase {

	func testImmutableMappable() {
		let mapper = Mapper<Struct>()
		let JSON: [String: Any] = [
			
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
			
			// Optional with immutables
			"prop23": "Optional",
			"prop24": 255,
			"prop25": true,
			"prop26": 255.0,
		]
		
		let immutable: Struct = try! mapper.map(JSON: JSON)
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
		
		XCTAssertEqual(immutable.prop23!, "Optional")
		XCTAssertEqual(immutable.prop24!, 255)
		XCTAssertEqual(immutable.prop25!, true)
		XCTAssertEqual(immutable.prop26!, 255.0)
		
		let JSON2: [String: Any] = [ "prop1": "prop1", "prop2": NSNull() ]
		let immutable2 = try? mapper.map(JSON: JSON2)
		XCTAssertNil(immutable2)

		// TODO: ImmutableMappble to JSON
		let JSONFromObject = mapper.toJSON(immutable)
		let objectFromJSON = try? mapper.map(JSON: JSONFromObject)
		XCTAssertNotNil(objectFromJSON)
		assertImmutableObjectsEqual(objectFromJSON!, immutable)
	}

}

struct Struct {
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
	
	// Optionals
	var prop23: String?
	var prop24: Int?
	var prop25: Bool?
	var prop26: Double?
}

extension Struct: ImmutableMappable {
	init(map: Map) throws {
		prop1 = try map.value("prop1")
		prop2 = try map.value("prop2")
		prop3 = try map.value("prop3")
		prop4 = (try? map.value("prop4")) ?? DBL_MAX
		
		prop5 = try map.value("prop5", using: stringTransform)
		prop6 = try? map.value("prop6", using: stringTransform)
		prop7 = try? map.value("prop7", using: stringTransform)
		
		prop8 = try map.value("prop8", using: stringTransform)
		prop9 = try? map.value("prop9", using: stringTransform)
		prop10 = try? map.value("prop10", using: stringTransform)

		prop11 = try map.value("prop11", using: stringTransform)
		prop12 = try? map.value("prop12", using: stringTransform)
		prop13 = try? map.value("prop13", using: stringTransform)

		prop14 = try map.value("prop14")
		prop15 = try? map.value("prop15")
		prop16 = try? map.value("prop16")
		
		prop17 = try map.value("prop17")
		prop18 = try? map.value("prop18")
		prop19 = try? map.value("prop19")
		
		prop20 = try map.value("prop20")
		prop21 = try? map.value("prop21")
		prop22 = try? map.value("prop22")
	}

	mutating func mapping(map: Map) {
		prop23 <- map["prop23"]
		prop24 <- map["prop24"]
		prop25 <- map["prop25"]
		prop26 <- map["prop26"]
		
		prop1 >>> map["prop1"]
		prop2 >>> map["prop2"]
		prop3 >>> map["prop3"]
		prop4 >>> map["prop4"]
		
		prop5 >>> (map["prop5"], stringTransform)
		prop6 >>> (map["prop6"], stringTransform)
		prop7 >>> (map["prop7"], stringTransform)
		
		prop8 >>> (map["prop8"], stringTransform)
		prop9 >>> (map["prop9"], stringTransform)
		prop10 >>> (map["prop10"], stringTransform)

		prop11 >>> (map["prop11"], stringTransform)
		prop12 >>> (map["prop12"], stringTransform)
		prop13 >>> (map["prop13"], stringTransform)

		prop14 >>> map["prop14"]
		prop15 >>> map["prop15"]
		prop16 >>> map["prop16"]
		
		prop17 >>> map["prop17"]
		prop18 >>> map["prop18"]
		prop19 >>> map["prop19"]
		
		prop20 >>> map["prop20"]
		prop21 >>> map["prop21"]
		prop22 >>> map["prop22"]
	}
}

let stringTransform = TransformOf<String, String>(
	fromJSON: { (str: String?) -> String? in
		guard let str = str else {
			return nil
		}
		return "\(str)_TRANSFORMED"
	},
	toJSON: { (str: String?) -> String? in
		return str?.replacingOccurrences(of: "_TRANSFORMED", with: "", options: [], range: nil)
	}
)

private func assertImmutableObjectsEqual(_ lhs: Struct, _ rhs: Struct) {
	XCTAssertEqual(lhs.prop1, rhs.prop1)
	XCTAssertEqual(lhs.prop2, rhs.prop2)
	XCTAssertEqual(lhs.prop3, rhs.prop3)
	XCTAssertEqual(lhs.prop4, rhs.prop4)
	XCTAssertEqual(lhs.prop5, rhs.prop5)
	XCTAssertEqual(lhs.prop6, rhs.prop6)
	XCTAssertEqual(lhs.prop7, rhs.prop7)
	XCTAssertEqual(lhs.prop8, rhs.prop8)
	XCTAssertEqual(lhs.prop23, rhs.prop23)
	
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
