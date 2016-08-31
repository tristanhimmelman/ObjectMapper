//
//  NSDataTransformTests.swift
//  ObjectMapper
//
//  Created by Yagrushkin, Evgeny on 8/30/16.
//  Copyright © 2016 hearst. All rights reserved.
//

import XCTest
import ObjectMapper

class NSDataTransformTests: XCTestCase {
	
	let mapper = Mapper<NSDataType>()

	func testNSDataTransform() {

		let dataLength = 20
		let bytes = malloc(dataLength)
		let data = NSData(bytes: bytes, length: dataLength)
		let dataString = data.base64EncodedStringWithOptions([])
		let JSONString = "{\"data\" : \"\(dataString)\"}"
		
		let mappedObject = mapper.map(JSONString)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.stringData, dataString)
		XCTAssertEqual(mappedObject?.data, data)
	}

}

class NSDataType: Mappable {
	
	var data: NSData?
	var stringData: String?
	
	init(){
		
	}
	
	required init?(_ map: Map){
		
	}
	
	func mapping(map: Map) {
		stringData <- map["data"]
		data <- (map["data"], NSDataTransform())
	}
}
