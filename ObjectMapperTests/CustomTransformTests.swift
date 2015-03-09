//
//  CustomTransformTests.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2015-03-09.
//  Copyright (c) 2015 hearst. All rights reserved.
//

import UIKit
import XCTest
import ObjectMapper

class CustomTransformTests: XCTestCase {

	let mapper = Mapper<Transforms>()
	
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

	func testDateTransform() {
		var transforms = Transforms()
		transforms.date = NSDate(timeIntervalSince1970: 946684800)
		transforms.dateOpt = NSDate(timeIntervalSince1970: 946684912)
		
		let JSON = mapper.toJSON(transforms)
		if let parsedTransforms = mapper.map(JSON) {
			XCTAssert(transforms.date.compare(parsedTransforms.date) == .OrderedSame, "Date should be the same")
			XCTAssert(transforms.dateOpt!.compare(parsedTransforms.dateOpt!) == .OrderedSame, "Date optional should be the same")
		} else {
			XCTAssert(false, "Date Transform failed")
		}
	}
	
	func testISO8601DateTransformWithInvalidInput() {
		var JSON: [String: AnyObject] = ["ISO8601Date": ""]
		let transforms = mapper.map(JSON)
		
		XCTAssert(transforms.ISO8601DateOpt == nil, "ISO8601DateTransform should return nil for empty string")
		
		JSON["ISO8601Date"] = "incorrect format"

		let transforms2 = mapper.map(JSON)
		
		XCTAssert(transforms2.ISO8601DateOpt == nil, "ISO8601DateTransform should return nil for incorrect format")
	}
	
	func testIntToStringTransformOf() {
		let intValue = 12345
		var JSON: [String: AnyObject] = ["intWithString": "\(intValue)"]
		let transforms = mapper.map(JSON)

		XCTAssert(transforms.intWithString == intValue, "IntToString failed")
	}
	
	func testInt64MaxValue() {
		let transforms = Transforms()
		transforms.int64Value = INT64_MAX
		
		let JSON = mapper.toJSON(transforms)
		
		if let parsedTransforms = mapper.map(JSON) {
			XCTAssert(parsedTransforms.int64Value == transforms.int64Value, "int64Type should be the same")
		} else {
			XCTAssert(false, "Int64Max failed")
		}
	}
}

class Transforms: Mappable {

	var date = NSDate()
	var dateOpt: NSDate?
	
	var ISO8601Date: NSDate = NSDate()
	var ISO8601DateOpt: NSDate?
	
	var URL = NSURL()
	var URLOpt: NSURL?
	
	var intWithString: Int = 0
	
	var int64Value: Int64 = 0
	
	init() {}
	
	required init?(_ map: Map) {
		mapping(map)
	}
	
	func mapping(map: Map) {
		date			<- (map["date"], DateTransform())
		dateOpt			<- (map["dateOpt"], DateTransform())
		
		ISO8601Date     <- (map["ISO8601Date"], ISO8601DateTransform())
		ISO8601DateOpt  <- (map["ISO8601DateOpt"], ISO8601DateTransform())

		URL				<- (map["imageURL"], URLTransform())
		URLOpt			<- (map["imageURL"], URLTransform())
		
		intWithString   <- (map["intWithString"], TransformOf<Int, String>(fromJSON: { $0?.toInt() }, toJSON: { $0.map { String($0) } }))
		int64Value      <- (map["int64Value"], TransformOf<Int64, NSNumber>(fromJSON: { $0?.longLongValue }, toJSON: { $0.map { NSNumber(longLong: $0) } }))
	}
}

