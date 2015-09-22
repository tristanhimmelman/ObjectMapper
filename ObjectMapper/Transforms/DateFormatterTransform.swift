//
//  DateFormatterTransform.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2015-03-09.
//  Copyright (c) 2015 hearst. All rights reserved.
//

import Foundation

public class DateFormatterTransform: TransformType {
	public typealias Object = NSDate
	public typealias JSON = String
	
	let dateFormatter: NSDateFormatter
	
	public init(dateFormatter: NSDateFormatter) {
		self.dateFormatter = dateFormatter
	}
	
	public func transformFromJSON(value: AnyObject?) -> NSDate? {
		if let dateString = value as? String {
			return dateFormatter.dateFromString(dateString)
		}
		return nil
	}
	
	public func transformToJSON(value: NSDate?) -> String? {
		if let date = value {
			return dateFormatter.stringFromDate(date)
		}
		return nil
	}
}