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
		optionalBasicType(&field, object: object as? FieldType)
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
    
    func optionalObject<N: Mappable>(inout field: N?, object: AnyObject?) {
        if let value = object as? [String : AnyObject] {
            field = Mapper().map(value)
        }
    }
    
    func objectArray<N: Mappable>(inout field: Array<N>, object: AnyObject?) {
        let parsedObjects: Array<N> = parseObjectArray(object)

		if !parsedObjects.isEmpty {
            field = parsedObjects
        }
    }
    
    func optionalObjectArray<N: Mappable>(inout field: Array<N>?, object: AnyObject?) {
        let parsedObjects: Array<N> = parseObjectArray(object)

		if parsedObjects.isEmpty {
			field = nil
		} else {
			field = parsedObjects
		}
    }
    
    /**
	* Parses a JSON array into an array of Mappable objects
	*/
    private func parseObjectArray<N: Mappable>(object: AnyObject?) -> Array<N>{
		if let JSONArray = object as? [[String : AnyObject]] {
			return Mapper<N>().mapArray(JSONArray)
        }
        
        return []
    }
    
    /** 
	* Parse a dictionary containing Mappable objects
	*/
    func objectDictionary<N: Mappable>(inout field: Dictionary<String, N>, object: AnyObject?) {
		let parsedObjects: Dictionary<String, N> = parseObjectDictionary(object)
        
		if !parsedObjects.isEmpty {
            field = parsedObjects
        }
    }

    /**
	* Parses a dictionary containing Mappable objects to optional field
	*/
    func optionalObjectDictionary<N: Mappable>(inout field: Dictionary<String, N>?, object: AnyObject?) {
		let parsedObjects: Dictionary<String, N> = parseObjectDictionary(object)

		if parsedObjects.isEmpty {
			field = nil
		} else {
            field = parsedObjects
		}
    }
    
    /**
	* Parses a JSON Dictionary of dictionary into a Dictionay of Mappable objects
	*/
    private func parseObjectDictionary<N: Mappable>(object: AnyObject?) -> Dictionary<String, N> {
		if let dictionary = object as? [String : [String : AnyObject]] {
			return Mapper<N>().mapDictionary(dictionary)
        }
        
		return [:]
    }
}
