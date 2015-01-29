//
//  Operators.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2014-10-09.
//  Copyright (c) 2014 hearst. All rights reserved.
//

import Foundation

// The operator definition is commented out because it was causing "ambiguous operator" errors when linking to the framework
// This seems like a bug in xcode will likely be fixed
//infix operator <= {}

// MARK: basic type
public func <=<T, U>(inout left: T, right: Mapper<U>) {
    if right.mappingType == MappingType.fromJSON {
        FromJSON<T>().basicType(&left, object: right.currentValue)
    } else {
        ToJSON().basicType(left, key: right.currentKey!, dictionary: &right.JSONDictionary);
    }
}

// Optional basic type
public func <=<T, U>(inout left: T?, right: Mapper<U>) {
    if right.mappingType == MappingType.fromJSON {
        FromJSON<T>().optionalBasicType(&left, object: right.currentValue)
    } else {
        ToJSON().optionalBasicType(left, key: right.currentKey!, dictionary: &right.JSONDictionary)
    }
}

// Basic type with Transform
public func <=<T, U, N>(inout left: T, right: (Mapper<U>, MapperTransform<T, N>)) {
    if right.0.mappingType == MappingType.fromJSON {
        var value: T? = right.1.transformFromJSON(right.0.currentValue)
        //println("FromJSON \(value)");
        FromJSON<T>().basicType(&left, object: value)
    } else {
        var value: N? = right.1.transformToJSON(left)
        //println("\(left) toJSON \(value)")
        ToJSON().optionalBasicType(value, key: right.0.currentKey!, dictionary: &right.0.JSONDictionary)
    }
}

// Optional basic type with Transform
public func <=<T, U, N>(inout left: T?, right: (Mapper<U>, MapperTransform<T, N>)) {
    if right.0.mappingType == MappingType.fromJSON {
        var value: T? = right.1.transformFromJSON(right.0.currentValue)
        //println("FromJSON \(value)");
        FromJSON<T>().optionalBasicType(&left, object: value)
    } else {
        var value: N? = right.1.transformToJSON(left)
        //println("\(left) toJSON \(value)")
        ToJSON().optionalBasicType(value, key: right.0.currentKey!, dictionary: &right.0.JSONDictionary)
    }
}

// MARK:- T: Mappable
public func <=<T: Mappable, U>(inout left: T, right: Mapper<U>) {
    if right.mappingType == MappingType.fromJSON {
        FromJSON<T>().object(&left, object: right.currentValue)
    } else {
        ToJSON().object(left, key: right.currentKey!, dictionary: &right.JSONDictionary)
    }
}

// Optional object conforming to Mappable
public func <=<T: Mappable, U>(inout left: T?, right: Mapper<U>) {
    if right.mappingType == MappingType.fromJSON {
        FromJSON<T>().object(&left, object: right.currentValue)
    } else {
        ToJSON().optionalObject(left, key: right.currentKey!, dictionary: &right.JSONDictionary)
    }
}

// MARK:- Dictionary <String, T: Mappable>
public func <=<T: Mappable, U>(inout left: Dictionary<String, T>, right: Mapper<U>) {
    if right.mappingType == MappingType.fromJSON {
        FromJSON<T>().objectDictionary(&left, object: right.currentValue)
    } else {
        ToJSON().objectDictionary(left, key: right.currentKey!, dictionary: &right.JSONDictionary)
    }
}

// Optional Dictionary <String, T: Mappable>
public func <=<T: Mappable, U>(inout left: Dictionary<String, T>?, right: Mapper<U>) {
    if right.mappingType == MappingType.fromJSON {
        FromJSON<T>().optionalObjectDictionary(&left, object: right.currentValue)
    } else {
        ToJSON().optionalObjectDictionary(left, key: right.currentKey!, dictionary: &right.JSONDictionary)
    }
}

// MARK: Dictionary <String, AnyObject>
public func <=<U>(inout left: Dictionary<String, AnyObject>, right: Mapper<U>) {
    if right.mappingType == MappingType.fromJSON {
        FromJSON<AnyObject>().basicType(&left, object: right.currentValue)
    } else {
        ToJSON().basicDictionary(left, key: right.currentKey!, dictionary: &right.JSONDictionary)
    }
}

// Optional dictionary <String, AnyObject>
public func <=<U>(inout left: Dictionary<String, AnyObject>?, right: Mapper<U>) {
    if right.mappingType == MappingType.fromJSON {
        FromJSON<AnyObject>().optionalBasicType(&left, object: right.currentValue)
    } else {
        ToJSON().optionalBasicDictionary(left, key: right.currentKey!, dictionary: &right.JSONDictionary)
    }
}

// MARK:- Array<T: Mappable>
public func <=<T: Mappable, U>(inout left: Array<T>, right: Mapper<U>) {
    if right.mappingType == MappingType.fromJSON {
        FromJSON<T>().objectArray(&left, object: right.currentValue)
    } else {
        ToJSON().objectArray(left, key: right.currentKey!, dictionary: &right.JSONDictionary)
    }
}

// Optional array of objects conforming to Mappable
public func <=<T: Mappable, U>(inout left: Array<T>?, right: Mapper<U>) {
    if right.mappingType == MappingType.fromJSON {
        FromJSON<T>().optionalObjectArray(&left, object: right.currentValue)
    } else {
        ToJSON().optionalObjectArray(left, key: right.currentKey!, dictionary: &right.JSONDictionary)
    }
}

// MARK: Array<AnyObject>
public func <=<U>(inout left: Array<AnyObject>, right: Mapper<U>) {
    if right.mappingType == MappingType.fromJSON {
        FromJSON<AnyObject>().basicType(&left, object: right.currentValue)
    } else {
        ToJSON().basicArray(left, key: right.currentKey!, dictionary: &right.JSONDictionary)
    }
}

// Optional array of String type
public func <=<U>(inout left: Array<AnyObject>?, right: Mapper<U>) {
    if right.mappingType == MappingType.fromJSON {
        FromJSON<AnyObject>().optionalBasicType(&left, object: right.currentValue)
    } else {
        ToJSON().optionalBasicArray(left, key: right.currentKey!, dictionary: &right.JSONDictionary)
    }
}
