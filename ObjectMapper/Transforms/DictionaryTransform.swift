//
//  DictionaryTransform.swift
//  ObjectMapper
//
//  Created by Milen Halachev on 7/20/16.
//  Copyright © 2016 hearst. All rights reserved.
//

import Foundation

///Transforms [String: AnyObject] <-> [Key: Value] where Key is RawRepresentable as String, Value is Mappable
public struct DictionaryTransform<Key, Value>: TransformType where Key: Hashable, Key: RawRepresentable, Key.RawValue == String, Value: Mappable {
	
	public init() {
		
	}
	
	public func transformFromJSON(_ value: Any?) -> [Key: Value]? {
		
		guard let json = value as? [String: Any] else {
			
			return nil
		}
		
		let result = json.reduce([:]) { (result, element) -> [Key: Value] in
			
			guard
			let key = Key(rawValue: element.0),
			let valueJSON = element.1 as? [String: Any],
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
	
	public func transformToJSON(_ value: [Key: Value]?) -> Any? {
		
		let result = value?.reduce([:]) { (result, element) -> [String: Any] in
			
			let key = element.0.rawValue
			let value = element.1.toJSON()
			
			var result = result
			result[key] = value
			return result
		}
		
		return result
	}
}
