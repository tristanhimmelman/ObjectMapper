//
//  NSDataTransformTests.swift
//  ObjectMapper
//
//  Created by Yagrushkin, Evgeny on 8/30/16.
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
