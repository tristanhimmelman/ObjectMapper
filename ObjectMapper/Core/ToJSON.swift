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

class ToJSON {
	
	func basicType<N>(field: N, key: String, inout dictionary: [String : AnyObject]) {
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
		default:
			//println("Default")
			return
		}
	}

    func optionalBasicType<N>(field: N?, key: String, inout dictionary: [String : AnyObject]) {
        if let field = field {
            basicType(field, key: key, dictionary: &dictionary)
        }
    }
    
	func basicArray(field: Array<AnyObject>, key: String, inout dictionary: [String : AnyObject]) {
		setValue(field, forKey: key, dictionary: &dictionary)
	}

	func optionalBasicArray(field: Array<AnyObject>?, key: String, inout dictionary: [String : AnyObject]) {
		if let value = field {
			basicArray(value, key: key, dictionary: &dictionary)
		}
	}

	func basicDictionary(field: Dictionary<String, AnyObject>, key: String, inout dictionary: [String : AnyObject]) {
		setValue(field, forKey: key, dictionary: &dictionary)
	}

	func optionalBasicDictionary(field: Dictionary<String, AnyObject>?, key: String, inout dictionary: [String : AnyObject]) {
		if let value = field {
			basicDictionary(value, key: key, dictionary: &dictionary)
		}
	}

	func object<N: Mappable>(field: N, key: String, inout dictionary: [String : AnyObject]) {
		setValue(NSDictionary(dictionary: Mapper().toJSON(field)), forKey: key, dictionary: &dictionary)
	}

    func optionalObject<N: Mappable>(field: N?, key: String, inout dictionary: [String : AnyObject]) {
        if let field = field {
            object(field, key: key, dictionary: &dictionary)
        }
    }
    
	func objectArray<N: Mappable>(field: Array<N>, key: String, inout dictionary: [String : AnyObject]) {
		let JSONObjects = Mapper().toJSONArray(field)

		if !JSONObjects.isEmpty {
			setValue(JSONObjects, forKey: key, dictionary: &dictionary)
		}
	}

    func optionalObjectArray<N: Mappable>(field: Array<N>?, key: String, inout dictionary: [String : AnyObject]) {
        if let field = field {
            objectArray(field, key: key, dictionary: &dictionary)
        }
    }
    
	func objectDictionary<N: Mappable>(field: Dictionary<String, N>, key: String, inout dictionary: [String : AnyObject]) {
		let JSONObjects = Mapper().toJSONDictionary(field)

		if !JSONObjects.isEmpty {
			setValue(JSONObjects, forKey: key, dictionary: &dictionary)
		}
	}

    func optionalObjectDictionary<N: Mappable>(field: Dictionary<String, N>?, key: String, inout dictionary: [String : AnyObject]) {
        if let field = field {
            objectDictionary(field, key: key, dictionary: &dictionary)
        }
    }
}
