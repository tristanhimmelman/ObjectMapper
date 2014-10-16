//
//  Parser.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2014-10-13.
//  Copyright (c) 2014 hearst. All rights reserved.
//

import Foundation

class Parser {
    class func stringToDictionary(string: String) -> [String : AnyObject] {
        let data: NSData = (string as NSString).dataUsingEncoding(NSUTF8StringEncoding)!
        var error: NSError?
        let jsonObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
        var result: [String : AnyObject] = [:]
        for (key,value) in jsonObject {
            let stringKey = key as String
            switch value {
            case is String:
                result[stringKey] = value as String
            case is Int:
                result[stringKey] = value as Int
            case is Bool:
                result[stringKey] = value as Bool
            case is [AnyObject]:
                result[stringKey] = value as [AnyObject]
            case is [String:AnyObject]:
                result[stringKey] = value as [String:AnyObject]
            default:
                println("Value for key \(stringKey): \(value)")
            }
        }
        return result
    }
}
