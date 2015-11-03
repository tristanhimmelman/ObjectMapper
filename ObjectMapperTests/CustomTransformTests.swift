//
//  CustomTransformTests.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2015-03-09.
//
//  The MIT License (MIT)
//
//  Copyright (c) 2014-2015 Hearst
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
		let transforms = Transforms()
		transforms.date = NSDate(timeIntervalSince1970: 946684800)
		transforms.dateOpt = NSDate(timeIntervalSince1970: 946684912)
		
		let JSON = mapper.toJSON(transforms)
		let parsedTransforms = mapper.map(JSON)
		XCTAssertNotNil(parsedTransforms)
		XCTAssertEqual(parsedTransforms?.date, transforms.date)
		XCTAssertEqual(parsedTransforms?.dateOpt, transforms.dateOpt)
	}
	
	func testISO8601DateTransform() {
		let transforms = Transforms()
		transforms.ISO8601Date = NSDate(timeIntervalSince1970: 1398956159)
		transforms.ISO8601DateOpt = NSDate(timeIntervalSince1970: 1398956159)
		let JSON = mapper.toJSON(transforms)

		let parsedTransforms = mapper.map(JSON)
		XCTAssertNotNil(parsedTransforms)
		XCTAssertEqual(parsedTransforms?.ISO8601Date, transforms.ISO8601Date)
		XCTAssertEqual(parsedTransforms?.ISO8601DateOpt, transforms.ISO8601DateOpt)
	}
	
	func testISO8601DateTransformWithInvalidInput() {
		var JSON: [String: AnyObject] = ["ISO8601Date": ""]
		let transforms = mapper.map(JSON)

		XCTAssertNil(transforms?.ISO8601DateOpt)

		JSON["ISO8601Date"] = "incorrect format"

		let transforms2 = mapper.map(JSON)

		XCTAssertNil(transforms2?.ISO8601DateOpt)
	}
	
	func testCustomFormatDateTransform(){
		let dateString = "2015-03-03T02:36:44"
		let JSON: [String: AnyObject] = ["customFormateDate": dateString]
		let transform: Transforms! = mapper.map(JSON)
		XCTAssertNotNil(transform)
		
		let JSONOutput = mapper.toJSON(transform)

		XCTAssertEqual(JSONOutput["customFormateDate"] as? String, dateString)
	}
	
	func testIntToStringTransformOf() {
		let intValue = 12345
		let JSON: [String: AnyObject] = ["intWithString": "\(intValue)"]
		let transforms = mapper.map(JSON)

		XCTAssertEqual(transforms?.intWithString, intValue)
	}
	
	func testInt64MaxValue() {
		let transforms = Transforms()
		transforms.int64Value = INT64_MAX
		
		let JSON = mapper.toJSON(transforms)

		let parsedTransforms = mapper.map(JSON)
		XCTAssertNotNil(parsedTransforms)
		XCTAssertEqual(parsedTransforms?.int64Value, transforms.int64Value)
	}
	
	func testURLTranform() {
		let transforms = Transforms()
		transforms.URL = NSURL(string: "http://google.com/image/1234")!
		transforms.URLOpt = NSURL(string: "http://google.com/image/1234")
		
		let JSON = mapper.toJSON(transforms)

		let parsedTransforms = mapper.map(JSON)
		
		XCTAssertNotNil(parsedTransforms)
		XCTAssertEqual(parsedTransforms?.URL, transforms.URL)
		XCTAssertEqual(parsedTransforms?.URLOpt, transforms.URLOpt)
	}
	
	func testEnumTransform() {
		let JSON: [String: AnyObject] = ["firstImageType" : "cover", "secondImageType" : "thumbnail"]
		let transforms = mapper.map(JSON)

		let imageType = Transforms.ImageType.self
		XCTAssertEqual(transforms?.firstImageType, imageType.Cover)
		XCTAssertEqual(transforms?.secondImageType, imageType.Thumbnail)
	}
}

class Transforms: Mappable {
	
	internal enum ImageType: String {
		case Cover = "cover"
		case Thumbnail = "thumbnail"
	}

	var date = NSDate()
	var dateOpt: NSDate?
	
	var ISO8601Date: NSDate = NSDate()
	var ISO8601DateOpt: NSDate?
	
	var customFormatDate = NSDate()
	var customFormatDateOpt: NSDate?
	
	var URL = NSURL()
	var URLOpt: NSURL?
	
	var intWithString: Int = 0
	
	var int64Value: Int64 = 0
	
	var firstImageType: ImageType?
	var secondImageType: ImageType?

	init(){
		
	}
	
	required init?(_ map: Map){
		
	}
	
	func mapping(map: Map) {
		date				<- (map["date"], DateTransform())
		dateOpt				<- (map["dateOpt"], DateTransform())
		
		ISO8601Date			<- (map["ISO8601Date"], ISO8601DateTransform())
		ISO8601DateOpt		<- (map["ISO8601DateOpt"], ISO8601DateTransform())
		
		customFormatDate	<- (map["customFormateDate"], CustomDateFormatTransform(formatString: "yyyy-MM-dd'T'HH:mm:ss"))
		customFormatDateOpt <- (map["customFormateDateOpt"], CustomDateFormatTransform(formatString: "yyyy-MM-dd'T'HH:mm:ss"))

		URL					<- (map["URL"], URLTransform())
		URLOpt				<- (map["URLOpt"], URLTransform())
		
		intWithString		<- (map["intWithString"], TransformOf<Int, String>(fromJSON: { $0 == nil ? nil : Int($0!) }, toJSON: { $0.map { String($0) } }))
		int64Value			<- (map["int64Value"], TransformOf<Int64, NSNumber>(fromJSON: { $0?.longLongValue }, toJSON: { $0.map { NSNumber(longLong: $0) } }))
		
		firstImageType		<- (map["firstImageType"], EnumTransform<ImageType>())
		secondImageType		<- (map["secondImageType"], EnumTransform<ImageType>())
	}
}

