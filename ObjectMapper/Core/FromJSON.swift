//
//  FromJSON.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2014-10-09.
//  Copyright (c) 2014 hearst. All rights reserved.
//

import Foundation

class FromJSON<CollectionType> {
    
    func basicType<FieldType>(inout field: FieldType, object: AnyObject?) {
        basicType(&field, object: object as? FieldType)
    }
    
    func basicType<FieldType>(inout field: FieldType, object: FieldType?) {
        if let value = object {
            field = value
        }
    }
    
    func optionalBasicType<FieldType>(inout field: FieldType?, object: AnyObject?) {
        if let value: AnyObject = object {
            field = value as? FieldType
        }
    }
    
    func optionalBasicType<FieldType>(inout field: FieldType?, object: FieldType?) {
        if let value: FieldType = object {
            field = value
        }
    }
    
    func object<N: Mappable>(inout field: N, object: AnyObject?) {
        if let value = object as? [String : AnyObject] {
            field = Mapper().map(value)
        }
    }
    
    func object<N: Mappable>(inout field: N?, object: AnyObject?) {
        if let value = object as? [String : AnyObject] {
            field = Mapper().map(value)
        }
    }
    
    func objectArray<N: Mappable>(inout field: Array<N>, object: AnyObject?) {
        var parsedObjects: Array<N> = parseObjectArray(object)
        
        if parsedObjects.count > 0 {
            field = parsedObjects
        }
    }
    
    func optionalObjectArray<N: Mappable>(inout field: Array<N>?, object: AnyObject?) {
        var parsedObjects: Array<N> = parseObjectArray(object)

        if parsedObjects.count > 0 {
            field = parsedObjects
        } else {
            field = nil
        }
    }
    
    // parses a JSON array into an array of objects of type <N: Mappable>
    private func parseObjectArray<N: Mappable>(object: AnyObject?) -> Array<N>{
        let mapper = Mapper<N>()
        
        var parsedObjects = Array<N>()
        
        if let array = object as [AnyObject]? {
            for object in array {
                let objectJSON = object as [String : AnyObject]
                var parsedObj = mapper.map(objectJSON)
                parsedObjects.append(parsedObj)
            }
        }
        
        return parsedObjects
    }
    
    // parse a dictionary containing Mapable objects
    func objectDictionary<N: Mappable>(inout field: Dictionary<String, N>, object: AnyObject?) {
        var parsedObjects: Dictionary<String, N> = parseObjectDictionary(object)
        
        if parsedObjects.count > 0 {
            field = parsedObjects
        }
    }

    // parse a dictionary containing Mapable objects to optional field
    func optionalObjectDictionary<N: Mappable>(inout field: Dictionary<String, N>?, object: AnyObject?) {
        var parsedObjects: Dictionary<String, N> = parseObjectDictionary(object)
        
        if parsedObjects.count > 0 {
            field = parsedObjects
        } else {
            field = nil
        }
    }
    
    // parses a JSON Dictionary into an Dictionay of objects of type <N: Mappable>
    private func parseObjectDictionary<N: Mappable>(object: AnyObject?) -> Dictionary<String, N>{
        let mapper = Mapper<N>()
        
        var parsedObjectsDictionary = Dictionary<String, N>()
        
        if let dictionary = object as Dictionary<String, AnyObject>? {
            for (key, object) in dictionary {
                let objectJSON = object as [String : AnyObject]
                var parsedObj = mapper.map(objectJSON)
                parsedObjectsDictionary[key] = parsedObj
            }
        }
        
        return parsedObjectsDictionary
    }
}
