//
//  ImmutableMappble.swift
//  ObjectMapper
//
//  Created by Suyeol Jeon on 23/09/2016.
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

public protocol ImmutableMappable: BaseMappable {
	init(map: Map) throws
}

public extension ImmutableMappable {
	
	/// Implement this method to support object -> JSON transform.
	public func mapping(map: Map) {}
	
	/// Initializes object from a JSON String
	public init(JSONString: String, context: MapContext? = nil) throws {
		self = try Mapper(context: context).map(JSONString: JSONString)
	}
	
	/// Initializes object from a JSON Dictionary
	public init(JSON: [String: Any], context: MapContext? = nil) throws {
		self = try Mapper(context: context).map(JSON: JSON)
	}
	
	/// Initializes object from a JSONObject
	public init(JSONObject: Any, context: MapContext? = nil) throws {
		self = try Mapper(context: context).map(JSONObject: JSONObject)
	}
	
}

public extension Map {

	fileprivate func currentValue(for key: String, nested: Bool? = nil, delimiter: String = ".") -> Any? {
		let isNested = nested ?? key.contains(delimiter)
		return self[key, nested: isNested, delimiter: delimiter].currentValue
	}
	
	// MARK: Basic

	/// Returns a value or throws an error.
	public func value<T>(_ key: String, nested: Bool? = nil, delimiter: String = ".", file: StaticString = #file, function: StaticString = #function, line: UInt = #line) throws -> T {
		let currentValue = self.currentValue(for: key, nested: nested, delimiter: delimiter)
		guard let value = currentValue as? T else {
			throw MapError(key: key, currentValue: currentValue, reason: "Cannot cast to '\(T.self)'", file: file, function: function, line: line)
		}
		return value
	}

	/// Returns a transformed value or throws an error.
	public func value<Transform: TransformType>(_ key: String, nested: Bool? = nil, delimiter: String = ".", using transform: Transform, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) throws -> Transform.Object {
		let currentValue = self.currentValue(for: key, nested: nested, delimiter: delimiter)
		guard let value = transform.transformFromJSON(currentValue) else {
			throw MapError(key: key, currentValue: currentValue, reason: "Cannot transform to '\(Transform.Object.self)' using \(transform)", file: file, function: function, line: line)
		}
		return value
	}
	
	/// Returns a RawRepresentable type or throws an error.
	public func value<T: RawRepresentable>(_ key: String, nested: Bool? = nil, delimiter: String = ".", file: StaticString = #file, function: StaticString = #function, line: UInt = #line) throws -> T {
		return try self.value(key, nested: nested, delimiter: delimiter, using: EnumTransform(), file: file, function: function, line: line)
	}
	
	/// Returns a `[RawRepresentable]` type or throws an error.
	public func value<T: RawRepresentable>(_ key: String, nested: Bool? = nil, delimiter: String = ".", file: StaticString = #file, function: StaticString = #function, line: UInt = #line) throws -> [T] {
		return try self.value(key, nested: nested, delimiter: delimiter, using: EnumTransform(), file: file, function: function, line: line)
	}

	// MARK: BaseMappable

	/// Returns a `BaseMappable` object or throws an error.
	public func value<T: BaseMappable>(_ key: String, nested: Bool? = nil, delimiter: String = ".", file: StaticString = #file, function: StaticString = #function, line: UInt = #line) throws -> T {
		let currentValue = self.currentValue(for: key, nested: nested, delimiter: delimiter)
		guard let JSONObject = currentValue else {
			throw MapError(key: key, currentValue: currentValue, reason: "Found unexpected nil value", file: file, function: function, line: line)
		}
		return try Mapper<T>(context: context).mapOrFail(JSONObject: JSONObject)
	}

	// MARK: [BaseMappable]

	/// Returns a `[BaseMappable]` or throws an error.
	public func value<T: BaseMappable>(_ key: String, nested: Bool? = nil, delimiter: String = ".", file: StaticString = #file, function: StaticString = #function, line: UInt = #line) throws -> [T] {
		let currentValue = self.currentValue(for: key, nested: nested, delimiter: delimiter)
		guard let jsonArray = currentValue as? [Any] else {
			throw MapError(key: key, currentValue: currentValue, reason: "Cannot cast to '[Any]'", file: file, function: function, line: line)
		}
		return try jsonArray.enumerated().map { i, JSONObject -> T in
			return try Mapper<T>(context: context).mapOrFail(JSONObject: JSONObject)
		}
	}

