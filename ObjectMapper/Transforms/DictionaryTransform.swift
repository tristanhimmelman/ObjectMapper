//
//  DictionaryTransform.swift
//  ObjectMapper
//
//  Created by Milen Halachev on 7/20/16.
//  Copyright © 2016 hearst. All rights reserved.
//

import Foundation

///Transforms [String: AnyObject] <-> [Key: Value] where Key is RawRepresentable as String, Value is Mappable
public struct DictionaryTransform<Key, Value where Key: Hashable, Key: RawRepresentable, Key.RawValue == String, Value: Mappable>: TransformType {
	
	public init() {
		
	}
	
	public func transformFromJSON(value: AnyObject?) -> [Key: Value]? {
		
		guard let json = value as? [String: AnyObject] else {
			
			return nil
		}
		
		let result = json.reduce([:]) { (result, element) -> [Key: Value] in
			
			guard
			let key = Key(rawValue: element.0),
			let valueJSON = element.1 as? [String: AnyObject],
			let value = Value(JSON: valueJSON)
			else {
				
				return result
			}
			
			var result = result
			result[key] = value
			return result
		}
		
		return result
	}
	
	public func transformToJSON(value: [Key: Value]?) -> AnyObject? {
		
		let result = value?.reduce([:]) { (result, element) -> [String: AnyObject] in
			
			let key = element.0.rawValue
			let value = element.1.toJSON()
			
			var result = result
			result[key] = value
			return result
		}
		
		return result
	}
}