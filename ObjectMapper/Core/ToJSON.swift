//
//  ToJSON.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2014-10-13.
//  Copyright (c) 2014 hearst. All rights reserved.
//

import Foundation

class ToJSON {
	
    func baseType<N>(field: N, key: String, inout dictionary: [String : AnyObject]) {
		
		var temp = dictionary
		var currentKey = key

        switch field {
        // basic Types
        case let x as Bool:
            dictionary[currentKey] = x
        case let x as Int:
            dictionary[currentKey] = x
        case let x as Double:
            dictionary[currentKey] = x
        case let x as Float:
            dictionary[currentKey] = x
        case let x as String:
            dictionary[currentKey] = x

        // Arrays with basic types
        case let x as Array<Bool>:
            dictionary[currentKey] = x
        case let x as Array<Int>:
            dictionary[currentKey] = x
        case let x as Array<Double>:
            dictionary[currentKey] = x
        case let x as Array<Float>:
            dictionary[currentKey] = x
        case let x as Array<String>:
            dictionary[currentKey] = x
			
        // Dictionaries with basic types
        case let x as Dictionary<String, Bool>:
            dictionary[currentKey] = x
        case let x as Dictionary<String, Int>:
            dictionary[currentKey] = x
        case let x as Dictionary<String, Double>:
            dictionary[currentKey] = x
        case let x as Dictionary<String, Float>:
            dictionary[currentKey] = x
        case let x as Dictionary<String, String>:
            dictionary[currentKey] = x
        default:
            //println("Default")
            return
        }
    }
    
    func optionalBaseType<N>(field: N?, key: String, inout dictionary: [String : AnyObject]) {
        if let field = field {
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
    
    func object<N: Mappable>(field: N, key: String, inout dictionary: [String : AnyObject]) {
        let mapper = Mapper<N>()
        
        dictionary[key] = NSDictionary(dictionary: mapper.toJSON(field))
    }
    
    func optionalObject<N: Mappable>(field: N?, key: String, inout dictionary: [String : AnyObject]) {
        if let field = field {
            object(field, key: key, dictionary: &dictionary)
        }
    }
    
    func objectArray<N: Mappable>(field: Array<N>, key: String, inout dictionary: [String : AnyObject]) {
        var JSONObjects = NSMutableArray()
        
        for object in field {
            let mapper = Mapper<N>()
            JSONObjects.addObject(mapper.toJSON(object))
        }

        if JSONObjects.count > 0 {
            dictionary[key] = JSONObjects
        }
    }
    
    func optionalObjectArray<N: Mappable>(field: Array<N>?, key: String, inout dictionary: [String : AnyObject]) {
        if let field = field {
            objectArray(field, key: key, dictionary: &dictionary)
        }
    }
    
    func objectDictionary<N: Mappable>(field: Dictionary<String, N>, key: String, inout dictionary: [String : AnyObject]) {
        var JSONObjects = NSMutableDictionary()
        
        for (k, object) in field {
            let mapper = Mapper<N>()
            JSONObjects.setObject(mapper.toJSON(object), forKey: k)

        }
        
        if JSONObjects.count > 0 {
            dictionary[key] = JSONObjects
        }
    }
    
    func optionalObjectDictionary<N: Mappable>(field: Dictionary<String, N>?, key: String, inout dictionary: [String : AnyObject]) {
        if let field = field {
            objectDictionary(field, key: key, dictionary: &dictionary)
        }
    }
}
