//
//  ToJSON.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2014-10-13.
//  Copyright (c) 2014 hearst. All rights reserved.
//

import class Foundation.NSNumber

private func setValue(value: AnyObject, map: Map) {
	setValue(value, key: map.currentKey!, checkForNestedKeys: map.keyIsNested, dictionary: &map.JSONDictionary)
}

private func setValue(value: AnyObject, key: String, checkForNestedKeys: Bool, inout dictionary: [String : AnyObject]) {
	if checkForNestedKeys {
		let keyComponents = ArraySlice(key.characters.split { $0 == "." })
		setValue(value, forKeyPathComponents: keyComponents, dictionary: &dictionary)
	} else {
		dictionary[key] = value
	}
}

private func setValue(value: AnyObject, forKeyPathComponents components: ArraySlice<String.CharacterView.SubSequence>, inout dictionary: [String : AnyObject]) {
	if components.isEmpty {
		return
	}

	let head = components.first!

	if components.count == 1 {
		dictionary[String(head)] = value
	} else {
		var child = dictionary[String(head)] as? [String : AnyObject]
		if child == nil {
			child = [:]
		}

		let tail = components.dropFirst()
		setValue(value, forKeyPathComponents: tail, dictionary: &child!)

		dictionary[String(head)] = child
	}
}

internal final class ToJSON {
	
	class func basicType<N>(field: N, map: Map) {
		func _setValue(value: AnyObject) {
			setValue(value, map: map)
		}

		switch field {
		// basic Types
		case let x as NSNumber:
			_setValue(x)
		case let x as Bool:
			_setValue(x)
		case let x as Int:
			_setValue(x)
		case let x as Double:
			_setValue(x)
		case let x as Float:
			_setValue(x)
		case let x as String:
			_setValue(x)

		// Arrays with basic types
		case let x as Array<NSNumber>:
			_setValue(x)
		case let x as Array<Bool>:
			_setValue(x)
		case let x as Array<Int>:
			_setValue(x)
		case let x as Array<Double>:
			_setValue(x)
		case let x as Array<Float>:
			_setValue(x)
		case let x as Array<String>:
			_setValue(x)
		case let x as Array<AnyObject>:
			_setValue(x)

		// Dictionaries with basic types
		case let x as Dictionary<String, NSNumber>:
			_setValue(x)
		case let x as Dictionary<String, Bool>:
			_setValue(x)
		case let x as Dictionary<String, Int>:
			_setValue(x)
		case let x as Dictionary<String, Double>:
			_setValue(x)
		case let x as Dictionary<String, Float>:
			_setValue(x)
		case let x as Dictionary<String, String>:
			_setValue(x)
		case let x as Dictionary<String, AnyObject>:
			_setValue(x)
		default:
			//print("Default")
			return
		}
	}

	class func optionalBasicType<N>(field: N?, map: Map) {
		if let field = field {
			basicType(field, map: map)
		}
	}

	class func object<N: Mappable>(field: N, map: Map) {
		setValue(Mapper().toJSON(field), map: map)
	}
	
	class func optionalObject<N: Mappable>(field: N?, map: Map) {
		if let field = field {
			object(field, map: map)
		}
	}

	class func objectArray<N: Mappable>(field: Array<N>, map: Map) {
		let JSONObjects = Mapper().toJSONArray(field)
		
		setValue(JSONObjects, map: map)
	}
	
	class func optionalObjectArray<N: Mappable>(field: Array<N>?, map: Map) {
		if let field = field {
			objectArray(field, map: map)
		}
	}
	
	class func objectSet<N: Mappable where N: Hashable>(field: Set<N>, map: Map) {
		let JSONObjects = Mapper().toJSONSet(field)
		
		setValue(JSONObjects, map: map)
	}
	
	class func optionalObjectSet<N: Mappable where N: Hashable>(field: Set<N>?, map: Map) {
		if let field = field {
			objectSet(field, map: map)
		}
	}
	
	class func objectDictionary<N: Mappable>(field: Dictionary<String, N>, map: Map) {
		let JSONObjects = Mapper().toJSONDictionary(field)
		
		setValue(JSONObjects, map: map)
	}
	
	class func optionalObjectDictionary<N: Mappable>(field: Dictionary<String, N>?, map: Map) {
        if let field = field {
			objectDictionary(field, map: map)
        }
    }
	
	class func objectDictionaryOfArrays<N: Mappable>(field: Dictionary<String, [N]>, map: Map) {
		let JSONObjects = Mapper().toJSONDictionaryOfArrays(field)

		setValue(JSONObjects, map: map)
	}
	
	class func optionalObjectDictionaryOfArrays<N: Mappable>(field: Dictionary<String, [N]>?, map: Map) {
		if let field = field {
			objectDictionaryOfArrays(field, map: map)
		}
	}
}
