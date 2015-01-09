//
//  URLTransform.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2014-10-27.
//  Copyright (c) 2014 hearst. All rights reserved.
//

import Foundation

public class URLTransform<ObjectType, JSONType>: MapperTransform<ObjectType, JSONType> {
    
    public override init(){
        
    }
    
    override public func transformFromJSON(value: AnyObject?) -> ObjectType? {
        if let URLString = value as? String {
            return (NSURL(string: URLString) as ObjectType)
        }
        return nil
    }
    
    override public func transformToJSON(value: ObjectType?) -> JSONType? {
        if let URL = value as? NSURL {
            return (URL.absoluteString as JSONType)
        }
        return nil
    }
}
