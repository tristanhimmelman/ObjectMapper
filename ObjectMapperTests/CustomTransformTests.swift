//
//  CustomTransformTests.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2015-03-09.
//  Copyright (c) 2015 hearst. All rights reserved.
//

import Foundation
import XCTest
import ObjectMapper
import Nimble

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
		expect(parsedTransforms).notTo(beNil())
		expect(parsedTransforms?.date).to(equal(transforms.date))
		expect(parsedTransforms?.dateOpt).to(equal(transforms.dateOpt))
	}
	
	func testISO8601DateTransform() {
		let transforms = Transforms()
		transforms.ISO8601Date = NSDate(timeIntervalSince1970: 1398956159)
		transforms.ISO8601DateOpt = NSDate(timeIntervalSince1970: 1398956159)
		let JSON = mapper.toJSON(transforms)

		let parsedTransforms = mapper.map(JSON)
		expect(parsedTransforms).notTo(beNil())
		expect(parsedTransforms?.ISO8601Date).to(equal(transforms.ISO8601Date))
		expect(parsedTransforms?.ISO8601DateOpt).to(equal(transforms.ISO8601DateOpt))
	}
	
	func testISO8601DateTransformWithInvalidInput() {
		var JSON: [String: AnyObject] = ["ISO8601Date": ""]
		let transforms = mapper.map(JSON)

		expect(transforms?.ISO8601DateOpt).to(beNil())

		JSON["ISO8601Date"] = "incorrect format"

		let transforms2 = mapper.map(JSON)

		expect(transforms2?.ISO8601DateOpt).to(beNil())
	}
	
	func testCustomFormatDateTransform(){
		let dateString = "2015-03-03T02:36:44"
		let JSON: [String: AnyObject] = ["customFormateDate": dateString]
		let transform: Transforms! = mapper.map(JSON)
		expect(transform).notTo(beNil())
		
		let JSONOutput = mapper.toJSON(transform)

		expect(JSONOutput["customFormateDate"] as? String).to(equal(dateString))
	}
	
	func testIntToStringTransformOf() {
		let intValue = 12345
		let JSON: [String: AnyObject] = ["intWithString": "\(intValue)"]
		let transforms = mapper.map(JSON)

		expect(transforms?.intWithString).to(equal(intValue))
	}
	
	func testInt64MaxValue() {
		let transforms = Transforms()
		transforms.int64Value = INT64_MAX
		
		let JSON = mapper.toJSON(transforms)

		let parsedTransforms = mapper.map(JSON)
		expect(parsedTransforms).notTo(beNil())
		expect(parsedTransforms?.int64Value).to(equal(transforms.int64Value))
	}
	
	func testURLTranform() {
		let transforms = Transforms()
		transforms.URL = NSURL(string: "http://google.com/image/1234")!
		transforms.URLOpt = NSURL(string: "http://google.com/image/1234")
		
		let JSON = mapper.toJSON(transforms)

		let parsedTransforms = mapper.map(JSON)
		expect(parsedTransforms).notTo(beNil())
		expect(parsedTransforms?.URL).to(equal(transforms.URL))
		expect(parsedTransforms?.URLOpt).to(equal(transforms.URLOpt))
	}
	
	func testEnumTransform() {
		let JSON: [String: AnyObject] = ["firstImageType" : "cover", "secondImageType" : "thumbnail"]
		let transforms = mapper.map(JSON)

		let imageType = Transforms.ImageType.self
		expect(transforms?.firstImageType).to(equal(imageType.Cover))
		expect(transforms?.secondImageType).to(equal(imageType.Thumbnail))
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

	static func newInstance(map: Map) -> Mappable? {
		return Transforms()
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

