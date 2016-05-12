//
//  Mapper.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2014-10-09.
//
//  The MIT License (MIT)
//
//  Copyright (c) 2014-2015 Hearst
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

import Foundation

public enum MappingType {
	case FromJSON
	case ToJSON
}

/// The Mapper class provides methods for converting Model objects to JSON and methods for converting JSON to Model objects
public final class Mapper<N: Mappable> {
	
	public var context: MapContext?
	
	public init(context: MapContext? = nil){
		self.context = context
	}
	
	// MARK: Mapping functions that map to an existing object toObject
	
	/// Maps a JSON object to an existing Mappable object if it is a JSON dictionary, or returns the passed object as is
	public func map(JSON: AnyObject?, toObject object: N) -> N {
		if let JSON = JSON as? [String : AnyObject] {
			return map(JSON, toObject: object)
		}
		
		return object
	}
	
	/// Map a JSON string onto an existing object
	public func map(JSONString: String, toObject object: N) -> N {
		if let JSON = Mapper.parseJSONDictionary(JSONString) {
			return map(JSON, toObject: object)
		}
		return object
	}
	
	/// Maps a JSON dictionary to an existing object that conforms to Mappable.
	/// Usefull for those pesky objects that have crappy designated initializers like NSManagedObject
	public func map(JSONDictionary: [String : AnyObject], toObject object: N) -> N {
		var mutableObject = object
		let map = Map(mappingType: .FromJSON, JSONDictionary: JSONDictionary, toObject: true, context: context)
		mutableObject.mapping(map)
		return mutableObject
	}

	//MARK: Mapping functions that create an object
	
	/// Map an optional JSON string to an object that conforms to Mappable
	public func map(JSONString: String?) -> N? {
		if let JSONString = JSONString {
			return map(JSONString)
		}
		
		return nil
	}
	
	/// Map a JSON string to an object that conforms to Mappable
	public func map(JSONString: String) -> N? {
		if let JSON = Mapper.parseJSONDictionary(JSONString) {
			return map(JSON)
		}
		
		return nil
	}
	
	/// Map a JSON NSString to an object that conforms to Mappable
	public func map(JSONString: NSString) -> N? {
		return map(JSONString as String)
	}
	
	/// Maps a JSON object to a Mappable object if it is a JSON dictionary or NSString, or returns nil.
	public func map(JSON: AnyObject?) -> N? {
		if let JSON = JSON as? [String : AnyObject] {
			return map(JSON)
		}

		return nil
	}

	/// Maps a JSON dictionary to an object that conforms to Mappable
	public func map(JSONDictionary: [String : AnyObject]) -> N? {
		let map = Map(mappingType: .FromJSON, JSONDictionary: JSONDictionary, context: context)
		
		// check if objectForMapping returns an object for mapping
		if var object = N.self.objectForMapping(map) as? N {
			object.mapping(map)
			return object
		}
		
		// fall back to using init? to create N
		if var object = N(map) {
			object.mapping(map)
			return object
		}
		
		return nil
	}

	// MARK: Mapping functions for Arrays and Dictionaries
	
	/// Maps a JSON array to an object that conforms to Mappable
	public func mapArray(JSONString: String) -> [N]? {
		let parsedJSON: AnyObject? = Mapper.parseJSONString(JSONString)

		if let objectArray = mapArray(parsedJSON) {
			return objectArray
		}

		// failed to parse JSON into array form
		// try to parse it into a dictionary and then wrap it in an array
		if let object = map(parsedJSON) {
			return [object]
		}

		return nil
	}
	
	/// Maps a optional JSON String into an array of objects that conforms to Mappable
	public func mapArray(JSONString: String?) -> [N]? {
		if let JSONString = JSONString {
			return mapArray(JSONString)
		}
		
		return nil
	}
	
	/// Maps a JSON object to an array of Mappable objects if it is an array of JSON dictionary, or returns nil.
	public func mapArray(JSON: AnyObject?) -> [N]? {
		if let JSONArray = JSON as? [[String : AnyObject]] {
			return mapArray(JSONArray)
		}

		return nil
	}
	
	/// Maps an array of JSON dictionary to an array of Mappable objects
	public func mapArray(JSONArray: [[String : AnyObject]]) -> [N]? {
		// map every element in JSON array to type N
		let result = JSONArray.flatMap(map)
		return result
	}
	
	/// Maps a JSON object to a dictionary of Mappable objects if it is a JSON dictionary of dictionaries, or returns nil.
	public func mapDictionary(JSONString: String) -> [String : N]? {
		let parsedJSON: AnyObject? = Mapper.parseJSONString(JSONString)
		return mapDictionary(parsedJSON)
	}
	
