//
//  URLTransformTests.swift
//  ObjectMapper
//
//  Created by pawel-rusin on 4/7/17.
//  Copyright © 2017 hearst. All rights reserved.
//

import XCTest
import ObjectMapper

class URLTransformTests: XCTestCase {

    func testUrlQueryAllowed() {
        let urlTransform = URLTransform()
        let input = "https://example.com/search?query=foo"
        let output = urlTransform.transformFromJSON(input)

        XCTAssertEqual(output, URL(string: "https://example.com/search?query=foo"))
    }

    func testCanPassInAllowedCharacterSet() {
        var characterSet = CharacterSet.urlQueryAllowed
        characterSet.insert(charactersIn: "%")
        let urlTransform = URLTransform(allowedCharacterSet: characterSet)
        let input = "https://example.com/%25"
        let output = urlTransform.transformFromJSON(input)

        XCTAssertEqual(output, URL(string: "https://example.com/%25"))
    }
}
