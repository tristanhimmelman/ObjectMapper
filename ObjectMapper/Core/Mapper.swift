//
//  Mapper.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2014-10-09.
//  Copyright (c) 2014 hearst. All rights reserved.
//

import Foundation

public protocol Mappable {
	init?(_ map: Map)
	mutating func mapping(map: Map)
}

public enum MappingType {
	case fromJSON
	case toJSON
}

/**
* A class used for holding mapping data
*/
public final class Map {
	public let mappingType: MappingType

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

	public func value<T>() -> T? {
		return currentValue as? T
	}

	public func valueOr<T>(defaultValue: T) -> T {
		return (currentValue as? T) ?? defaultValue
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
	
	// MARK: Mapping functions that map to an existing object toObject
	
	/**
	* Map a JSON string onto an existing object
	*/
	public func map(string JSONString: String, var toObject object: N) -> N {
		if let JSON = parseJSONDictionary(JSONString) {
			return map(JSON, toObject: object)
		}
		return object
	}
	
	/**
	* Maps a JSON object to an existing Mappable object if it is a JSON dictionary, or returns the passed object as is
	*/
	public func map(JSON: AnyObject?, var toObject object: N) -> N {
		if let JSON = JSON as? [String : AnyObject] {
			return map(JSON, toObject: object)
		}
		
		return object
	}
	
	/**
	* Maps a JSON dictionary to an existing object that conforms to Mappable.
	* Usefull for those pesky objects that have crappy designated initializers like NSManagedObject
	*/
	public func map(JSON: [String : AnyObject], var toObject object: N) -> N {
		let map = Map(mappingType: .fromJSON, JSONDictionary: JSON)
		object.mapping(map)
		return object
	}

	//MARK: Mapping functions that create an object
	
	/**
	* Map a JSON string to an object that conforms to Mappable
	*/
	public func map(string JSONString: String) -> N? {
		if let JSON = parseJSONDictionary(JSONString) {
			return map(JSON)
		}
		return nil
	}

	/**
	* Maps a JSON object to a Mappable object if it is a JSON dictionary, or returns nil.
	*/
	public func map(JSON: AnyObject?) -> N? {
		if let JSON = JSON as? [String : AnyObject] {
			return map(JSON)
		}

		return nil
	}

	/**
	* Maps a JSON dictionary to an object that conforms to Mappable
	*/
	public func map(JSON: [String : AnyObject]) -> N! {
		let map = Map(mappingType: .fromJSON, JSONDictionary: JSON)
		let object = N(map)
		return object
	}

	//MARK: Mapping functions for Arrays and Dictionaries
	
	/**
	* Maps a JSON array to an object that conforms to Mappable
	*/
	public func mapArray(string JSONString: String) -> [N] {
		let parsedJSON: AnyObject? = parseJSONString(JSONString)

		if let objectArray = mapArray(parsedJSON) {
			return objectArray
		}

		// failed to parse JSON into array form
		// try to parse it into a dictionary and then wrap it in an array
		if let object = map(parsedJSON) {
			return [object]
		}

		return []
	}

	/** Maps a JSON object to an array of Mappable objects if it is an array of
	* JSON dictionary, or returns nil.
	*/
	public func mapArray(JSON: AnyObject?) -> [N]? {
		if let JSONArray = JSON as? [[String : AnyObject]] {
			return mapArray(JSONArray)
		}

		return nil
	}
	
	/**
	* Maps an array of JSON dictionary to an array of object that conforms to Mappable
	*/
	public func mapArray(JSON: [[String : AnyObject]]) -> [N] {
		return JSON.map {
			// map every element in JSON array to type N
			return self.map($0)
		}
	}

	/** Maps a JSON object to a dictionary of Mappable objects if it is a JSON
	* dictionary of dictionaries, or returns nil.
	*/
	public func mapDictionary(JSON: AnyObject?) -> [String : N]? {
		if let JSONDictionary = JSON as? [String : [String : AnyObject]] {
			return mapDictionary(JSONDictionary)
		}

		return nil
	}

	/**
	* Maps a JSON dictionary of dictionaries to a dictionary of objects that conform to Mappable.
	*/
	public func mapDictionary(JSON: [String : [String : AnyObject]]) -> [String : N] {
		return JSON.map { key, value in
			// map every value in dictionary to type N
			return (key, self.map(value))
		}
	}

	// MARK: Functions that create JSON from objects
	
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
			// convert every element in array to JSON dictionary equivalent
			self.toJSON($0)
		}
	}

	/**
	* Maps a dictionary of Objects that conform to Mappable to a JSON dictionary of dictionaries.
	*/
	public func toJSONDictionary(dictionary: [String : N]) -> [String : [String : AnyObject]] {
		return dictionary.map { k, v in
			// convert every value in dictionary to its JSON dictionary equivalent			
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
				return NSString(data: JSON, encoding: NSUTF8StringEncoding) as! String
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
		return parseJSONDictionary(parsedJSON)
	}

	/**
	* Convert a JSON Object into a Dictionary<String, AnyObject> using NSJSONSerialization
	*/
	private func parseJSONDictionary(JSON: AnyObject?) -> [String : AnyObject]? {
		if let JSONDict = JSON as? [String : AnyObject] {
			return JSONDict
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
