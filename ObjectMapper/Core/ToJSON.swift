//
//  ToJSON.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2014-10-13.
//  Copyright (c) 2014 hearst. All rights reserved.
//

import UIKit

class ToJSON {
    
    func baseType<N>(field: N, key: String, inout dictionary: [String : AnyObject]) {
        switch N.self {
        case is Bool.Type:
            dictionary[key] = field as Bool
        case is Int.Type:
            dictionary[key] = field as Int
        case is Double.Type:
            dictionary[key] = field as Double
        case is Float.Type:
            dictionary[key] = field as Float
        case is String.Type:
            dictionary[key] = field as String
        default:
            //println("Default")
            return
        }
    }
    
    func optionalBaseType<N>(field: N?, key: String, inout dictionary: [String : AnyObject]) {
        if let field: N = field {
            baseType(field, key: key, dictionary: &dictionary)
        }
    }
    
    func baseArray(field: Array<AnyObject>, key: String, inout dictionary: [String : AnyObject]){
        dictionary[key] = NSArray(array: field)
    }
    
    func optionalBaseArray(field: Array<AnyObject>?, key: String, inout dictionary: [String : AnyObject]){
        if let value = field {
            baseArray(value, key: key, dictionary: &dictionary)
        }
    }
    
    func baseDictionary(field: Dictionary<String, AnyObject>, key: String, inout dictionary: [String : AnyObject]){
        dictionary[key] = NSDictionary(dictionary: field)
    }
    
    func optionalBaseDictionary(field: Dictionary<String, AnyObject>?, key: String, inout dictionary: [String : AnyObject]){
        if let value = field {
            baseDictionary(value, key: key, dictionary: &dictionary)
        }
    }
    
    func object<N: MapperProtocol>(field: N, key: String, inout dictionary: [String : AnyObject]) {
        let mapper = Mapper()
        
        dictionary[key] = NSDictionary(dictionary: mapper.toJSON(field))
    }
    
    func optionalObject<N: MapperProtocol>(field: N?, key: String, inout dictionary: [String : AnyObject]) {
        if let field = field {
            object(field, key: key, dictionary: &dictionary)
        }
    }
    
    func objectArray<N: MapperProtocol>(field: Array<N>, key: String, inout dictionary: [String : AnyObject]) {
        var JSONObjects = NSMutableArray()
        
        for object in field {
            let mapper = Mapper()
            JSONObjects.addObject(mapper.toJSON(object))
        }

        if JSONObjects.count > 0 {
            dictionary[key] = JSONObjects
        }
    }
    
    func optionalObjectArray<N: MapperProtocol>(field: Array<N>?, key: String, inout dictionary: [String : AnyObject]) {
        if let field = field {
            objectArray(field, key: key, dictionary: &dictionary)
        }
    }
    
    func objectDictionary<N: MapperProtocol>(field: Dictionary<String, N>, key: String, inout dictionary: [String : AnyObject]) {
        var JSONObjects = NSMutableDictionary()
        
        for (k, object) in field {
            let mapper = Mapper()
            JSONObjects.setObject(mapper.toJSON(object), forKey: k)

        }
        
        if JSONObjects.count > 0 {
            dictionary[key] = JSONObjects
        }
    }
    
    func optionalObjectDictionary<N: MapperProtocol>(field: Dictionary<String, N>?, key: String, inout dictionary: [String : AnyObject]) {
        if let field = field {
            objectDictionary(field, key: key, dictionary: &dictionary)
        }
    }
}