	/// Returns a `[BaseMappable]` using transform or throws an error.
	public func value<Transform: TransformType>(_ key: String, nested: Bool? = nil, delimiter: String = ".", using transform: Transform, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) throws -> [Transform.Object] {
		let currentValue = self.currentValue(for: key, nested: nested, delimiter: delimiter)
		guard let jsonArray = currentValue as? [Any] else {
			throw MapError(key: key, currentValue: currentValue, reason: "Cannot cast to '[Any]'", file: file, function: function, line: line)
		}
		return try jsonArray.enumerated().map { i, json -> Transform.Object in
			guard let object = transform.transformFromJSON(json) else {
				throw MapError(key: "\(key)[\(i)]", currentValue: json, reason: "Cannot transform to '\(Transform.Object.self)' using \(transform)", file: file, function: function, line: line)
			}
			return object
		}
	}

	// MARK: [String: BaseMappable]

	/// Returns a `[String: BaseMappable]` or throws an error.
	public func value<T: BaseMappable>(_ key: String, nested: Bool? = nil, delimiter: String = ".", file: StaticString = #file, function: StaticString = #function, line: UInt = #line) throws -> [String: T] {
		
		let currentValue = self.currentValue(for: key, nested: nested, delimiter: delimiter)
		guard let jsonDictionary = currentValue as? [String: Any] else {
			throw MapError(key: key, currentValue: currentValue, reason: "Cannot cast to '[String: Any]'", file: file, function: function, line: line)
		}
		var value: [String: T] = [:]
		for (key, json) in jsonDictionary {
			value[key] = try Mapper<T>(context: context).mapOrFail(JSONObject: json)
		}
		return value
	}

	/// Returns a `[String: BaseMappable]` using transform or throws an error.
	public func value<Transform: TransformType>(_ key: String, nested: Bool? = nil, delimiter: String = ".", using transform: Transform, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) throws -> [String: Transform.Object] {
		
		let currentValue = self.currentValue(for: key, nested: nested, delimiter: delimiter)
		guard let jsonDictionary = currentValue as? [String: Any] else {
			throw MapError(key: key, currentValue: currentValue, reason: "Cannot cast to '[String: Any]'", file: file, function: function, line: line)
		}
		var value: [String: Transform.Object] = [:]
		for (key, json) in jsonDictionary {
			guard let object = transform.transformFromJSON(json) else {
				throw MapError(key: key, currentValue: json, reason: "Cannot transform to '\(Transform.Object.self)' using \(transform)", file: file, function: function, line: line)
			}
			value[key] = object
		}
		return value
	}
	
	// MARK: [[BaseMappable]]
	/// Returns a `[[BaseMappable]]` or throws an error.
	public func value<T: BaseMappable>(_ key: String, nested: Bool? = nil, delimiter: String = ".", file: StaticString = #file, function: StaticString = #function, line: UInt = #line) throws -> [[T]] {
		
		let currentValue = self.currentValue(for: key, nested: nested, delimiter: delimiter)
		guard let json2DArray = currentValue as? [[Any]] else {
			throw MapError(key: key, currentValue: currentValue, reason: "Cannot cast to '[[Any]]'", file: file, function: function, line: line)
		}
		return try json2DArray.map { jsonArray in
			try jsonArray.map { jsonObject -> T in
				return try Mapper<T>(context: context).mapOrFail(JSONObject: jsonObject)
			}
		}
	}
	
	/// Returns a `[[BaseMappable]]` using transform or throws an error.
	public func value<Transform: TransformType>(_ key: String, nested: Bool? = nil, delimiter: String = ".", using transform: Transform, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) throws -> [[Transform.Object]] {
		
		let currentValue = self.currentValue(for: key, nested: nested, delimiter: delimiter)
		guard let json2DArray = currentValue as? [[Any]] else {
			throw MapError(key: key, currentValue: currentValue, reason: "Cannot cast to '[[Any]]'",
			               file: file, function: function, line: line)
		}
		return try json2DArray.enumerated().map { i, jsonArray in
			try jsonArray.enumerated().map { j, json -> Transform.Object in
				guard let object = transform.transformFromJSON(json) else {
					throw MapError(key: "\(key)[\(i)][\(j)]", currentValue: json, reason: "Cannot transform to '\(Transform.Object.self)' using \(transform)", file: file, function: function, line: line)
				}
				return object
			}
		}
	}
	
}

public extension Mapper where N: ImmutableMappable {
	
