//
//  MapperTransform.swift
//  BaseClient
//
//  Created by Tristan Himmelman on 2014-10-07.
//  Copyright (c) 2014 hearst. All rights reserved.
//

import Foundation

class MapperTransform<ObjectType, JSONType> {
    
    func transformFromJSON(value: AnyObject?) -> ObjectType? {
        return nil
    }
    
    func transformToJSON(value: ObjectType?) -> JSONType? {
        return nil
    }
}
