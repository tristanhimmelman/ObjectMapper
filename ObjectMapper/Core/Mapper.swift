//
//  Mapper.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2014-10-09.
//  Copyright (c) 2014 hearst. All rights reserved.
//

import Foundation

public protocol MapperProtocol {
    class func map(mapper: Mapper, object: Self)
    init()
}

enum MappingType {
    case fromJSON
    case toJSON
}

public class Mapper {
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
    public func map<N: MapperProtocol>(JSON: String, to object: N) -> N! {
        var json = parseJSONString(JSON)
        if let json = json {

            mappingType = .fromJSON
            N.map(self, object: object)
            
            return object
        }
        return nil
    }
    
    // map a JSON string to an object Type that conforms to MapperProtocol
    public func map<N: MapperProtocol>(JSON: String, to type: N.Type) -> N! {
        var json = parseJSONString(JSON)
        if let json = json {
            return map(json, to: type)
        }
        return nil
    }
    
    // maps a JSON dictionary to an object that conforms to MapperProtocol
    public func map<N: MapperProtocol>(JSON: [String : AnyObject], to type: N.Type) -> N! {
        mappingType = .fromJSON

        self.JSONDictionary = JSON
        
        var object = N()
        N.map(self, object: object)
        
        return object
    }
    
    // maps an Object to a JSON dictionary <String : AnyObject>
    public func toJSON<N: MapperProtocol>(object: N) -> [String : AnyObject] {
        mappingType = .toJSON
        
        self.JSONDictionary = [String : AnyObject]()
        N.map(self, object: object)
        
        return self.JSONDictionary
    }
    
    // maps an Object to a JSON string
    public func toJSONString<N: MapperProtocol>(object: N, prettyPrint: Bool) -> String! {
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
		let components = key.componentsSeparatedByString(".")
		var index = 0
		var temp = JSONDictionary
		while index < components.count {
			let currentKey = components[index]
			if index == components.count - 1 {
				return temp[currentKey] as? N
			} else {
				var subDict = temp[currentKey] as [String : AnyObject]?
				if let dict = subDict {
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
    private func parseJSONString(JSON: String) -> [String : AnyObject]! {
        var data = JSON.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        if let data = data {
            var error: NSError?
            var dict: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &error)
            if let d: AnyObject = dict {
                return d as [String : AnyObject]
            }
        }
        return nil
    }
}
