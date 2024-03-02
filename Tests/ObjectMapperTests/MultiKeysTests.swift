//
//  MultiKeysTests.swift
//  ObjectMapper
//
//  Created by xinting on 2023/12/14.
//  Copyright © 2023 hearst. All rights reserved.
//
//  The MIT License (MIT)
//
//  Copyright (c) 2014-2018 Tristan Himmelman
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

import XCTest
import ObjectMapper

class MultiKeysTests: ObjectMapperTests {
	let multiKeyUserMapper = Mapper<MultiKeyUser>()
	
	func testBasicMultiParsing() {
		let username = "John Doe"
		let nickname = "John"
		let identifier = "user8723"
		let photoCount = 13
		let age = 1227
		let weight = 123.23
		let weightInKG = 180.0
		let float: Float = 123.231
		let drinker = true
		let smoker = false
		let sex: Sex = .Female
		let gender: Sex = .Male
		let canDrive = true
		let subUserJSON: [String: Any] = [
			"identifier": "user8723",
			"drinker": true,
			"age": 17,
			"username": "sub user",
			"canDrive": canDrive
		]
		let classMate: [String: Any] = [
			"identifier": "classmate8723",
			"drinker": false,
			"age": 18,
			"username": "sub user classmate",
			"canDrive": canDrive
		]
		
		var userJson: [String: Any] = [
			"username": username,
			"nickname": nickname,
			"identifier": identifier,
			"photoCount": photoCount,
			"age": age,
			"drinker": drinker,
			"smoker": smoker,
			"sex": sex.rawValue,
			"gender": gender.rawValue,
			"canDrive": canDrive,
			"arr": [
				"bla", true, 42
			],
			"dict": [
				"key1": "value1",
				"key2": false,
				"key3": 142
			],
			"arrOpt": [
				"bla", true, 42
			],
			"dictOpt": [
				"key1": "value1",
				"key2": false,
				"key3": 142
			],
			"weight": weight,
			"weightInKG": weightInKG,
			"float": float,
			"friend": subUserJSON,
			"classmate": classMate,
			"friendDictionary": [
				"bestFriend": subUserJSON
			],
			"friends": [subUserJSON, subUserJSON]
		]

		guard var user = multiKeyUserMapper.map(JSON: userJson) else {
			XCTFail()
			return
		}
		
		XCTAssertNotNil(user)
		XCTAssertEqual(username, user.username)
		XCTAssertEqual(identifier, user.identifier)
		XCTAssertEqual(photoCount, user.photoCount)
		XCTAssertEqual(age, user.age)
		XCTAssertEqual(weight, user.weight)
		XCTAssertEqual(float, user.float)
		XCTAssertEqual(drinker, user.drinker)
		XCTAssertEqual(smoker, user.smoker)
		XCTAssertEqual(sex, user.sex)
		XCTAssertEqual(canDrive, user.canDrive)
		XCTAssertNotNil(user.friends)
		XCTAssertEqual(user.friends?.count, 2)
		XCTAssertEqual(user.friends?[1].canDrive, canDrive)
		XCTAssertEqual(user.friend?.age, 17)
		
		userJson.removeValue(forKey: "username")
		userJson.removeValue(forKey: "weight")
		userJson.removeValue(forKey: "sex")
		userJson.removeValue(forKey: "friend")
		
		guard let nickUser = multiKeyUserMapper.map(JSON: userJson) else {
			XCTFail()
			return
		}
		user = nickUser
		XCTAssertNotNil(user)
		XCTAssertEqual(nickname, user.username)
		XCTAssertEqual(identifier, user.identifier)
		XCTAssertEqual(photoCount, user.photoCount)
		XCTAssertEqual(age, user.age)
		XCTAssertEqual(weightInKG, user.weight)
		XCTAssertEqual(float, user.float)
		XCTAssertEqual(drinker, user.drinker)
		XCTAssertEqual(smoker, user.smoker)
		XCTAssertEqual(gender, user.sex)
		XCTAssertEqual(canDrive, user.canDrive)
		XCTAssertNotNil(user.friends)
		XCTAssertEqual(user.friends?.count, 2)
		XCTAssertEqual(user.friends?[1].canDrive, canDrive)
		XCTAssertEqual(user.friend?.age, 18)
	}
	
	class MultiKeyUser: User {
		override func mapping(map: Map) {
			username         <- map["username"].or["nickname"]
			identifier       <- map["identifier"]
			photoCount       <- map["photoCount"]
			age              <- map["age"]
			weight           <- map["weight"].or["weightInKG"]
			float            <- map["float"]
			drinker          <- map["drinker"]
			smoker           <- map["smoker"]
			sex              <- map["sex"].or["gender"]
			canDrive		 <- map["canDrive"]
			arr              <- map["arr"]
			arrOptional      <- map["arrOpt"]
			dict             <- map["dict"]
			dictOptional     <- map["dictOpt"]
			friend           <- map["friend"].or["classmate"]
			friends          <- map["friends"]
			friendDictionary <- map["friendDictionary"]
			dictString		 <- map["dictString"]
		}
	}
}
