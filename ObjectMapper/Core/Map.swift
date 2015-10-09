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
	
	var JSONDictionary: [String : AnyObject] = [:]
	var currentValue: AnyObject?
	var currentKey: String?
	var keyIsNested = false
	
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
	
	public subscript(key: String, nested nested: Bool) -> Map {
		// save key and value associated to it
		currentKey = key
		keyIsNested = nested
		
		// check if a value exists for the current key
		if nested == false {
			currentValue = JSONDictionary[key]
		} else {
			// break down the components of the key that are separated by .
			currentValue = valueFor(ArraySlice(key.componentsSeparatedByString(".")), dictionary: JSONDictionary)
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
private func valueFor(keyPathComponents: ArraySlice<String>, dictionary: [String : AnyObject]) -> AnyObject? {
	// Implement it as a tail recursive function.
	
	if keyPathComponents.isEmpty {
		return nil
	}
	
	if let object: AnyObject = dictionary[keyPathComponents.first!] {
		if object is NSNull {
			return nil
		} else if let dict = object as? [String : AnyObject] where keyPathComponents.count > 1 {
			let tail = keyPathComponents.dropFirst()
			return valueFor(tail, dictionary: dict)
		} else {
			return object
		}
	}
	
	return nil
}