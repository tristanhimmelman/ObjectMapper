//
//  StringTransform.swift
//  Ridepool
//
//  Created by Li Jiantang on 21/05/2015.
//  Copyright (c) 2015 Carma. All rights reserved.
//

import UIKit

/**
*  Safely make sure value will be string, like userId you are not sure it's Int or String
*/
public class StringTransform: TransformType {
    
    public typealias Object = String
    public typealias JSON = String
    
    public init() {
        
    }
    
    public func transformFromJSON(value: AnyObject?) -> Object? {
        if let value_: AnyObject = value {
            return "\(value_)"
        }
        
        return nil
    }
    
    public func transformToJSON(value: Object?) -> JSON? {
        return value
    }
}
