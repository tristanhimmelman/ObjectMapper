//
//  Map.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2015-10-09.
//  Copyright © 2015 hearst. All rights reserved.
//

import Foundation

/// A class used for holding mapping data
public final class Map {
	public let mappingType: MappingType
	
	// TODO: change this type to CollectionType, so we can map root array object
	var JSONDictionary: [String : AnyObject] = [:]
	var currentValue: AnyObject?
	var currentKey: String?
	var keyIsNested = false
	// use this to mark is a required field to verify server response
	var isRequiredField = false
	
	/// Counter for failing cases of deserializing values to `let` properties.
	private var failedCount: Int = 0
	
	public init(mappingType: MappingType, JSONDictionary: [String : AnyObject]) {
		self.mappingType = mappingType
		self.JSONDictionary = JSONDictionary
	}
	
	/// Sets the current mapper value and key.
	/// The Key paramater can be a period separated string (ex. "distance.value") to access sub objects.
	public subscript(key: String) -> Map {
		// save key and value associated to it
		return self[key, nested: true]
	}
	
	/// Mark property is a required field
	public subscript(key: String, required isRequired: Bool) -> Map {
		
		isRequiredField = isRequired
		let map = self[key, nested: true]
		
		// when is required, only verify server response for now
		// could be useful for POST as well, ehnnn....
		if isRequiredField && mappingType == MappingType.FromJSON {
			// FIXME: somehow this doesn't work in unit test, so only ui test will trigger this which sucks
			assert(currentValue != nil, "\(key) is a required field, should not be nil")
		}
		
		return map
	}
	
	public subscript(key: String, nested nested: Bool) -> Map {
		// save key and value associated to it
		currentKey = key
		keyIsNested = nested
		
		// check if a value exists for the current key
		if nested == false {
			currentValue = JSONDictionary[key]
		} else {
			// break down the components of the key that are separated by .
			currentValue = valueFor(ArraySlice(key.componentsSeparatedByString(".")), collection: JSONDictionary)
		}
		
		return self
	}
	
	// MARK: Immutable Mapping
	
	public func value<T>() -> T? {
		return currentValue as? T
	}
	
	public func valueOr<T>(@autoclosure defaultValue: () -> T) -> T {
		return value() ?? defaultValue()
	}
	
	/// Returns current JSON value of type `T` if it is existing, or returns a
	/// unusable proxy value for `T` and collects failed count.
	public func valueOrFail<T>() -> T {
		if let value: T = value() {
			return value
		} else {
			// Collects failed count
			failedCount++
			
			// Returns dummy memory as a proxy for type `T`
			let pointer = UnsafeMutablePointer<T>.alloc(0)
			pointer.dealloc(0)
			return pointer.memory
		}
	}
	
	/// Returns whether the receiver is success or failure.
	public var isValid: Bool {
		return failedCount == 0
	}
}

/// Fetch value from JSON dictionary, loop through them until we reach the desired object.
private func valueFor(keyPathComponents: ArraySlice<String>, collection: AnyObject?) -> AnyObject? {
	// Implement it as a tail recursive function.
	
	if keyPathComponents.isEmpty {
		return nil
	}
	
	//optional object to keep optional retreived from collection
	var optionalObject: AnyObject?
	
	//check if collection is dictionary or array (if it's array, also try to convert keypath to Int as index)
	if let dictionary = collection as? [String : AnyObject] {
		//keep retreved optional
		optionalObject = dictionary[keyPathComponents.first!]
	} else if let array = collection as? [AnyObject], index = Int(String(keyPathComponents.first!)) {
		// ignore index out of range
		if array.count > index {
			optionalObject = array[index]
		}
	}
	
	if let object: AnyObject = optionalObject {
		if object is NSNull {
			return nil
		} else if let dict = object as? [String : AnyObject] where keyPathComponents.count > 1 {
			let tail = keyPathComponents.dropFirst()
			return valueFor(tail, collection: dict)
		} else if let array = object as? [AnyObject] where keyPathComponents.count > 1 {
			let tail = keyPathComponents.dropFirst()
			return valueFor(tail, collection: array)
		} else {
			return object
		}
	}
	
	return nil
}