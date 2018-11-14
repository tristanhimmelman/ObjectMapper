//
//  DictionaryTransform.swift
//  ObjectMapper
//
//  Created by Milen Halachev on 7/20/16.
//
//  Copyright (c) 2014-2018 Tristan Himmelman
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
