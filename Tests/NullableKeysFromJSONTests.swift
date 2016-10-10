//
//  NullableKeysFromJSONTests.swift
//  ObjectMapper
//
//  Created by Fabio Teles on 3/22/16.
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

class NullableKeysFromJSONTests: XCTestCase {

	let fullJSONString = "{\"firstName\": \"John\", \"lastName\": \"Doe\", \"team\": \"Broncos\", \"age\": 25, \"address\": {\"street\": \"Nothing Ave\", \"number\": 101, \"city\": \"Los Angeles\"} }"
	let nullJSONString = "{\"firstName\": \"John\", \"lastName\": null, \"team\": \"Broncos\", \"age\": null, \"address\": {\"street\": \"Nothing Ave\", \"number\": 101, \"city\": null} }"
	let absentJSONString = "{\"firstName\": \"John\", \"team\": \"Broncos\", \"address\": {\"street\": \"Nothing Ave\", \"number\": 102} }"

	let mapper = Mapper<Player>()

    override func setUp() {
        super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testMapperNullifiesValues() {
		guard let player = mapper.map(JSONString: fullJSONString) else {
			XCTFail("Mapping failed")
			return
		}

		XCTAssertNotNil(player.lastName)
		XCTAssertNotNil(player.age)
		XCTAssertNotNil(player.address?.city)

		_ = mapper.map(JSONString: nullJSONString, toObject: player)

		XCTAssertNotNil(player.firstName)
		XCTAssertNil(player.lastName)
		XCTAssertNil(player.age)
		XCTAssertNil(player.address?.city)
    }

	func testMapperAbsentValues() {
		guard let player = mapper.map(JSONString: fullJSONString) else {
			XCTFail("Mapping failed")
			return
		}

		XCTAssertNotNil(player.lastName)
		XCTAssertNotNil(player.age)
		XCTAssertNotNil(player.address?.city)

		_ = mapper.map(JSONString: absentJSONString, toObject: player)

		XCTAssertNotNil(player.firstName)
		XCTAssertNotNil(player.lastName)
		XCTAssertNotNil(player.age)
		XCTAssertNotNil(player.address?.city)
		XCTAssertEqual(player.address?.number, 102)
	}
}

class Player: Mappable  {
	var firstName: String?
	var lastName: String?
	var team: String?
	var age: Int?
	var address: Address?

	required init?(map: Map){
		mapping(map: map)
	}

	func mapping(map: Map) {
		firstName <- map["firstName"]
		lastName <- map["lastName"]
		team <- map["team"]
		age <- map["age"]
		address <- map["address"]
	}
}

class Address: Mappable {
	var street: String?
	var number: Int?
	var city: String?

	required init?(map: Map){
		mapping(map: map)
	}

	func mapping(map: Map) {
		street <- map["street"]
		number <- map["number"]
		city <- map["city"]
	}
}
