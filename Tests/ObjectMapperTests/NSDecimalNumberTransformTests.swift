//
//  NestedArrayTests.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 10/21/15.
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

class NSDecimalNumberTransformTests: XCTestCase {

    let mapper = Mapper<NSDecimalNumberType>()

    func testNSDecimalNumberTransform() {
        let int: Int = 11
        let double: Double = 11.11
        /* Cannot use a float literal (eg: `let decimal: Decimal = 1.66`) as this transforms the value from 1.66 to 1.6599999999999995904 */
        let decimal = Decimal(string: "1.66")!
        let intString = "11"
        let doubleString = "11.11"
        let decimalString = "1.66"
        let JSONString = "{\"double\" : \(doubleString), \"int\" : \(intString), \"decimal\" : \(decimalString), \"intString\" : \"\(intString)\", \"doubleString\" : \"\(doubleString)\", \"decimalString\" : \"\(decimalString)\"}"

        let mappedObject = mapper.map(JSONString: JSONString)

        XCTAssertNotNil(mappedObject)
        XCTAssertEqual(mappedObject?.int, NSDecimalNumber(value: int))
        XCTAssertEqual(mappedObject?.double, NSDecimalNumber(value: double))
        XCTAssertEqual(mappedObject?.decimal, NSDecimalNumber(decimal: decimal))
        XCTAssertEqual(mappedObject?.intString, NSDecimalNumber(string: intString))
        XCTAssertEqual(mappedObject?.doubleString, NSDecimalNumber(string: doubleString))
        XCTAssertEqual(mappedObject?.decimalString, NSDecimalNumber(string: decimalString))
        XCTAssertEqual(mappedObject?.int?.stringValue, intString)
        XCTAssertEqual(mappedObject?.double?.stringValue, doubleString)
        XCTAssertEqual(mappedObject?.decimal?.stringValue, decimalString)
    }
}

class NSDecimalNumberType: Mappable {

    var int: NSDecimalNumber?
    var double: NSDecimalNumber?
    var decimal: NSDecimalNumber?
    var intString: NSDecimalNumber?
    var doubleString: NSDecimalNumber?
    var decimalString: NSDecimalNumber?

    init(){

    }

    required init?(map: Map){

    }

    func mapping(map: Map) {
        int <- (map["int"], NSDecimalNumberTransform())
        double <- (map["double"], NSDecimalNumberTransform())
        decimal <- (map["decimal"], NSDecimalNumberTransform())
        intString <- (map["intString"], NSDecimalNumberTransform())
        doubleString <- (map["doubleString"], NSDecimalNumberTransform())
        decimalString <- (map["decimalString"], NSDecimalNumberTransform())
    }
}
