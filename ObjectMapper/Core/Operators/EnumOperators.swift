//
//  EnumOperators.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2016-09-26.
//  Copyright © 2016 hearst. All rights reserved.
//

import Foundation


// MARK:- Raw Representable types

/// Object of Raw Representable type
public func <- <T: RawRepresentable>(left: inout T, right: Map) {
	left <- (right, EnumTransform())
}

public func >>> <T: RawRepresentable>(left: T, right: Map) {
	left >>> (right, EnumTransform())
}


/// Optional Object of Raw Representable type
public func <- <T: RawRepresentable>(left: inout T?, right: Map) {
	left <- (right, EnumTransform())
}

public func >>> <T: RawRepresentable>(left: T?, right: Map) {
	left >>> (right, EnumTransform())
}


/// Implicitly Unwrapped Optional Object of Raw Representable type
public func <- <T: RawRepresentable>(left: inout T!, right: Map) {
	left <- (right, EnumTransform())
}

// MARK:- Arrays of Raw Representable type

/// Array of Raw Representable object
public func <- <T: RawRepresentable>(left: inout [T], right: Map) {
	left <- (right, EnumTransform())
}

public func >>> <T: RawRepresentable>(left: [T], right: Map) {
	left >>> (right, EnumTransform())
}


/// Array of Raw Representable object
public func <- <T: RawRepresentable>(left: inout [T]?, right: Map) {
	left <- (right, EnumTransform())
}

public func >>> <T: RawRepresentable>(left: [T]?, right: Map) {
	left >>> (right, EnumTransform())
}


/// Array of Raw Representable object
public func <- <T: RawRepresentable>(left: inout [T]!, right: Map) {
	left <- (right, EnumTransform())
}

// MARK:- Dictionaries of Raw Representable type

/// Dictionary of Raw Representable object
public func <- <T: RawRepresentable>(left: inout [String: T], right: Map) {
	left <- (right, EnumTransform())
}

public func >>> <T: RawRepresentable>(left: [String: T], right: Map) {
	left >>> (right, EnumTransform())
}


/// Dictionary of Raw Representable object
public func <- <T: RawRepresentable>(left: inout [String: T]?, right: Map) {
	left <- (right, EnumTransform())
}

public func >>> <T: RawRepresentable>(left: [String: T]?, right: Map) {
	left >>> (right, EnumTransform())
}


/// Dictionary of Raw Representable object
public func <- <T: RawRepresentable>(left: inout [String: T]!, right: Map) {
	left <- (right, EnumTransform())
}
