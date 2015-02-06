//
//  Mapper.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2014-10-09.
//  Copyright (c) 2014 hearst. All rights reserved.
//

import Foundation

public protocol Mappable {
	mutating func mapping(map: Map)
	init()
}

enum MappingType {
	case fromJSON
	case toJSON
}

/**
* A class used for holding mapping data
*/
public final class Map {
	let mappingType: MappingType

	var JSONDictionary: [String : AnyObject] = [:]
	var currentValue: AnyObject?
	var currentKey: String?

	private init(mappingType: MappingType, JSONDictionary: [String : AnyObject]) {
		self.mappingType = mappingType
		self.JSONDictionary = JSONDictionary
	}
	
	/**
	* Sets the current mapper value and key.
	* 
	* The Key paramater can be a period separated string (ex. "distance.value") to access sub objects.
	*/
	public subscript(key: String) -> Map {
		// save key and value associated to it
		currentKey = key
		// break down the components of the key
		currentValue = valueFor(key.componentsSeparatedByString("."), JSONDictionary)
		
		return self
	}
}

/**
* Fetch value from JSON dictionary, loop through them until we reach the desired object.
*/
private func valueFor(keyPathComponents: [String], dictionary: [String : AnyObject]) -> AnyObject? {
	// Implement it as a tail recursive function.

	if keyPathComponents.isEmpty {
		return nil
	}

	if let object: AnyObject = dictionary[keyPathComponents.first!] {
		switch object {
		case is NSNull:
			return nil

		case let dict as [String : AnyObject] where keyPathComponents.count > 1:
			let tail = Array(keyPathComponents[1..<keyPathComponents.count])
			return valueFor(tail, dict)

		default:
			return object
		}
	}

	return nil
}

/**
* The Mapper class provides methods for converting Model objects to JSON and methods for converting JSON to Model objects
*/
public final class Mapper<N: Mappable> {
	public init(){

	}
	
	// MARK: Public Mapping functions
	
	/**
	 * Map a JSON string onto an existing object
	 */
	public func map(string JSONString: String, var toObject object: N) -> N! {
		if let JSON = parseJSONDictionary(JSONString) {
			return map(JSON, toObject: object)
		}
		return nil
	}

	/**
	* Map a JSON string to an object that conforms to Mappable
	*/
	public func map(string JSONString: String) -> N! {
		if let JSON = parseJSONDictionary(JSONString) {
			return map(JSON)
		}
		return nil
	}

	/**
	* Maps a JSON dictionary to an object that conforms to Mappable
	*/
	public func map(JSON: [String : AnyObject]) -> N! {
		let object = N()
		return map(JSON, toObject: object)
	}

	/**
	* Maps a JSON dictionary to an existing object that conforms to Mappable.
	* Usefull for those pesky objects that have crappy designated initializers like NSManagedObject
	*/
	public func map(JSON: [String : AnyObject], var toObject object: N) -> N! {
		let map = Map(mappingType: .fromJSON, JSONDictionary: JSON)
		object.mapping(map)
		return object
	}

	/**
	* Maps a JSON array to an object that conforms to Mappable
	*/
	public func mapArray(string JSONString: String) -> [N] {
		if let JSONArray = parseJSONArray(JSONString) {
			return mapArray(JSONArray)
		}

		// failed to parse JSON into array form
		// try to parse it into a dictionary and then wrap it in an array
		if let JSONDict = parseJSONDictionary(JSONString) {
			return mapArray([JSONDict])
		}

		return []
	}
	
	/**
	* Maps an array of JSON dictionary to an array of object that conforms to Mappable
	*/
	public func mapArray(JSON: [[String : AnyObject]]) -> [N] {
		return JSON.map {
			self.map($0)
		}		
	}

	/**
	* Maps a JSON dictionary of dictionaries to a dictionary of objects that conform to Mappable.
	*/
	public func mapDictionary(JSON: [String : [String : AnyObject]]) -> [String : N] {
		return JSON.map { k, v in
			return (k, self.map(v))
		}
	}

	// MARK: public toJSON functions
	
	/**
	* Maps an object that conforms to Mappable to a JSON dictionary <String : AnyObject>
	*/
	public func toJSON(var object: N) -> [String : AnyObject] {
		let map = Map(mappingType: .toJSON, JSONDictionary: [:])
		object.mapping(map)
		return map.JSONDictionary
	}
	
	/** 
	* Maps an array of Objects to an array of JSON dictionaries [[String : AnyObject]]
	*/
	public func toJSONArray(array: [N]) -> [[String : AnyObject]] {
		return array.map {
			self.toJSON($0)
		}
	}

	/**
	* Maps a dictionary of Objects that conform to Mappable to a JSON dictionary of dictionaries.
	*/
	public func toJSONDictionary(dictionary: [String : N]) -> [String : [String : AnyObject]] {
		return dictionary.map { k, v in
			return (k, self.toJSON(v))
		}
	}

	/** 
	* Maps an Object to a JSON string
	*/
	public func toJSONString(object: N, prettyPrint: Bool) -> String! {
		let JSONDict = toJSON(object)

		var err: NSError?
		if NSJSONSerialization.isValidJSONObject(JSONDict) {
			let options: NSJSONWritingOptions = prettyPrint ? .PrettyPrinted : .allZeros
			let JSONData: NSData? = NSJSONSerialization.dataWithJSONObject(JSONDict, options: options, error: &err)
			if let error = err {
				println(error)
			}

			if let JSON = JSONData {
				return NSString(data: JSON, encoding: NSUTF8StringEncoding)
			}
		}

		return nil
	}

	// MARK: Private utility functions for converting strings to JSON objects
	
	/** 
	* Convert a JSON String into a Dictionary<String, AnyObject> using NSJSONSerialization 
	*/
	private func parseJSONDictionary(JSON: String) -> [String : AnyObject]? {
		let parsedJSON: AnyObject? = parseJSONString(JSON)
		if let JSONDict = parsedJSON as? [String : AnyObject] {
			return JSONDict
		}

		return nil
	}

	/** 
	* Convert a JSON String into a Array<String, AnyObject> using NSJSONSerialization 
	*/
	private func parseJSONArray(JSON: String) -> [[String : AnyObject]]? {
		let parsedJSON: AnyObject? = parseJSONString(JSON)
		if let JSONArray = parsedJSON as? [[String : AnyObject]] {
			return JSONArray
		}

		return nil
	}

	/** 
	* Convert a JSON String into an Object using NSJSONSerialization 
	*/
	private func parseJSONString(JSON: String) -> AnyObject? {
		let data = JSON.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
		if let data = data {
			var error: NSError?
			let parsedJSON: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &error)
			return parsedJSON
		}

		return nil
	}
}

extension Dictionary {
	private func map<K: Hashable, V>(f: Element -> (K, V)) -> [K : V] {
		var mapped = [K : V]()

		for element in self {
			let newElement = f(element)
			mapped[newElement.0] = newElement.1
		}

		return mapped
	}
}
