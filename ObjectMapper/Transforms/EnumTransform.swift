//
//  EnumTransform.swift
//  ObjectMapper
//
//  Created by Kaan Dedeoglu on 3/20/15.
//  Copyright (c) 2015 hearst. All rights reserved.
//

import Foundation

public class EnumTransform<T: RawRepresentable>: TransformType {
	public typealias Object = T
	public typealias JSON = T.RawValue
	
	public init() {}
	
	public func transformFromJSON(value: AnyObject?) -> Object? {
		if let raw = value as? T.RawValue {
			return T(rawValue: raw) ?? nil
		}
		return nil
	}
	
	public func transformToJSON(value: Object?) -> JSON? {
		if let obj = value {
			return obj.rawValue as T.RawValue
		}
		return nil
	}
}