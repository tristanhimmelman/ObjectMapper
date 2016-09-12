//
//  NSDataTransformTests.swift
//  ObjectMapper
//
//  Created by Yagrushkin, Evgeny on 8/30/16.
//  Copyright © 2016 hearst. All rights reserved.
//

import XCTest
import ObjectMapper

class DataTransformTests: XCTestCase {
	
	let mapper = Mapper<DataType>()

	func testDataTransform() {

		let dataLength = 20
		let bytes = malloc(dataLength)
		
		let data = Data(bytes: bytes!, count: dataLength)
		let dataString = data.base64EncodedString()
		let JSONString = "{\"data\" : \"\(dataString)\"}"
		
		let mappedObject = mapper.map(JSONString: JSONString)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.stringData, dataString)
		XCTAssertEqual(mappedObject?.data, data)
	}

}

class DataType: Mappable {
	
	var data: Data?
	var stringData: String?
	
	init(){
		
	}
	
	required init?(map: Map){
		
	}
	
	func mapping(map: Map) {
		stringData <- map["data"]
		data <- (map["data"], DataTransform())
	}
}
