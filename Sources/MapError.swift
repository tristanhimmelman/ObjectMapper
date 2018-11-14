//
//  MapError.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2016-09-26.
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

public struct MapError: Error {
	public var key: String?
	public var currentValue: Any?
	public var reason: String?
	public var file: StaticString?
	public var function: StaticString?
	public var line: UInt?
	
	public init(key: String?, currentValue: Any?, reason: String?, file: StaticString? = nil, function: StaticString? = nil, line: UInt? = nil) {
		self.key = key
		self.currentValue = currentValue
		self.reason = reason
		self.file = file
		self.function = function
		self.line = line
	}
}

extension MapError: CustomStringConvertible {
	
	private var location: String? {
		guard let file = file, let function = function, let line = line else { return nil }
		let fileName = ((String(describing: file).components(separatedBy: "/").last ?? "").components(separatedBy: ".").first ?? "")
		return "\(fileName).\(function):\(line)"
	}
	
	public var description: String {
		let info: [(String, Any?)] = [
			("- reason", reason),
			("- location", location),
			("- key", key),
			("- currentValue", currentValue),
			]
		let infoString = info.map { "\($0.0): \($0.1 ?? "nil")" }.joined(separator: "\n")
		return "Got an error while mapping.\n\(infoString)"
	}
	
}
