//
//  URLTransform.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2014-10-27.
//  Copyright (c) 2014 hearst. All rights reserved.
//

import Foundation

public class URLTransform: TransformType {
	public typealias Object = NSURL
	public typealias JSON = String

	public init() {}

	public func transformFromJSON(value: AnyObject?) -> NSURL? {
		if let URLString = value as? String {
			return NSURL(string: URLString)
		}
		return nil
	}

	public func transformToJSON(value: NSURL?) -> String? {
		if let URL = value {
			return URL.absoluteString
		}
		return nil
	}
}
