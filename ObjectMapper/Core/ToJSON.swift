//
//  ToJSON.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2014-10-13.
//
//  The MIT License (MIT)
//
//  Copyright (c) 2014-2015 Hearst
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

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
		} else if let x = field as? Array<Dictionary<String, AnyObject>> {
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
