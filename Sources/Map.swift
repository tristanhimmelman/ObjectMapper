//
//  Map.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2015-10-09.
//
//  The MIT License (MIT)
//
//  Copyright (c) 2014-2016 Hearst
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


import Foundation

/// MapContext is available for developers who wish to pass information around during the mapping process.
public protocol MapContext {
	
}

/// A class used for holding mapping data
public final class Map {
	public let mappingType: MappingType
	
	public internal(set) var JSON: [String: Any] = [:]
	public internal(set) var isKeyPresent = false
	public internal(set) var currentValue: Any?
	public internal(set) var currentKey: String?
	var keyIsNested = false
	public internal(set) var nestedKeyDelimiter: String = "."
	public var context: MapContext?
	
	let toObject: Bool // indicates whether the mapping is being applied to an existing object
	
	public init(mappingType: MappingType, JSON: [String: Any], toObject: Bool = false, context: MapContext? = nil) {
		self.mappingType = mappingType
		self.JSON = JSON
		self.toObject = toObject
		self.context = context
	}
	
	/// Sets the current mapper value and key.
	/// The Key paramater can be a period separated string (ex. "distance.value") to access sub objects.
	public subscript(key: String) -> Map {
		// save key and value associated to it
		return self[key, delimiter: ".", ignoreNil: false]
	}
	public subscript(key: String, delimiter delimiter: String) -> Map {
		let nested = key.contains(delimiter)
		return self[key, nested: nested, delimiter: delimiter, ignoreNil: false]
	}

	public subscript(key: String, nested nested: Bool) -> Map {
	    return self[key, nested: nested, delimiter: ".", ignoreNil: false]
	}
	public subscript(key: String, nested nested: Bool, delimiter delimiter: String) -> Map {
	    return self[key, nested: nested, delimiter: delimiter, ignoreNil: false]
	}

		public subscript(key: String, ignoreNil ignoreNil: Bool) -> Map {
			return self[key, delimiter: ".", ignoreNil: ignoreNil]
		}
    public subscript(key: String, delimiter delimiter: String, ignoreNil ignoreNil: Bool) -> Map {
        let nested = key.contains(delimiter)
        return self[key, nested: nested, delimiter: delimiter, ignoreNil: ignoreNil]
    }

		public subscript(key: String, nested nested: Bool, ignoreNil ignoreNil: Bool) -> Map {
			return self[key, nested: nested, delimiter: ".", ignoreNil: ignoreNil]
		}
    public subscript(key: String, nested nested: Bool, delimiter delimiter: String, ignoreNil ignoreNil: Bool) -> Map {
		// save key and value associated to it
		currentKey = key
		keyIsNested = nested
		nestedKeyDelimiter = delimiter

		// check if a value exists for the current key 
		// do this pre-check for performance reasons
		if nested == false {
			let object = JSON[key]
			let isNSNull = object is NSNull
			isKeyPresent = isNSNull ? true : object != nil
			currentValue = isNSNull ? nil : object
		} else {
			// break down the components of the key that are separated by .
			(isKeyPresent, currentValue) = valueFor(ArraySlice(key.components(separatedBy: delimiter)), dictionary: JSON)
		}
		
		// update isKeyPresent if ignoreNil is true
        if ignoreNil && currentValue == nil {
            isKeyPresent = false
        }
		
		return self
	}
	
	public func value<T>() -> T? {
		return currentValue as? T
	}

}

/// Fetch value from JSON dictionary, loop through keyPathComponents until we reach the desired object
private func valueFor(_ keyPathComponents: ArraySlice<String>, dictionary: [String: Any]) -> (Bool, Any?) {
	// Implement it as a tail recursive function.
	if keyPathComponents.isEmpty {
		return (false, nil)
	}
	
	if let keyPath = keyPathComponents.first {
		let object = dictionary[keyPath]
		if object is NSNull {
			return (true, nil)
		} else if let dict = object as? [String: Any] , keyPathComponents.count > 1 {
			let tail = keyPathComponents.dropFirst()
			return valueFor(tail, dictionary: dict)
		} else if let array = object as? [Any] , keyPathComponents.count > 1 {
			let tail = keyPathComponents.dropFirst()
			return valueFor(tail, array: array)
		} else {
			return (object != nil, object)
		}
	}
	
	return (false, nil)
}

/// Fetch value from JSON Array, loop through keyPathComponents them until we reach the desired object
private func valueFor(_ keyPathComponents: ArraySlice<String>, array: [Any]) -> (Bool, Any?) {
	// Implement it as a tail recursive function.
	
	if keyPathComponents.isEmpty {
		return (false, nil)
	}
	
	//Try to convert keypath to Int as index
	if let keyPath = keyPathComponents.first,
		let index = Int(keyPath) , index >= 0 && index < array.count {
			
			let object = array[index]
			
			if object is NSNull {
				return (true, nil)
			} else if let array = object as? [Any] , keyPathComponents.count > 1 {
				let tail = keyPathComponents.dropFirst()
				return valueFor(tail, array: array)
			} else if let dict = object as? [String: Any] , keyPathComponents.count > 1 {
				let tail = keyPathComponents.dropFirst()
				return valueFor(tail, dictionary: dict)
			} else {
				return (true, object)
			}
	}
	
	return (false, nil)
}