	/// Maps a JSON object to a dictionary of Mappable objects if it is a JSON dictionary of dictionaries, or returns nil.
	public func mapDictionary(JSON: AnyObject?) -> [String : N]? {
		if let JSONDictionary = JSON as? [String : [String : AnyObject]] {
			return mapDictionary(JSONDictionary)
		}

		return nil
	}

	/// Maps a JSON dictionary of dictionaries to a dictionary of Mappble objects
	public func mapDictionary(JSONDictionary: [String : [String : AnyObject]]) -> [String : N]? {
		// map every value in dictionary to type N
		let result = JSONDictionary.filterMap(map)
		if result.isEmpty == false {
			return result
		}
		
		return nil
	}
	
	/// Maps a JSON object to a dictionary of Mappable objects if it is a JSON dictionary of dictionaries, or returns nil.
	public func mapDictionary(JSON: AnyObject?, toDictionary dictionary: [String : N]) -> [String : N] {
		if let JSONDictionary = JSON as? [String : [String : AnyObject]] {
			return mapDictionary(JSONDictionary, toDictionary: dictionary)
		}
		
		return dictionary
	}
	
    /// Maps a JSON dictionary of dictionaries to an existing dictionary of Mappble objects
    public func mapDictionary(JSONDictionary: [String : [String : AnyObject]], toDictionary dictionary: [String : N]) -> [String : N] {
		var mutableDictionary = dictionary
        for (key, value) in JSONDictionary {
            if let object = dictionary[key] {
				Mapper(context: context).map(value, toObject: object)
            } else {
				mutableDictionary[key] = Mapper(context: context).map(value)
            }
        }
        
        return mutableDictionary
    }
	
	/// Maps a JSON object to a dictionary of arrays of Mappable objects
	public func mapDictionaryOfArrays(JSON: AnyObject?) -> [String : [N]]? {
		if let JSONDictionary = JSON as? [String : [[String : AnyObject]]] {
			return mapDictionaryOfArrays(JSONDictionary)
		}
		
		return nil
	}
	
	///Maps a JSON dictionary of arrays to a dictionary of arrays of Mappable objects
	public func mapDictionaryOfArrays(JSONDictionary: [String : [[String : AnyObject]]]) -> [String : [N]]? {
		// map every value in dictionary to type N
		let result = JSONDictionary.filterMap {
            mapArray($0)
        }
        
		if result.isEmpty == false {
			return result
		}
        
		return nil
	}
	
	/// Maps an 2 dimentional array of JSON dictionaries to a 2 dimentional array of Mappable objects
	public func mapArrayOfArrays(JSON: AnyObject?) -> [[N]]? {
		if let JSONArray = JSON as? [[[String : AnyObject]]] {
			var objectArray = [[N]]()
			for innerJSONArray in JSONArray {
				if let array = mapArray(innerJSONArray){
					objectArray.append(array)
				}
			}
			
			if objectArray.isEmpty == false {
				return objectArray
			}
		}
		
		return nil
	}

	// MARK: Utility functions for converting strings to JSON objects
	
	/// Convert a JSON String into a Dictionary<String, AnyObject> using NSJSONSerialization
	public static func parseJSONDictionary(JSON: String) -> [String : AnyObject]? {
		let parsedJSON: AnyObject? = Mapper.parseJSONString(JSON)
		return Mapper.parseJSONDictionary(parsedJSON)
	}
	
	/// Convert a JSON Object into a Dictionary<String, AnyObject> using NSJSONSerialization
	public static func parseJSONDictionary(JSON: AnyObject?) -> [String : AnyObject]? {
		if let JSONDict = JSON as? [String : AnyObject] {
			return JSONDict
		}

		return nil
	}

	/// Convert a JSON String into an Object using NSJSONSerialization
	public static func parseJSONString(JSON: String) -> AnyObject? {
		let data = JSON.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
		if let data = data {
			let parsedJSON: AnyObject?
			do {
				parsedJSON = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
			} catch let error {
				print(error)
				parsedJSON = nil
			}
			return parsedJSON
		}

		return nil
	}
}

extension Mapper {
    
	// MARK: Functions that create JSON from objects	
	
	///Maps an object that conforms to Mappable to a JSON dictionary <String : AnyObject>
	public func toJSON( object: N) -> [String : AnyObject] {
		var mutableObject = object
		let map = Map(mappingType: .ToJSON, JSONDictionary: [:], context: context)
		mutableObject.mapping(map)
		return map.JSONDictionary
	}
	