	public func map(JSON: [String: Any]) throws -> N {
		return try self.mapOrFail(JSON: JSON)
	}
	
	public func map(JSONString: String) throws -> N {
		return try mapOrFail(JSONString: JSONString)
	}
	
	public func map(JSONObject: Any) throws -> N {
		return try mapOrFail(JSONObject: JSONObject)
	}
	
	// MARK: Array mapping functions
	
	public func mapArray(JSONArray: [[String: Any]]) throws -> [N] {
		return try JSONArray.flatMap(mapOrFail)
	}
	
	public func mapArray(JSONString: String) throws -> [N] {
		guard let JSONObject = Mapper.parseJSONString(JSONString: JSONString) else {
			throw MapError(key: nil, currentValue: JSONString, reason: "Cannot convert string into Any'")
		}
		
		return try mapArray(JSONObject: JSONObject)
	}
	
	public func mapArray(JSONObject: Any) throws -> [N] {
		guard let JSONArray = JSONObject as? [[String: Any]] else {
			throw MapError(key: nil, currentValue: JSONObject, reason: "Cannot cast to '[[String: Any]]'")
		}
		
		return try mapArray(JSONArray: JSONArray)
	}

	// MARK: Dictionary mapping functions

	public func mapDictionary(JSONString: String) throws -> [String: N] {
		guard let JSONObject = Mapper.parseJSONString(JSONString: JSONString) else {
			throw MapError(key: nil, currentValue: JSONString, reason: "Cannot convert string into Any'")
		}

		return try mapDictionary(JSONObject: JSONObject)
	}

	public func mapDictionary(JSONObject: Any?) throws -> [String: N] {
		guard let JSON = JSONObject as? [String: [String: Any]] else {
			throw MapError(key: nil, currentValue: JSONObject, reason: "Cannot cast to '[String: [String: Any]]''")
		}

		return try mapDictionary(JSON: JSON)
	}

	public func mapDictionary(JSON: [String: [String: Any]]) throws -> [String: N] {
		return try JSON.filterMap(mapOrFail)
	}

	// MARK: Dictinoary of arrays mapping functions

	public func mapDictionaryOfArrays(JSONObject: Any?) throws -> [String: [N]] {
		guard let JSON = JSONObject as? [String: [[String: Any]]] else {
			throw MapError(key: nil, currentValue: JSONObject, reason: "Cannot cast to '[String: [String: Any]]''")
		}
		return try mapDictionaryOfArrays(JSON: JSON)
	}

	public func mapDictionaryOfArrays(JSON: [String: [[String: Any]]]) throws -> [String: [N]] {
		return try JSON.filterMap { array -> [N] in
			try mapArray(JSONArray: array)
		}
	}

	// MARK: 2 dimentional array mapping functions

	public func mapArrayOfArrays(JSONObject: Any?) throws -> [[N]] {
		guard let JSONArray = JSONObject as? [[[String: Any]]] else {
			throw MapError(key: nil, currentValue: JSONObject, reason: "Cannot cast to '[[[String: Any]]]''")
		}
		return try JSONArray.map(mapArray)
	}

}

internal extension Mapper where N: BaseMappable {

	internal func mapOrFail(JSON: [String: Any]) throws -> N {
		let map = Map(mappingType: .fromJSON, JSON: JSON, context: context, shouldIncludeNilValues: shouldIncludeNilValues)
		
		// Check if object is ImmutableMappable, if so use ImmutableMappable protocol for mapping
		if let klass = N.self as? ImmutableMappable.Type,
			var object = try klass.init(map: map) as? N {
			object.mapping(map: map)
			return object
		}
		
		// If not, map the object the standard way
		guard let value = self.map(JSON: JSON) else {
			throw MapError(key: nil, currentValue: JSON, reason: "Cannot map to '\(N.self)'")
		}
		return value
	}

	internal func mapOrFail(JSONString: String) throws -> N {
		guard let JSON = Mapper.parseJSONStringIntoDictionary(JSONString: JSONString) else {
			throw MapError(key: nil, currentValue: JSONString, reason: "Cannot parse into '[String: Any]'")
		}
		return try mapOrFail(JSON: JSON)
	}

	internal func mapOrFail(JSONObject: Any) throws -> N {
		guard let JSON = JSONObject as? [String: Any] else {
			throw MapError(key: nil, currentValue: JSONObject, reason: "Cannot cast to '[String: Any]'")
		}
		return try mapOrFail(JSON: JSON)
	}

}
