//
//  CustomDateFormatTransform.swift
//  ObjectMapper
//
//  Created by Dan McCracken on 3/8/15.
//
//

import Foundation

public class CustomDateFormatTransform: DateFormaterTransform {
	
    public init(formatString: String) {
		let formatter = NSDateFormatter()
		formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
		formatter.dateFormat = formatString
		
		super.init(dateFormatter: formatter)
    }
}