//
//  ISO8601DateTransform.swift
//  ObjectMapper
//
//  Created by Jean-Pierre Mouilleseaux on 21 Nov 2014.
//
//

import Foundation

public class ISO8601DateTransform<ObjectType, JSONType>: MapperTransform<ObjectType, JSONType> {
    public override init() {
    }

    func dateFormatter() -> NSDateFormatter {
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return formatter
    }

    override public func transformFromJSON(value: AnyObject?) -> ObjectType? {
        if let dateString = value as? String {
            return (dateFormatter().dateFromString(dateString) as ObjectType?)
        }
        return nil
    }

    override public func transformToJSON(value: ObjectType?) -> JSONType? {
        if let date = value as? NSDate {
            return (dateFormatter().stringFromDate(date) as JSONType)
        }
        return nil
    }
}
