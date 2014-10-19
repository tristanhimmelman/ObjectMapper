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
public func <=<T>(inout left: T, right: Mapper) {
    if right.mappingType == MappingType.fromJSON {
        FromJSON<T>().baseType(&left, object: right.currentValue)
    } else {
        ToJSON().baseType(left, key: right.currentKey!, dictionary: &right.JSONDictionary);
    }
}

// Optional basic type
public func <=<T>(inout left: T?, right: Mapper) {
    if right.mappingType == MappingType.fromJSON {
        FromJSON<T>().optionalBaseType(&left, object: right.currentValue)
    } else {
        ToJSON().optionalBaseType(left, key: right.currentKey!, dictionary: &right.JSONDictionary)
    }
}

// Basic type with Transform
public func <=<T, N>(inout left: T, right: (Mapper, MapperTransform<T, N>)) {
    if right.0.mappingType == MappingType.fromJSON {
        var value: T? = right.1.transformFromJSON(right.0.currentValue)
        //println("FromJSON \(value)");
        FromJSON<T>().baseType(&left, object: value)
    } else {
        var value: N? = right.1.transformToJSON(left)
        //println("\(left) toJSON \(value)")
        ToJSON().optionalBaseType(value, key: right.0.currentKey!, dictionary: &right.0.JSONDictionary)
    }
}

// Optional basic type with Transform
public func <=<T, N>(inout left: T?, right: (Mapper, MapperTransform<T, N>)) {
    if right.0.mappingType == MappingType.fromJSON {
        var value: T? = right.1.transformFromJSON(right.0.currentValue)
        //println("FromJSON \(value)");
        FromJSON<T>().optionalBaseType(&left, object: value)
    } else {
        var value: N? = right.1.transformToJSON(left)
        //println("\(left) toJSON \(value)")
        ToJSON().optionalBaseType(value, key: right.0.currentKey!, dictionary: &right.0.JSONDictionary)
    }
}

// MARK:- T: MapperProtocol
public func <=<T: MapperProtocol>(inout left: T, right: Mapper) {
    if right.mappingType == MappingType.fromJSON {
        FromJSON<T>().object(&left, object: right.currentValue)
    } else {
        ToJSON().object(left, key: right.currentKey!, dictionary: &right.JSONDictionary)
    }
}

// Optional object conforming to MapperProtocol
public func <=<T: MapperProtocol>(inout left: T?, right: Mapper) {
    if right.mappingType == MappingType.fromJSON {
        FromJSON<T>().object(&left, object: right.currentValue)
    } else {
        ToJSON().optionalObject(left, key: right.currentKey!, dictionary: &right.JSONDictionary)
    }
}

// MARK:- Dictionary <String, T: MapperProtocol>
public func <=<T: MapperProtocol>(inout left: Dictionary<String, T>, right: Mapper) {
    if right.mappingType == MappingType.fromJSON {
        FromJSON<T>().objectDictionary(&left, object: right.currentValue)
    } else {
        ToJSON().objectDictionary(left, key: right.currentKey!, dictionary: &right.JSONDictionary)
    }
}

// Optional Dictionary <String, T: MapperProtocol>
public func <=<T: MapperProtocol>(inout left: Dictionary<String, T>?, right: Mapper) {
    if right.mappingType == MappingType.fromJSON {
        FromJSON<T>().optionalObjectDictionary(&left, object: right.currentValue)
    } else {
        ToJSON().optionalObjectDictionary(left, key: right.currentKey!, dictionary: &right.JSONDictionary)
    }
}

// MARK: Dictionary <String, AnyObject>
public func <=(inout left: Dictionary<String, AnyObject>, right: Mapper) {
    if right.mappingType == MappingType.fromJSON {
        FromJSON<AnyObject>().baseType(&left, object: right.currentValue)
    } else {
        ToJSON().baseDictionary(left, key: right.currentKey!, dictionary: &right.JSONDictionary)
    }
}

// Optional dictionary <String, AnyObject>
public func <=(inout left: Dictionary<String, AnyObject>?, right: Mapper) {
    if right.mappingType == MappingType.fromJSON {
        FromJSON<AnyObject>().optionalBaseType(&left, object: right.currentValue)
    } else {
        ToJSON().optionalBaseDictionary(left, key: right.currentKey!, dictionary: &right.JSONDictionary)
    }
}

// MARK:- Array<T: MapperProtocol>
public func <=<T: MapperProtocol>(inout left: Array<T>, right: Mapper) {
    if right.mappingType == MappingType.fromJSON {
        FromJSON<T>().objectArray(&left, object: right.currentValue)
    } else {
        ToJSON().objectArray(left, key: right.currentKey!, dictionary: &right.JSONDictionary)
    }
}

// Optional array of objects conforming to MapperProtocol
public func <=<T: MapperProtocol>(inout left: Array<T>?, right: Mapper) {
    if right.mappingType == MappingType.fromJSON {
        FromJSON<T>().optionalObjectArray(&left, object: right.currentValue)
    } else {
        ToJSON().optionalObjectArray(left, key: right.currentKey!, dictionary: &right.JSONDictionary)
    }
}

// MARK: Array<AnyObject>
public func <=(inout left: Array<AnyObject>, right: Mapper) {
    if right.mappingType == MappingType.fromJSON {
        FromJSON<AnyObject>().baseType(&left, object: right.currentValue)
    } else {
        ToJSON().baseArray(left, key: right.currentKey!, dictionary: &right.JSONDictionary)
    }
}

// Optional array of String type
public func <=(inout left: Array<AnyObject>?, right: Mapper) {
    if right.mappingType == MappingType.fromJSON {
        FromJSON<AnyObject>().optionalBaseType(&left, object: right.currentValue)
    } else {
        ToJSON().optionalBaseArray(left, key: right.currentKey!, dictionary: &right.JSONDictionary)
    }
}
