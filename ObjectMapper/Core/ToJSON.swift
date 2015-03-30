//
//  ToJSON.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2014-10-13.
//  Copyright (c) 2014 hearst. All rights reserved.
//

import Foundation

private func setValue(value: AnyObject, forKey key: String, inout #dictionary: [String : AnyObject]) {
	return setValue(value, forKeyPathComponents: key.componentsSeparatedByString("."), dictionary: &dictionary)
}

private func setValue(value: AnyObject, forKeyPathComponents components: [String], inout #dictionary: [String : AnyObject]) {
	if components.isEmpty {
		return
	}

	let head = components.first!

	if components.count == 1 {
		return dictionary[head] = value
	} else {
		var child = (dictionary[head] as? [String : AnyObject]) ?? [:]

		let tail = Array(components[1..<components.count])
		setValue(value, forKeyPathComponents: tail, dictionary: &child)

		return dictionary[head] = child
	}
}

internal final class ToJSON {
	
	class func basicType<N>(field: N, key: String, inout dictionary: [String : AnyObject]) {
		switch field {
		// basic Types
		case let x as NSNumber:
			setValue(x, forKey: key, dictionary: &dictionary)
		case let x as Bool:
			setValue(x, forKey: key, dictionary: &dictionary)
		case let x as Int:
			setValue(x, forKey: key, dictionary: &dictionary)
		case let x as Double:
			setValue(x, forKey: key, dictionary: &dictionary)
		case let x as Float:
			setValue(x, forKey: key, dictionary: &dictionary)
		case let x as String:
			setValue(x, forKey: key, dictionary: &dictionary)

		// Arrays with basic types
		case let x as Array<NSNumber>:
			setValue(x, forKey: key, dictionary: &dictionary)
		case let x as Array<Bool>:
			setValue(x, forKey: key, dictionary: &dictionary)
		case let x as Array<Int>:
			setValue(x, forKey: key, dictionary: &dictionary)
		case let x as Array<Double>:
			setValue(x, forKey: key, dictionary: &dictionary)
		case let x as Array<Float>:
			setValue(x, forKey: key, dictionary: &dictionary)
		case let x as Array<String>:
			setValue(x, forKey: key, dictionary: &dictionary)
		case let x as Array<AnyObject>:
			setValue(x, forKey: key, dictionary: &dictionary)

		// Dictionaries with basic types
		case let x as Dictionary<String, NSNumber>:
			setValue(x, forKey: key, dictionary: &dictionary)
		case let x as Dictionary<String, Bool>:
			setValue(x, forKey: key, dictionary: &dictionary)
		case let x as Dictionary<String, Int>:
			setValue(x, forKey: key, dictionary: &dictionary)
		case let x as Dictionary<String, Double>:
			setValue(x, forKey: key, dictionary: &dictionary)
		case let x as Dictionary<String, Float>:
			setValue(x, forKey: key, dictionary: &dictionary)
		case let x as Dictionary<String, String>:
			setValue(x, forKey: key, dictionary: &dictionary)
		case let x as Dictionary<String, AnyObject>:
			setValue(x, forKey: key, dictionary: &dictionary)
		default:
			//println("Default")
			return
		}
	}

    class func optionalBasicType<N>(field: N?, key: String, inout dictionary: [String : AnyObject]) {
        if let field = field {
            basicType(field, key: key, dictionary: &dictionary)
        }
    }
    
	class func object<N: Mappable>(field: N, key: String, inout dictionary: [String : AnyObject]) {
		setValue(Mapper().toJSON(field), forKey: key, dictionary: &dictionary)
	}

    class func optionalObject<N: Mappable>(field: N?, key: String, inout dictionary: [String : AnyObject]) {
        if let field = field {
            object(field, key: key, dictionary: &dictionary)
        }
    }
    
	class func objectArray<N: Mappable>(field: Array<N>, key: String, inout dictionary: [String : AnyObject]) {
		let JSONObjects = Mapper().toJSONArray(field)

		if !JSONObjects.isEmpty {
			setValue(JSONObjects, forKey: key, dictionary: &dictionary)
		}
	}

    class func optionalObjectArray<N: Mappable>(field: Array<N>?, key: String, inout dictionary: [String : AnyObject]) {
        if let field = field {
            objectArray(field, key: key, dictionary: &dictionary)
        }
    }
    
	class func objectDictionary<N: Mappable>(field: Dictionary<String, N>, key: String, inout dictionary: [String : AnyObject]) {
		let JSONObjects = Mapper().toJSONDictionary(field)

		if !JSONObjects.isEmpty {
			setValue(JSONObjects, forKey: key, dictionary: &dictionary)
		}
	}

    class func optionalObjectDictionary<N: Mappable>(field: Dictionary<String, N>?, key: String, inout dictionary: [String : AnyObject]) {
        if let field = field {
            objectDictionary(field, key: key, dictionary: &dictionary)
        }
    }
}
