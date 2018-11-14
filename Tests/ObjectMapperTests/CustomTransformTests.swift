//
//  CustomTransformTests.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2015-03-09.
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

import Foundation
import XCTest
import ObjectMapper

#if os(iOS) || os(tvOS) || os(watchOS)
	typealias TestHexColor = UIColor
#else
	typealias TestHexColor = NSColor
#endif

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
		transforms.date = Date(timeIntervalSince1970: 946684800)
		transforms.dateOpt = Date(timeIntervalSince1970: 946684912)
		transforms.dateMs = transforms.date
		transforms.dateOptMs = transforms.dateOpt
		
		let JSON = mapper.toJSON(transforms)
		let parsedTransforms = mapper.map(JSON: JSON)
		XCTAssertNotNil(parsedTransforms)
		XCTAssertEqual(parsedTransforms?.date, transforms.date)
		XCTAssertEqual(parsedTransforms?.dateOpt, transforms.dateOpt)
		XCTAssertEqual(parsedTransforms?.dateMs, transforms.dateMs)
		XCTAssertEqual(parsedTransforms?.dateOptMs, transforms.dateOptMs)
		
		let JSONDateString: [String: Any] = ["date": "946684800", "dateOpt": "946684912",
											 "dateMs": "946684800000", "dateOptMs": "946684912000"]
		let parsedTransformsDateString = mapper.map(JSON: JSONDateString)
		
		XCTAssertNotNil(parsedTransformsDateString)
		XCTAssertEqual(parsedTransforms?.date, parsedTransformsDateString?.date)
		XCTAssertEqual(parsedTransforms?.dateOpt, parsedTransformsDateString?.dateOpt)
		XCTAssertEqual(parsedTransforms?.dateMs, parsedTransformsDateString?.dateMs)
		XCTAssertEqual(parsedTransforms?.dateOptMs, parsedTransformsDateString?.dateOptMs)

	}
	
	func testISO8601DateTransform() {
		let transforms = Transforms()
		transforms.ISO8601Date = Date(timeIntervalSince1970: 1398956159)
		transforms.ISO8601DateOpt = Date(timeIntervalSince1970: 1398956159)
		let JSON = mapper.toJSON(transforms)

		let parsedTransforms = mapper.map(JSON: JSON)
		XCTAssertNotNil(parsedTransforms)
		XCTAssertEqual(parsedTransforms?.ISO8601Date, transforms.ISO8601Date)
		XCTAssertEqual(parsedTransforms?.ISO8601DateOpt, transforms.ISO8601DateOpt)
	}
	
	func testISO8601DateTransformWithInvalidInput() {
		var JSON: [String: Any] = ["ISO8601Date": ""]
		let transforms = mapper.map(JSON: JSON)

		XCTAssertNil(transforms?.ISO8601DateOpt)

		JSON["ISO8601Date"] = "incorrect format"

		let transforms2 = mapper.map(JSON: JSON)

		XCTAssertNil(transforms2?.ISO8601DateOpt)
	}
	
	func testCustomFormatDateTransform(){
		let dateString = "2015-03-03T02:36:44"
		let JSON: [String: Any] = ["customFormateDate": dateString]
		let transform: Transforms! = mapper.map(JSON: JSON)
		XCTAssertNotNil(transform)
		
		let JSONOutput = mapper.toJSON(transform)

		XCTAssertEqual(JSONOutput["customFormateDate"] as? String, dateString)
	}
	
	func testIntToStringTransformOf() {
		let intValue = 12345
		let JSON: [String: Any] = ["intWithString": "\(intValue)"]
		let transforms = mapper.map(JSON: JSON)

		XCTAssertEqual(transforms?.intWithString, intValue)
	}
	
	func testInt64MaxValue() {
		let transforms = Transforms()
		transforms.int64Value = INT64_MAX
		
		let JSON = mapper.toJSON(transforms)

		let parsedTransforms = mapper.map(JSON: JSON)
		XCTAssertNotNil(parsedTransforms)
		XCTAssertEqual(parsedTransforms?.int64Value, transforms.int64Value)
	}
	
	func testURLTranform() {
		let transforms = Transforms()
		transforms.URL = URL(string: "http://google.com/image/1234")!
		transforms.URLOpt = URL(string: "http://google.com/image/1234")
		transforms.URLWithoutEncoding = URL(string: "http://google.com/image/1234#fragment")!
		
		let JSON = mapper.toJSON(transforms)

		let parsedTransforms = mapper.map(JSON: JSON)
		
		XCTAssertNotNil(parsedTransforms)
		XCTAssertEqual(parsedTransforms?.URL, transforms.URL)
		XCTAssertEqual(parsedTransforms?.URLOpt, transforms.URLOpt)
		XCTAssertEqual(parsedTransforms?.URLWithoutEncoding, transforms.URLWithoutEncoding)
	}
	
	func testEnumTransform() {
		let JSON: [String: Any] = ["firstImageType": "cover", "secondImageType": "thumbnail"]
		let transforms = mapper.map(JSON: JSON)

		let imageType = Transforms.ImageType.self
		XCTAssertEqual(transforms?.firstImageType, imageType.Cover)
		XCTAssertEqual(transforms?.secondImageType, imageType.Thumbnail)
	}
	
	func testHexColorTransform() {
		let JSON: [String: Any] = [
			"colorRed": "#FF0000",
			"colorGreenLowercase": "#00FF00",
			"colorBlueWithoutHash": "0000FF",
			"color3lenght": "F00",
			"color4lenght": "F00f",
			"color8lenght": "ff0000ff"
		]
		
		let transform = mapper.map(JSON: JSON)
		
		XCTAssertEqual(transform?.colorRed, TestHexColor.red)
		XCTAssertEqual(transform?.colorGreenLowercase, TestHexColor.green)
		XCTAssertEqual(transform?.colorBlueWithoutHash, TestHexColor.blue)
		XCTAssertEqual(transform?.color3lenght, TestHexColor.red)
		XCTAssertEqual(transform?.color4lenght, TestHexColor.red)
		XCTAssertEqual(transform?.color8lenght, TestHexColor.red)
		
		let JSONOutput = mapper.toJSON(transform!)
		
		XCTAssertEqual(JSONOutput["colorRed"] as? String, "FF0000")
		XCTAssertEqual(JSONOutput["colorGreenLowercase"] as? String, "00FF00")
		XCTAssertEqual(JSONOutput["colorBlueWithoutHash"] as? String, "#0000FF") // prefixToJSON = true
		XCTAssertEqual(JSONOutput["color3lenght"] as? String, "FF0000")
		XCTAssertEqual(JSONOutput["color4lenght"] as? String, "FF0000")
		XCTAssertEqual(JSONOutput["color8lenght"] as? String, "FF0000FF") // alphaToJSON = true
	}
}

