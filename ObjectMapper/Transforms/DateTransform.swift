//
//  DateTransform.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2014-10-13.
//  Copyright (c) 2014 hearst. All rights reserved.
//

import Foundation

public class DateTransform: TransformType {
	public typealias Object = NSDate
	public typealias JSON = Double

	public init() {}

	public func transformFromJSON(value: AnyObject?) -> NSDate? {
		if let timeInt = value as? Double {
			return NSDate(timeIntervalSince1970: NSTimeInterval(timeInt))
		}
		return nil
	}

	public func transformToJSON(value: NSDate?) -> Double? {
		if let date = value {
			return Double(date.timeIntervalSince1970)
		}
		return nil
	}
}
