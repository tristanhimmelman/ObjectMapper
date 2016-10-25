//
//  ISO8601DateTransform.swift
//  ObjectMapper
//
//  Created by Jean-Pierre Mouilleseaux on 21 Nov 2014.
//
//  The MIT License (MIT)
//
//  Copyright (c) 2014-2016 Hearst
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

open class ISO8601DateTransform: DateFormatterTransform {

	public init() {
		let formatter = DateFormatter()
		formatter.locale = Locale(identifier: "en_US_POSIX")
		formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
		
		super.init(dateFormatter: formatter)
	}
    
    override open func transformFromJSON(_ value: Any?) -> Date? {
        guard let value = value as? String else {
            return nil
        }
        let actualFormat = formatFrom(value)        
        dateFormatter.dateFormat = actualFormat.dateFormat
        return super.transformFromJSON(value)
    }
	
    /// get the current date string and try to find a valid format string for that string and returns the a valid format and a valid date to set them into a DateFormatter  
    func formatFrom(_ value:String) -> (dateString:String?, dateFormat:String?) {
        
        var regexString = "\\A(\\d{4})-(\\d{2})-(\\d{2})T(\\d{2}):(\\d{2})" // Mandatory - year-MM-DDTHH:mm
        regexString = regexString + ":?(\\d{2})?"                             // Optional - :ss
        regexString = regexString + "[.]?(\\d{1,6})?"                         // Optional - .nnnnnn
        regexString = regexString + "([+-])?(\\d{2})?:?(\\d{2})?|Z"           // Optional -[+-]hh:mm or Z
        regexString = regexString + "\\z"
        
        let regex: NSRegularExpression?
        var matchesResult: [NSTextCheckingResult]?
        do{
            regex = try NSRegularExpression (pattern: regexString, options: NSRegularExpression.Options.caseInsensitive)
            
            matchesResult = regex!.matches(in:value, options: NSRegularExpression.MatchingOptions.reportCompletion, range:NSMakeRange(0, value.characters.count))
        } catch{
            return (nil, nil)
        }
        
        guard let matches = matchesResult, matches.count > 0 else {
            return (nil, nil)
        }
		
        //this function is to convert a NSRange to Range<String.Index>
        let convertRange:(_ nsRange: NSRange, _ text:String) -> Range<String.Index>? = { nsRange, text in
            guard
                let from16 = text.utf16.index(text.utf16.startIndex, offsetBy: nsRange.location, limitedBy: text.utf16.endIndex),
                let to16 = text.utf16.index(from16, offsetBy: nsRange.length, limitedBy: text.utf16.endIndex),
                let from = String.Index(from16, within: text),
                let to = String.Index(to16, within: text)
                else { return nil }
            return from ..< to
        }
		
		var year, month, day, hour, minutes, seconds, secondFraction, sign, timeZoneHour, timeZoneMinutes: String?
		var tempRange: NSRange!
		
        for match in matches {
            let matchCount = match.numberOfRanges - 1
            var idx = 0 //components start from 1, 0 is the complete string
            let checkAndAssign:()->(String?) = {
                if idx < matchCount {
                    idx = idx + 1
                    tempRange = match.rangeAt(idx)
                    let substring:String? = tempRange.location != NSNotFound ? value.substring(with: convertRange(tempRange, value)!) : nil
                    return substring
                }
                return nil
            }
            
            year = checkAndAssign()
            month = checkAndAssign()
            day = checkAndAssign()
            hour = checkAndAssign()
            minutes = checkAndAssign()
            seconds = checkAndAssign()
            secondFraction = checkAndAssign()
            sign = checkAndAssign()
            timeZoneHour = checkAndAssign()
            timeZoneMinutes = checkAndAssign()
        }
        
        var dateString:String = ""
        var formatString:String = ""
        
        if let year = year {
            dateString = dateString + year + "-"
            formatString = formatString + "yyyy" + "-"
        }
        
        if let month = month {
            dateString = dateString + month + "-"
            formatString = formatString + "MM" + "-"
        }
        
        if let day = day {
            dateString = dateString + day
            formatString = formatString + "dd"
        }
        
        if let hour = hour {
            dateString = dateString + "T" + hour
            formatString = formatString + "'T'" + "HH"
        }
        
        if let minutes = minutes {
            dateString = dateString + ":" + minutes
            formatString = formatString + ":" + "mm"
        }
        
        if let seconds = seconds {
            dateString = dateString + ":" + seconds
            formatString = formatString + ":" + "ss"
        }
        if let secondFraction = secondFraction {
            dateString = dateString + "." + secondFraction
            formatString = formatString + "." + String(repeating: "S", count: secondFraction.characters.count)
        }
        if let sign = sign {
            dateString = dateString  + sign
            formatString = formatString + "Z"
        }
        if let timeZoneHour = timeZoneHour {
            dateString = dateString + timeZoneHour
            formatString = formatString + "ZZ"
        }
        
        if let timeZoneMinutes = timeZoneMinutes {
            dateString = dateString + timeZoneMinutes
            formatString = formatString + "ZZ"
        }
        
        return (dateString, formatString)
    }
}
