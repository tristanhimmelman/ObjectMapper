//
//  FromJSON.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2014-10-09.
//  Copyright (c) 2014 hearst. All rights reserved.
//

import Foundation

class FromJSON<CollectionType> {
	
	/// Basic type
    func basicType<FieldType>(inout field: FieldType, object: AnyObject?) {
        basicType(&field, object: object as? FieldType)
    }
	
    func basicType<FieldType>(inout field: FieldType, object: FieldType?) {
        if let value = object {
            field = value
        }
    }
	
	/// optional basic type
    func optionalBasicType<FieldType>(inout field: FieldType?, object: AnyObject?) {
		optionalBasicType(&field, object: object as? FieldType)
    }
	
    func optionalBasicType<FieldType>(inout field: FieldType?, object: FieldType?) {
        if let value: FieldType = object {
            field = value
        }
    }
	
	/// Implicitly unwrapped optional basic type
	func optionalBasicType<FieldType>(inout field: FieldType!, object: AnyObject?) {
		optionalBasicType(&field, object: object as? FieldType)
	}
	
	func optionalBasicType<FieldType>(inout field: FieldType!, object: FieldType?) {
		if let value: FieldType = object {
			field = value
		}
	}
	
	/// Mappable object
    func object<N: Mappable>(inout field: N, object: AnyObject?) {
        if let value = object as? [String : AnyObject] {
            field = Mapper().map(value)
        }
    }
	
	/// Optional Mappable Object
    func optionalObject<N: Mappable>(inout field: N?, object: AnyObject?) {
        if let value = object as? [String : AnyObject] {
            field = Mapper().map(value)
        }
    }

	/// Implicitly unwrapped Optional Mappable Object
	func optionalObject<N: Mappable>(inout field: N!, object: AnyObject?) {
		if let value = object as? [String : AnyObject] {
			field = Mapper().map(value)
		}
	}
	
	/// mappable object array
	func objectArray<N: Mappable>(inout field: Array<N>, object: AnyObject?) {
		let parsedObjects = Mapper<N>().mapArray(object)

		if let objects = parsedObjects {
			field = objects
		}
	}

	/// optional mappable object array
	func optionalObjectArray<N: Mappable>(inout field: Array<N>?, object: AnyObject?) {
		field = Mapper<N>().mapArray(object)
	}

	/// Implicitly unwrapped optional mappable object array
	func optionalObjectArray<N: Mappable>(inout field: Array<N>!, object: AnyObject?) {
		field = Mapper<N>().mapArray(object)
	}
	
    /// Dctionary containing Mappable objects
    func objectDictionary<N: Mappable>(inout field: Dictionary<String, N>, object: AnyObject?) {
		let parsedObjects: Dictionary<String, N> = parseObjectDictionary(object)
        
		if !parsedObjects.isEmpty {
            field = parsedObjects
        }
    }


	/// Optional dictionary containing Mappable objects
    func optionalObjectDictionary<N: Mappable>(inout field: Dictionary<String, N>?, object: AnyObject?) {
		let parsedObjects: Dictionary<String, N> = parseObjectDictionary(object)

		if parsedObjects.isEmpty {
			field = nil
		} else {
            field = parsedObjects
		}
    }
	
	/// Implicitly unwrapped Dictionary containing Mappable objects
	func optionalObjectDictionary<N: Mappable>(inout field: Dictionary<String, N>!, object: AnyObject?) {
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
