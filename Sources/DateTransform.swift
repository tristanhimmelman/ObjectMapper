//
//  DateTransform.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2014-10-13.
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

open class DateTransform: TransformType {
	public typealias Object = Date
	public typealias JSON = Double

	public enum Unit: TimeInterval {
		case seconds = 1
		case milliseconds = 1_000
		
		func addScale(to interval: TimeInterval) -> TimeInterval {
			return interval * rawValue
		}
		
		func removeScale(from interval: TimeInterval) -> TimeInterval {
			return interval / rawValue
		}
	}
	
	private let unit: Unit
	
	public init(unit: Unit = .seconds) {
		self.unit = unit
	}

	open func transformFromJSON(_ value: Any?) -> Date? {
		var timeInterval: TimeInterval?
		if let timeInt = value as? Double {
			timeInterval = TimeInterval(timeInt)
		}
		
		if let timeStr = value as? String {
			timeInterval = TimeInterval(atof(timeStr))
		}
		
		return timeInterval.flatMap {
			return Date(timeIntervalSince1970: unit.removeScale(from: $0))
		}
	}

	open func transformToJSON(_ value: Date?) -> Double? {
		if let date = value {
			return Double(unit.addScale(to: date.timeIntervalSince1970))
		}
		return nil
	}
}
