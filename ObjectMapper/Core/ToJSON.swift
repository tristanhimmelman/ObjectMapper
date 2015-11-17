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
		
		var collection = dictionary as AnyObject
		// because JSONDictionary is a dictionary so root array object won't map properly
		// for now we assume root object is dictionary
		if let newDictionary = setValue(value, forKeyPathComponents: keyComponents, collection: &collection) as? [String: AnyObject] {
			dictionary = newDictionary
		}
	} else {
		dictionary[key] = value
	}
}

/**
Set value for collection

because casted value doesn't work for inout parameters (address changed), so we need to return the collection

- parameter value:      value AnyObject
- parameter components: key components
- parameter collection: Dictionary or Array

- returns: Collection with value set
*/
private func setValue(value: AnyObject, forKeyPathComponents components: ArraySlice<String.CharacterView.SubSequence>, inout collection: AnyObject) -> AnyObject? {
	if components.isEmpty {
		return nil
	}

	let head = components.first!

	if components.count == 1 {
		
		addValue(value, forKey: String(head), toCollection: &collection)
		
	} else {
		
		var child = getValue(forKey: String(head), fromCollection: collection)
		
		let tail = components.dropFirst()
		
		if child == nil {
			
			let firstChildComponentKey = String(tail.first!)
			
			// Check the first child component key, if it's unsigned integer then child is array type
			if UInt(firstChildComponentKey) != nil {
				// empty array
				child = []
			} else {
				// empty dictionary
				child = [:]
			}
		}
		
		child = setValue(value, forKeyPathComponents: tail, collection: &child!)
		
		// add child to collection
		addValue(child!, forKey: String(head), toCollection: &collection)
	}
	
	// return collection value, inout not works for casted type (as Dictionary and Array are structures)
	return collection
}

/**
Get value from Dictionary or Array

- parameter key:		key String
- parameter collection: Dictionary or Array

- returns: child value or nil
*/
private func getValue(forKey key: String, fromCollection collection: AnyObject) -> AnyObject? {
	
	if let dictionary = collection as? [String: AnyObject] {
		
		return dictionary[key]
	} else if let array = collection as? [AnyObject], index = Int(key) {
		
		if array.count > index {
			return array[index]
		}
	}
	
	return nil
}

/**
Add child value key pair to Dictionary or append value to Array

- parameter value:      child value AnyObject
- parameter key:        key String
- parameter collection: Dictionary or Array
*/
private func addValue(value: AnyObject, forKey key: String, inout toCollection collection: AnyObject) {
	
	if var dictionary = collection as? [String: AnyObject] {
		// add key value pair
		dictionary[key] = value
		collection = dictionary
	} else if var array = collection as? [AnyObject] {
		
		if let index = Int(key) where index < array.count {
			array[index] = value
		} else {
			// Here just simple append value to Array
			// could depend on the key(index actually) append some nil values, so the index mapping will be exactlly same with json
			// but I really don't see a usage yet, if we want to post to server we don't care the index, and we don't want to append nil values
			array.append(value)
		}
		collection = array
	}
}

internal final class ToJSON {
	
	class func basicType<N>(field: N, map: Map) {
		func _setValue(value: AnyObject) {
			setValue(value, map: map)
		}

		if let x = field as? NSNumber { // basic types
			_setValue(x)
		} else if let x = field as? Bool {
			_setValue(x)
		} else if let x = field as? Int {
			_setValue(x)
		} else if let x = field as? Double {
			_setValue(x)
		} else if let x = field as? Float {
			_setValue(x)
		} else if let x = field as? String {
			_setValue(x)
		} else if let x = field as? Array<NSNumber> { // Arrays
			_setValue(x)
		} else if let x = field as? Array<Bool> {
			_setValue(x)
		} else if let x = field as? Array<Int> {
			_setValue(x)
		} else if let x = field as? Array<Double> {
			_setValue(x)
		} else if let x = field as? Array<Float> {
			_setValue(x)
		} else if let x = field as? Array<String> {
			_setValue(x)
		} else if let x = field as? Array<AnyObject> {
			_setValue(x)
		} else if let x = field as? Dictionary<String, NSNumber> { // Dictionaries
			_setValue(x)
		} else if let x = field as? Dictionary<String, Bool> {
			_setValue(x)
		} else if let x = field as? Dictionary<String, Int> {
			_setValue(x)
		} else if let x = field as? Dictionary<String, Double> {
			_setValue(x)
		} else if let x = field as? Dictionary<String, Float> {
			_setValue(x)
		} else if let x = field as? Dictionary<String, String> {
			_setValue(x)
		} else if let x = field as? Dictionary<String, AnyObject> {
			_setValue(x)
		} else if let x = field as? AnyObject {
			_setValue(x)
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
	
	class func twoDimensionalObjectArray<N: Mappable>(field: Array<Array<N>>, map: Map) {
		var array = [[[String : AnyObject]]]()
		for innerArray in field {
			let JSONObjects = Mapper().toJSONArray(innerArray)
			array.append(JSONObjects)
		}
		setValue(array, map: map)
	}
	
	class func optionalTwoDimensionalObjectArray<N: Mappable>(field: Array<Array<N>>?, map: Map) {
		if let field = field {
			twoDimensionalObjectArray(field, map: map)
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