	///Maps an array of Objects to an array of JSON dictionaries [[String : AnyObject]]
	public func toJSONArray(array: [N]) -> [[String : AnyObject]] {
		return array.map {
			// convert every element in array to JSON dictionary equivalent
			self.toJSON($0)
		}
	}
	
	///Maps a dictionary of Objects that conform to Mappable to a JSON dictionary of dictionaries.
	public func toJSONDictionary(dictionary: [String : N]) -> [String : [String : AnyObject]] {
		return dictionary.map { k, v in
			// convert every value in dictionary to its JSON dictionary equivalent
			return (k, self.toJSON(v))
		}
	}
	
	///Maps a dictionary of Objects that conform to Mappable to a JSON dictionary of dictionaries.
	public func toJSONDictionaryOfArrays(dictionary: [String : [N]]) -> [String : [[String : AnyObject]]] {
		return dictionary.map { k, v in
			// convert every value (array) in dictionary to its JSON dictionary equivalent
			return (k, self.toJSONArray(v))
		}
	}
	
	/// Maps an Object to a JSON string with option of pretty formatting
	public func toJSONString(object: N, prettyPrint: Bool = false) -> String? {
		let JSONDict = toJSON(object)
		
        return Mapper.toJSONString(JSONDict, prettyPrint: prettyPrint)
	}

    /// Maps an array of Objects to a JSON string with option of pretty formatting	
    public func toJSONString(array: [N], prettyPrint: Bool = false) -> String? {
        let JSONDict = toJSONArray(array)
        
        return Mapper.toJSONString(JSONDict, prettyPrint: prettyPrint)
    }
	
    public static func toJSONString(JSONObject: AnyObject, prettyPrint: Bool) -> String? {
        if NSJSONSerialization.isValidJSONObject(JSONObject) {
            let JSONData: NSData?
            do {
				let options: NSJSONWritingOptions = prettyPrint ? .PrettyPrinted : []
                JSONData = try NSJSONSerialization.dataWithJSONObject(JSONObject, options: options)
            } catch let error {
                print(error)
                JSONData = nil
            }
            
            if let JSON = JSONData {
                return String(data: JSON, encoding: NSUTF8StringEncoding)
            }
        }
        return nil
    }
}

extension Mapper where N: Hashable {
	
	/// Maps a JSON array to an object that conforms to Mappable
	public func mapSet(JSONString: String) -> Set<N>? {
		let parsedJSON: AnyObject? = Mapper.parseJSONString(JSONString)
		
		if let objectArray = mapArray(parsedJSON){
			return Set(objectArray)
		}
		
		// failed to parse JSON into array form
		// try to parse it into a dictionary and then wrap it in an array
		if let object = map(parsedJSON) {
			return Set([object])
		}
		
		return nil
	}
	
	/// Maps a JSON object to an Set of Mappable objects if it is an array of JSON dictionary, or returns nil.
	public func mapSet(JSON: AnyObject?) -> Set<N>? {
		if let JSONArray = JSON as? [[String : AnyObject]] {
			return mapSet(JSONArray)
		}
		
		return nil
	}
	
	/// Maps an Set of JSON dictionary to an array of Mappable objects
	public func mapSet(JSONArray: [[String : AnyObject]]) -> Set<N> {
		// map every element in JSON array to type N
		return Set(JSONArray.flatMap(map))
	}

	///Maps a Set of Objects to a Set of JSON dictionaries [[String : AnyObject]]
	public func toJSONSet(set: Set<N>) -> [[String : AnyObject]] {
		return set.map {
			// convert every element in set to JSON dictionary equivalent
			self.toJSON($0)
		}
	}
	
	/// Maps a set of Objects to a JSON string with option of pretty formatting
	public func toJSONString(set: Set<N>, prettyPrint: Bool = false) -> String? {
		let JSONDict = toJSONSet(set)
		
		return Mapper.toJSONString(JSONDict, prettyPrint: prettyPrint)
	}
}

extension Dictionary {
	internal func map<K: Hashable, V>(@noescape f: Element -> (K, V)) -> [K : V] {
		var mapped = [K : V]()

		for element in self {
			let newElement = f(element)
			mapped[newElement.0] = newElement.1
		}

		return mapped
	}

	internal func map<K: Hashable, V>(@noescape f: Element -> (K, [V])) -> [K : [V]] {
		var mapped = [K : [V]]()
		
		for element in self {
			let newElement = f(element)
			mapped[newElement.0] = newElement.1
		}
		
		return mapped
	}

	
	internal func filterMap<U>(@noescape f: Value -> U?) -> [Key : U] {
		var mapped = [Key : U]()

		for (key, value) in self {
			if let newValue = f(value){
				mapped[key] = newValue
			}
		}

		return mapped
	}
}