class Transforms: Mappable {
	
	internal enum ImageType: String {
		case Cover = "cover"
		case Thumbnail = "thumbnail"
	}

	var date = Date()
	var dateOpt: Date?
	
	var dateMs = Date()
	var dateOptMs: Date?
	
	var ISO8601Date: Date = Date()
	var ISO8601DateOpt: Date?
	
	var customFormatDate = Date()
	var customFormatDateOpt: Date?
	
	var URL = Foundation.URL(string: "")
	var URLOpt: Foundation.URL?
	var URLWithoutEncoding = Foundation.URL(string: "")
	
	var intWithString: Int = 0
	
	var int64Value: Int64 = 0
	
	var firstImageType: ImageType?
	var secondImageType: ImageType?
	
	var colorRed: TestHexColor?
	var colorGreenLowercase: TestHexColor?
	var colorBlueWithoutHash: TestHexColor?
	var color3lenght: TestHexColor?
	var color4lenght: TestHexColor?
	var color8lenght: TestHexColor?

	init(){
		
	}
	
	required init?(map: Map){
		
	}
	
	func mapping(map: Map) {
		date				<- (map["date"], DateTransform())
		dateOpt				<- (map["dateOpt"], DateTransform())
		
		dateMs				<- (map["dateMs"], DateTransform(unit: .milliseconds))
		dateOptMs			<- (map["dateOptMs"], DateTransform(unit: .milliseconds))
		
		ISO8601Date			<- (map["ISO8601Date"], ISO8601DateTransform())
		ISO8601DateOpt		<- (map["ISO8601DateOpt"], ISO8601DateTransform())
		
		customFormatDate	<- (map["customFormateDate"], CustomDateFormatTransform(formatString: "yyyy-MM-dd'T'HH:mm:ss"))
		customFormatDateOpt <- (map["customFormateDateOpt"], CustomDateFormatTransform(formatString: "yyyy-MM-dd'T'HH:mm:ss"))

		URL					<- (map["URL"], URLTransform())
		URLOpt				<- (map["URLOpt"], URLTransform())
		URLWithoutEncoding  <- (map["URLWithoutEncoding"], URLTransform(shouldEncodeURLString: false))
		
		intWithString		<- (map["intWithString"], TransformOf<Int, String>(fromJSON: { $0 == nil ? nil : Int($0!) }, toJSON: { $0.map { String($0) } }))
		int64Value			<- (map["int64Value"], TransformOf<Int64, NSNumber>(fromJSON: { $0?.int64Value }, toJSON: { $0.map { NSNumber(value: $0) } }))
		
		firstImageType		<- (map["firstImageType"], EnumTransform<ImageType>())
		secondImageType		<- (map["secondImageType"], EnumTransform<ImageType>())
		
		colorRed			<- (map["colorRed"], HexColorTransform())
		colorGreenLowercase <- (map["colorGreenLowercase"], HexColorTransform())
		colorBlueWithoutHash <- (map["colorBlueWithoutHash"], HexColorTransform(prefixToJSON: true))
		color3lenght			<- (map["color3lenght"], HexColorTransform())
		color4lenght			<- (map["color4lenght"], HexColorTransform())
		color8lenght			<- (map["color8lenght"], HexColorTransform(alphaToJSON: true))
	}
}

