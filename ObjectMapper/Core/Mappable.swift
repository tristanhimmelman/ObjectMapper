//
//  Mappable.swift
//  ObjectMapper
//
//  Created by Scott Hoyt on 10/25/15.
//  Copyright © 2015 hearst. All rights reserved.
//

import Foundation

public protocol Mappable {
	/// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
	init?(_ map: Map)
	/// This function is where all variable mappings should occur. It is executed by Mapper during the mapping (serialization and deserialization) process.
	mutating func mapping(map: Map)
	/// This is an optional function that can be used to:
	///		1) provide an existing cached object to be used for mapping
	///		2) return an object of another class (which conforms to Mappable) to be used for mapping. For instance, you may inspect the JSON to infer the type of object that should be used for any given mapping
	static func objectForMapping(map: Map) -> Mappable?
}

public extension Mappable {
	
	public static func objectForMapping(map: Map) -> Mappable? {
		return nil
	}
	
	/// Initializes object from a JSON String
	public init?(JSONString: String) {
		if let obj: Self = Mapper().map(JSONString) {
			self = obj
		} else {
			return nil
		}
	}
	
	/// Initializes object from a JSON Dictionary
	public init?(JSON: [String : AnyObject]) {
		if let obj: Self = Mapper().map(JSON) {
			self = obj
		} else {
			return nil
		}
	}
	
	/// Returns the JSON Dictionary for the object
	public func toJSON() -> [String: AnyObject] {
		return Mapper().toJSON(self)
	}
	
	/// Returns the JSON String for the object
	public func toJSONString(prettyPrint: Bool = false) -> String? {
		return Mapper().toJSONString(self, prettyPrint: prettyPrint)
	}
}

public extension Array where Element: Mappable {
	
	/// Initialize Array from a JSON String
	public init?(JSONString: String) {
		if let obj: [Element] = Mapper().mapArray(JSONString) {
			self = obj
		} else {
			return nil
		}
	}
	
	/// Initialize Array from a JSON Array
	public init?(JSONArray: [[String : AnyObject]]) {
		if let obj: [Element] = Mapper().mapArray(JSONArray) {
			self = obj
		} else {
			return nil
		}
	}
	
	/// Returns the JSON Array
	public func toJSON() -> [[String : AnyObject]] {
		return Mapper().toJSONArray(self)
	}
	
	/// Returns the JSON String for the object
	public func toJSONString(prettyPrint: Bool = false) -> String? {
		return Mapper().toJSONString(self, prettyPrint: prettyPrint)
	}
}

public extension Set where Element: Mappable {
	
	/// Initializes a set from a JSON String
	public init?(JSONString: String) {
		if let obj: Set<Element> = Mapper().mapSet(JSONString) {
			self = obj
		} else {
			return nil
		}
	}
	
	/// Initializes a set from JSON
	public init?(JSONArray: [[String : AnyObject]]) {
		if let obj: Set<Element> = Mapper().mapSet(JSONArray) {
			self = obj
		} else {
			return nil
		}
	}
	
	/// Returns the JSON Set
	public func toJSON() -> [[String : AnyObject]] {
		return Mapper().toJSONSet(self)
	}
	
	/// Returns the JSON String for the object
	public func toJSONString(prettyPrint: Bool = false) -> String? {
		return Mapper().toJSONString(self, prettyPrint: prettyPrint)
	}
}
