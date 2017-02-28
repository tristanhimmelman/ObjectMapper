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
	guard let value = value else { return nil }
	let max: IntMax
	switch value {
	case let x as Int: max = .init(x)
	case let x as Int8: max = .init(x)
	case let x as Int16: max = .init(x)
	case let x as Int32: max = .init(x)
	case let x as Int64: max = .init(x)
	case let x as UInt: max = .init(x)
	case let x as UInt8: max = .init(x)
	case let x as UInt16: max = .init(x)
	case let x as UInt32: max = .init(x)
	case let x as UInt64: max = .init(x)
	default: return nil
	}
	return T.init(max)
}

/// Convert any value to `UnsignedInteger`.
private func toUnsignedInteger<T: UnsignedInteger>(_ value: Any?) -> T? {
	guard let value = value else { return nil }
	let max: UIntMax
	switch value {
	case let x as Int: max = .init(x)
	case let x as Int8: max = .init(x)
	case let x as Int16: max = .init(x)
	case let x as Int32: max = .init(x)
	case let x as Int64: max = .init(x)
	case let x as UInt: max = .init(x)
	case let x as UInt8: max = .init(x)
	case let x as UInt16: max = .init(x)
	case let x as UInt32: max = .init(x)
	case let x as UInt64: max = .init(x)
	default: return nil
	}
	return T.init(max)
}
