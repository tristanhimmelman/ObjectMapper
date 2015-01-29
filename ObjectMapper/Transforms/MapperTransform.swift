//
//  MapperTransform.swift
//	ObjectMapper
//
//  Created by Tristan Himmelman on 2014-10-07.
//  Copyright (c) 2014 hearst. All rights reserved.
//

import Foundation

public class MapperTransform<ObjectType, JSONType> {
    
    public init(){
    
    }
    
    public func transformFromJSON(value: AnyObject?) -> ObjectType? {
        return nil
    }
    
    public func transformToJSON(value: ObjectType?) -> JSONType? {
        return nil
    }
}
