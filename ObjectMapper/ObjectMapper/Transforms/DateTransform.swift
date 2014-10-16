//
//  DateTransform.swift
//  BaseClient
//
//  Created by Tristan Himmelman on 2014-10-13.
//  Copyright (c) 2014 hearst. All rights reserved.
//

import UIKit

class DateTransform<ObjectType, JSONType>: MapperTransform<ObjectType, JSONType> {
    
    override func transformFromJSON(value: AnyObject?) -> ObjectType? {
        if let timeInt = value as? Int {
            return (NSDate(timeIntervalSince1970: NSTimeInterval(timeInt)) as ObjectType)
        }
        return nil
    }
    
    override func transformToJSON(value: ObjectType?) -> JSONType? {
        if let date = value as? NSDate {
            return (Int(date.timeIntervalSince1970) as JSONType)
        }
        return nil
    }
}
