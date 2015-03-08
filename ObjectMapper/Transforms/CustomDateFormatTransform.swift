//
//  CustomDateFormatTransform.swift
//  ObjectMapper
//
//  Created by Dan McCracken on 3/8/15.
//
//

import Foundation

public class CustomDateFormatTransform: TransformType {
    public typealias Object = NSDate
    public typealias JSON = String
    
    let formatString: String = ""

    public init(formatString: String) {
        if !formatString.isEmpty {
            self.formatString = formatString
        }
    }

	private lazy var dateFormatter: NSDateFormatter = {
		let formatter = NSDateFormatter()
		formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
		formatter.dateFormat = self.formatString
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