//
//  TransformType.swift
//  ObjectMapper
//
//  Created by Syo Ikeda on 2/4/15.
//  Copyright (c) 2015 hearst. All rights reserved.
//

public protocol TransformType {
	typealias Object
	typealias JSON

	func transformFromJSON(value: AnyObject?) -> Object?
	func transformToJSON(value: Object?) -> JSON?
}
