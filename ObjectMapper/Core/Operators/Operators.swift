//
//  Operators.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2014-10-09.
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

/**
* This file defines a new operator which is used to create a mapping between an object and a JSON key value.
* There is an overloaded operator definition for each type of object that is supported in ObjectMapper.
* This provides a way to add custom logic to handle specific types of objects
*/

/// Operator used for defining mappings to and from JSON
infix operator <-

/// Operator used to define mappings to JSON
infix operator >>> 

// MARK:- Objects with Basic types

/// Object of Basic type
public func <- <T>(left: inout T, right: Map) {
	switch right.mappingType {
	case .fromJSON where right.isKeyPresent:
		FromJSON.basicType(&left, object: right.value())
	case .toJSON:
		left >>> right
	default: ()
	}
}

public func >>> <T>(left: T, right: Map) {
	if right.mappingType == .toJSON {
		ToJSON.basicType(left, map: right)
	}
}


/// Optional object of basic type
public func <- <T>(left: inout T?, right: Map) {
	switch right.mappingType {
	case .fromJSON where right.isKeyPresent:
		FromJSON.optionalBasicType(&left, object: right.value())
	case .toJSON:
		left >>> right
	default: ()
	}
}

public func >>> <T>(left: T?, right: Map) {
	if right.mappingType == .toJSON {
		ToJSON.optionalBasicType(left, map: right)
	}
}


/// Implicitly unwrapped optional object of basic type
public func <- <T>(left: inout T!, right: Map) {
	switch right.mappingType {
	case .fromJSON where right.isKeyPresent:
		FromJSON.optionalBasicType(&left, object: right.value())
	case .toJSON:
		left >>> right
	default: ()
	}
}

// MARK:- Mappable Objects - <T: BaseMappable>

/// Object conforming to Mappable
public func <- <T: BaseMappable>(left: inout T, right: Map) {
	switch right.mappingType {
	case .fromJSON:
		FromJSON.object(&left, map: right)
	case .toJSON:
		left >>> right
	}
}

public func >>> <T: BaseMappable>(left: T, right: Map) {
	if right.mappingType == .toJSON {
		ToJSON.object(left, map: right)
	}
}


/// Optional Mappable objects
public func <- <T: BaseMappable>(left: inout T?, right: Map) {
	switch right.mappingType {
	case .fromJSON where right.isKeyPresent:
		FromJSON.optionalObject(&left, map: right)
	case .toJSON:
		left >>> right
	default: ()
	}
}

public func >>> <T: BaseMappable>(left: T?, right: Map) {
	if right.mappingType == .toJSON {
		ToJSON.optionalObject(left, map: right)
	}
}


/// Implicitly unwrapped optional Mappable objects
public func <- <T: BaseMappable>(left: inout T!, right: Map) {
	switch right.mappingType {
	case .fromJSON where right.isKeyPresent:
		FromJSON.optionalObject(&left, map: right)
	case .toJSON:
		left >>> right
	default: ()
	}
}

// MARK:- Dictionary of Mappable objects - Dictionary<String, T: BaseMappable>

/// Dictionary of Mappable objects <String, T: Mappable>
public func <- <T: BaseMappable>(left: inout Dictionary<String, T>, right: Map) {
	switch right.mappingType {
	case .fromJSON where right.isKeyPresent:
		FromJSON.objectDictionary(&left, map: right)
	case .toJSON:
		left >>> right
	default: ()
	}
}

public func >>> <T: BaseMappable>(left: Dictionary<String, T>, right: Map) {
	if right.mappingType == .toJSON {
		ToJSON.objectDictionary(left, map: right)
	}
}


/// Optional Dictionary of Mappable object <String, T: Mappable>
public func <- <T: BaseMappable>(left: inout Dictionary<String, T>?, right: Map) {
	switch right.mappingType {
	case .fromJSON where right.isKeyPresent:
		FromJSON.optionalObjectDictionary(&left, map: right)
	case .toJSON:
		left >>> right
	default: ()
	}
}

public func >>> <T: BaseMappable>(left: Dictionary<String, T>?, right: Map) {
	if right.mappingType == .toJSON {
		ToJSON.optionalObjectDictionary(left, map: right)
	}
}


/// Implicitly unwrapped Optional Dictionary of Mappable object <String, T: Mappable>
public func <- <T: BaseMappable>(left: inout Dictionary<String, T>!, right: Map) {
	switch right.mappingType {
	case .fromJSON where right.isKeyPresent:
		FromJSON.optionalObjectDictionary(&left, map: right)
	case .toJSON:
		left >>> right
	default: ()
	}
}

/// Dictionary of Mappable objects <String, T: Mappable>
public func <- <T: BaseMappable>(left: inout Dictionary<String, [T]>, right: Map) {
	switch right.mappingType {
	case .fromJSON where right.isKeyPresent:
		FromJSON.objectDictionaryOfArrays(&left, map: right)
	case .toJSON:
		left >>> right
	default: ()
	}
}

public func >>> <T: BaseMappable>(left: Dictionary<String, [T]>, right: Map) {
	if right.mappingType == .toJSON {
		ToJSON.objectDictionaryOfArrays(left, map: right)
	}
}

/// Optional Dictionary of Mappable object <String, T: Mappable>
public func <- <T: BaseMappable>(left: inout Dictionary<String, [T]>?, right: Map) {
	switch right.mappingType {
	case .fromJSON where right.isKeyPresent:
		FromJSON.optionalObjectDictionaryOfArrays(&left, map: right)
	case .toJSON:
		left >>> right
	default: ()
	}
}

