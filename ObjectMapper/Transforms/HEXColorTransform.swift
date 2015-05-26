//
//  HEXColorTransform.swift
//  ObjectMapper
//
//  Created by Vitaliy Kuzmenko on 26/05/15.
//  Copyright (c) 2015 hearst. All rights reserved.
//

import UIKit

public class HEXColorTransform: TransformType {
	public typealias Object = UIColor
	public typealias JSON = String
	
	public init() {}
	
	public func transformFromJSON(value: AnyObject?) -> UIColor? {
		if let rgba = value as? String {

			var red: CGFloat   = 0.0
            var green: CGFloat = 0.0
            var blue: CGFloat  = 0.0
            var alpha: CGFloat = 1.0
			
			if rgba.hasPrefix("#") {
				let index   = advance(rgba.startIndex, 1)
				let hex     = rgba.substringFromIndex(index)
				let scanner = NSScanner(string: hex)
				var hexValue: CUnsignedLongLong = 0
				if scanner.scanHexLongLong(&hexValue) {
					switch (count(hex)) {
					case 3:
						red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
						green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
						blue  = CGFloat(hexValue & 0x00F)              / 15.0
					case 4:
						red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
						green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
						blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
						alpha = CGFloat(hexValue & 0x000F)             / 15.0
					case 6:
						red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
						green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
						blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
					case 8:
						red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
						green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
						blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
						alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
					default:
						// Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8
						return nil
					}
				} else {
					// "Scan hex error
					return nil
				}
			} else {
				// Invalid RGB string, missing '#' as prefix
				return nil
			}
			return UIColor(red: red, green: green, blue: blue, alpha: alpha)
		}
		
		return nil
	}
	
	public func transformToJSON(value: UIColor?) -> String? {
		if let color = value {
			let components = CGColorGetComponents(color.CGColor);
			let r = components[0];
			let g = components[1];
			let b = components[2];
			let hexString = String(format: "#%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
			return hexString
		}
		
		return nil
	}
}

