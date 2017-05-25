//
//  IntegerOperators.swift
//  ObjectMapper
//
//  Created by Suyeol Jeon on 17/02/2017.
//  Copyright © 2017 hearst. All rights reserved.
//

import Foundation

// MARK: - Signed Integer

/// SignedInteger mapping
public func <- <T: SignedInteger>(left: inout T, right: Map) {
	switch right.mappingType {
	case .fromJSON where right.isKeyPresent:
		let value: T = toSignedInteger(right.currentValue) ?? 0
		FromJSON.basicType(&left, object: value)
	case .toJSON:
		left >>> right
	default: ()
	}
}

/// Optional SignedInteger mapping
public func <- <T: SignedInteger>(left: inout T?, right: Map) {
	switch right.mappingType {
	case .fromJSON where right.isKeyPresent:
		let value: T? = toSignedInteger(right.currentValue)
		FromJSON.basicType(&left, object: value)
	case .toJSON:
		left >>> right
	default: ()
	}
}

/// ImplicitlyUnwrappedOptional SignedInteger mapping
public func <- <T: SignedInteger>(left: inout T!, right: Map) {
	switch right.mappingType {
	case .fromJSON where right.isKeyPresent:
		let value: T! = toSignedInteger(right.currentValue)
		FromJSON.basicType(&left, object: value)
	case .toJSON:
		left >>> right
	default: ()
	}
}


// MARK: - Unsigned Integer

/// UnsignedInteger mapping
public func <- <T: UnsignedInteger>(left: inout T, right: Map) {
	switch right.mappingType {
	case .fromJSON where right.isKeyPresent:
		let value: T = toUnsignedInteger(right.currentValue) ?? 0
		FromJSON.basicType(&left, object: value)
	case .toJSON:
		left >>> right
	default: ()
	}
}


/// Optional UnsignedInteger mapping
public func <- <T: UnsignedInteger>(left: inout T?, right: Map) {
	switch right.mappingType {
	case .fromJSON where right.isKeyPresent:
		let value: T? = toUnsignedInteger(right.currentValue)
		FromJSON.basicType(&left, object: value)
	case .toJSON:
		left >>> right
	default: ()
	}
}

/// ImplicitlyUnwrappedOptional UnsignedInteger mapping
public func <- <T: UnsignedInteger>(left: inout T!, right: Map) {
	switch right.mappingType {
	case .fromJSON where right.isKeyPresent:
		let value: T! = toUnsignedInteger(right.currentValue)
		FromJSON.basicType(&left, object: value)
	case .toJSON:
		left >>> right
	default: ()
	}
}

// MARK: - Casting Utils

/// Convert any value to `SignedInteger`.
private func toSignedInteger<T: SignedInteger>(_ value: Any?) -> T? {
	guard
		let value = value,
		case let number as NSNumber = value
	else {
		return nil
	}

	if T.self ==   Int.self, let x = Int(exactly: number.int64Value)?.toIntMax() {
		return T.init(x)
	}
	if T.self ==  Int8.self, let x = Int8(exactly: number.int64Value)?.toIntMax() {
		return T.init(x)
	}
	if T.self == Int16.self, let x = Int16(exactly: number.int64Value)?.toIntMax() {
		return T.init(x)
	}
	if T.self == Int32.self, let x = Int32(exactly: number.int64Value)?.toIntMax() {
		return T.init(x)
	}
	if T.self == Int64.self, let x = Int64(exactly: number.int64Value)?.toIntMax() {
		return T.init(x)
	}

	return nil
}

/// Convert any value to `UnsignedInteger`.
private func toUnsignedInteger<T: UnsignedInteger>(_ value: Any?) -> T? {
	guard
		let value = value,
		case let number as NSNumber = value
	else {
		return nil
	}

	if T.self == UInt.self, let x = UInt(exactly: number.uint64Value)?.toUIntMax() {
		return T.init(x)
	}
	if T.self == UInt8.self, let x = UInt8(exactly: number.uint64Value)?.toUIntMax() {
		return T.init(x)
	}
	if T.self == UInt16.self, let x = UInt16(exactly: number.uint64Value)?.toUIntMax() {
		return T.init(x)
	}
	if T.self == UInt32.self, let x = UInt32(exactly: number.uint64Value)?.toUIntMax() {
		return T.init(x)
	}
	if T.self == UInt64.self, let x = UInt64(exactly: number.uint64Value)?.toUIntMax() {
		return T.init(x)
	}

	return nil
}
