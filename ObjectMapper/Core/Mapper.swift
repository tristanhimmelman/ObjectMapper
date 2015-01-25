//
//  Mapper.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2014-10-09.
//  Copyright (c) 2014 hearst. All rights reserved.
//

import Foundation

public protocol Mappable {
    mutating func map<N>(mapper: Mapper<N>)
    init()
}

enum MappingType {
    case fromJSON
    case toJSON
}

public class Mapper<N: Mappable> {
    var JSONDictionary: [String : AnyObject] = [:]
    var currentValue: AnyObject?
    var currentKey: String?
    var mappingType: MappingType = .fromJSON
    
    // MARK: Public methods
    
    public init(){
        
    }
    
    // Sets the current mapper value and key 
    public subscript(key: String) -> Mapper {
        get {
            // save key and value associated to it
            currentKey = key
            currentValue = valueFor(key)
            
            return self
        }
        set {}
    }
    
    // map a JSON string onto an existing object
    public func map(string JSON: String, var toObject object: N) -> N! {
        var json = parseJSONDictionary(JSON)
        if let json = json {
            mappingType = .fromJSON
            self.JSONDictionary = json
            object.map(self)
            
            return object
        }
        return nil
    }
    
    // map a JSON string to an object Type that conforms to Mappable
    public func map(string JSONString: String) -> N! {
        var json = parseJSONDictionary(JSONString)
        if let json = json {
            return map(json)
        }
        return nil
    }
    
    // maps a JSON dictionary to an object that conforms to Mappable
    public func map(JSON: [String : AnyObject]) -> N! {
        var object = N()
        return map(JSON, toObject: object)
    }
    
    // maps a JSON dictionary to an existing object that conforms to Mappable.
    // Usefull for those pesky objects that have crappy designated initializers like NSManagedObject
    public func map(JSON: [String : AnyObject], var toObject object: N) -> N! {
        mappingType = .fromJSON
        self.JSONDictionary = JSON
        object.map(self)
        return object
    }

	// maps a JSON array to an object that conforms to Mappable
	public func mapArray(string JSONString: String) -> [N]! {
		var jsonArray = parseJSONArray(JSONString)
		if let jsonArray = jsonArray {
			return mapArray(jsonArray)
		} else {
			// failed to parse JSON into array form
			// try to parse it into a dictionary and then wrap it in an array
			var jsonDict = parseJSONDictionary(JSONString)
			if let jsonDict = jsonDict {
				return mapArray([jsonDict])
			}
		}
		return nil
	}
	
	// maps a JSON dictionary to an object that conforms to Mappable
	public func mapArray(JSON: [[String : AnyObject]]) -> [N] {
		mappingType = .fromJSON
		
		var objects: Array<N> = []
		
		for innerJSON in JSON {
			self.JSONDictionary = innerJSON
			
			var object = N()
			object.map(self)
			objects.append(object)
		}
		
		return objects
	}
	
    // maps an Object to a JSON dictionary <String : AnyObject>
    public func toJSON(var object: N) -> [String : AnyObject] {
        mappingType = .toJSON
        
        self.JSONDictionary = [String : AnyObject]()
        object.map(self)
        
        return self.JSONDictionary
    }
	
	// maps an array of Objects to an array of JSON dictionaries [[String : AnyObject]]
	public func toJSONArray(array: [N]) -> [[String : AnyObject]] {
		mappingType = .toJSON
		
		var JSONArray = [[String : AnyObject]]()
		
		for (var object) in array {
			self.JSONDictionary = [String : AnyObject]()
			object.map(self)
			JSONArray.append(self.JSONDictionary)
		}
		
		return JSONArray
	}
	
    // maps an Object to a JSON string
    public func toJSONString(object: N, prettyPrint: Bool) -> String! {
        let JSONDict = toJSON(object)
        
        var err: NSError?
        if NSJSONSerialization.isValidJSONObject(JSONDict) {
            var options = prettyPrint ? NSJSONWritingOptions.PrettyPrinted : NSJSONWritingOptions.allZeros
            var jsonData: NSData? = NSJSONSerialization.dataWithJSONObject(JSONDict, options: options, error: &err)
            if let error = err {
                println(error)
            }
            
            if let json = jsonData {
                return NSString(data: json, encoding: NSUTF8StringEncoding)
            }
        }
        return nil
    }
    
    // MARK: Private methods
    
    // fetch value from JSON dictionary
    private func valueFor<N>(key: String) -> N? {
		// key can the form "distance.value", to allow mapping to sub objects
		
		// break down the components of the key and loop through them until we reach the desired object
		let components = key.componentsSeparatedByString(".")
		var index = 0
		var temp = JSONDictionary
		while index < components.count {
			let currentKey = components[index]
			if index == components.count - 1 {
				return temp[currentKey] as? N
			} else {
				if temp[currentKey] is NSNull {
					return nil
				}
				if let dict = temp[currentKey] as [String : AnyObject]? {
					temp = dict
					index++
				} else {
					return nil
				}
			}
		}
		
        return (JSONDictionary[key] as? N)
    }
    
    // convert a JSON String into a Dictionary<String, AnyObject> using NSJSONSerialization
    private func parseJSONDictionary(JSON: String) -> [String : AnyObject]! {
		var parsedJSON: AnyObject? = parseJSONString(JSON)
		if let d: AnyObject = parsedJSON {
			return d as [String : AnyObject]
		}
        return nil
    }
	
	// convert a JSON String into a Array<String, AnyObject> using NSJSONSerialization
	private func parseJSONArray(JSON: String) -> [[String : AnyObject]]! {
		var parsedJSON: AnyObject? = parseJSONString(JSON)
		if let jsonArray = parsedJSON as? [[String : AnyObject]] {
			return jsonArray
		}
		
		return nil
	}
	
	// convert a JSON String into an Object using NSJSONSerialization
	private func parseJSONString(JSON: String) -> AnyObject! {
		var data = JSON.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
		if let data = data {
			var error: NSError?
			var parsedJSON: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &error)
			return parsedJSON
		}
		return nil
	}

}
