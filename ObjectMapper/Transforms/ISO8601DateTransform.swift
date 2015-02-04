//
//  ISO8601DateTransform.swift
//  ObjectMapper
//
//  Created by Jean-Pierre Mouilleseaux on 21 Nov 2014.
//
//

import Foundation

public class ISO8601DateTransform: TransformType {
	public typealias Object = NSDate
	public typealias JSON = String

	public init() {}

	private lazy var dateFormatter: NSDateFormatter = {
		let formatter = NSDateFormatter()
		formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
		formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
		return formatter
	}()

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