public func >>> <T: BaseMappable>(left: Dictionary<String, [T]>?, right: Map) {
	if right.mappingType == .toJSON {
		ToJSON.optionalObjectDictionaryOfArrays(left, map: right)
	}
}


/// Implicitly unwrapped Optional Dictionary of Mappable object <String, T: Mappable>
public func <- <T: BaseMappable>(left: inout Dictionary<String, [T]>!, right: Map) {
	switch right.mappingType {
	case .fromJSON where right.isKeyPresent:
		FromJSON.optionalObjectDictionaryOfArrays(&left, map: right)
	case .toJSON:
		left >>> right
	default: ()
	}
}

// MARK:- Array of Mappable objects - Array<T: BaseMappable>

/// Array of Mappable objects
public func <- <T: BaseMappable>(left: inout Array<T>, right: Map) {
	switch right.mappingType {
	case .fromJSON where right.isKeyPresent:
		FromJSON.objectArray(&left, map: right)
	case .toJSON:
		left >>> right
	default: ()
	}
}

public func >>> <T: BaseMappable>(left: Array<T>, right: Map) {
	if right.mappingType == .toJSON {
		ToJSON.objectArray(left, map: right)
	}
}

/// Optional array of Mappable objects
public func <- <T: BaseMappable>(left: inout Array<T>?, right: Map) {
	switch right.mappingType {
	case .fromJSON where right.isKeyPresent:
		FromJSON.optionalObjectArray(&left, map: right)
	case .toJSON:
		left >>> right
	default: ()
	}
}

public func >>> <T: BaseMappable>(left: Array<T>?, right: Map) {
	if right.mappingType == .toJSON {
		ToJSON.optionalObjectArray(left, map: right)
	}
}


/// Implicitly unwrapped Optional array of Mappable objects
public func <- <T: BaseMappable>(left: inout Array<T>!, right: Map) {
	switch right.mappingType {
	case .fromJSON where right.isKeyPresent:
		FromJSON.optionalObjectArray(&left, map: right)
	case .toJSON:
		left >>> right
	default: ()
	}
}

// MARK:- Array of Array of Mappable objects - Array<Array<T: BaseMappable>>

/// Array of Array Mappable objects
public func <- <T: BaseMappable>(left: inout Array<Array<T>>, right: Map) {
	switch right.mappingType {
	case .fromJSON where right.isKeyPresent:
		FromJSON.twoDimensionalObjectArray(&left, map: right)
	case .toJSON:
		left >>> right
	default: ()
	}
}

public func >>> <T: BaseMappable>(left: Array<Array<T>>, right: Map) {
	if right.mappingType == .toJSON {
		ToJSON.twoDimensionalObjectArray(left, map: right)
	}
}


/// Optional array of Mappable objects
public func <- <T: BaseMappable>(left:inout Array<Array<T>>?, right: Map) {
	switch right.mappingType {
	case .fromJSON where right.isKeyPresent:
		FromJSON.optionalTwoDimensionalObjectArray(&left, map: right)
	case .toJSON:
		left >>> right
	default: ()
	}
}

public func >>> <T: BaseMappable>(left: Array<Array<T>>?, right: Map) {
	if right.mappingType == .toJSON {
		ToJSON.optionalTwoDimensionalObjectArray(left, map: right)
	}
}


/// Implicitly unwrapped Optional array of Mappable objects
public func <- <T: BaseMappable>(left: inout Array<Array<T>>!, right: Map) {
	switch right.mappingType {
	case .fromJSON where right.isKeyPresent:
		FromJSON.optionalTwoDimensionalObjectArray(&left, map: right)
	case .toJSON:
		left >>> right
	default: ()
	}
}

// MARK:- Set of Mappable objects - Set<T: BaseMappable where T: Hashable>

/// Set of Mappable objects
public func <- <T: BaseMappable>(left: inout Set<T>, right: Map) where T: Hashable {
	switch right.mappingType {
	case .fromJSON where right.isKeyPresent:
		FromJSON.objectSet(&left, map: right)
	case .toJSON:
		left >>> right
	default: ()
	}
}

public func >>> <T: BaseMappable>(left: Set<T>, right: Map) where T: Hashable {
	if right.mappingType == .toJSON {
		ToJSON.objectSet(left, map: right)
	}
}


/// Optional Set of Mappable objects
public func <- <T: BaseMappable>(left: inout Set<T>?, right: Map) where T: Hashable, T: Hashable {
	switch right.mappingType {
	case .fromJSON where right.isKeyPresent:
		FromJSON.optionalObjectSet(&left, map: right)
	case .toJSON:
		left >>> right
	default: ()
	}
}

public func >>> <T: BaseMappable>(left: Set<T>?, right: Map) where T: Hashable, T: Hashable {
	if right.mappingType == .toJSON {
		ToJSON.optionalObjectSet(left, map: right)
	}
}


/// Implicitly unwrapped Optional Set of Mappable objects
public func <- <T: BaseMappable>(left: inout Set<T>!, right: Map) where T: Hashable {
	switch right.mappingType {
	case .fromJSON where right.isKeyPresent:
		FromJSON.optionalObjectSet(&left, map: right)
	case .toJSON:
		left >>> right
	default: ()
	}
}
