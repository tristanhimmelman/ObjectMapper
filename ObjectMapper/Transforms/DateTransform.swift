//
//  DateTransform.swift
//  BaseClient
//
//  Created by Tristan Himmelman on 2014-10-13.
//  Copyright (c) 2014 hearst. All rights reserved.
//

import Foundation

public class DateTransform<ObjectType, JSONType>: MapperTransform<ObjectType, JSONType> {
    
    public override init(){
        
    }
    
    override public func transformFromJSON(value: AnyObject?) -> ObjectType? {
        if let timeInt = value as? Double {
            return (NSDate(timeIntervalSince1970: NSTimeInterval(timeInt)) as ObjectType)
        }
        return nil
    }
    
    override public func transformToJSON(value: ObjectType?) -> JSONType? {
        if let date = value as? NSDate {
            return (Double(date.timeIntervalSince1970) as JSONType)
        }
        return nil
    }
}
