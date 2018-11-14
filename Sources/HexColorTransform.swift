//
//  HexColorTransform.swift
//  ObjectMapper
//
//  Created by Vitaliy Kuzmenko on 10/10/16.
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

#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(macOS)
import Cocoa
#endif

#if os(iOS) || os(tvOS) || os(watchOS) || os(macOS)
open class HexColorTransform: TransformType {
	
	#if os(iOS) || os(tvOS) || os(watchOS)
	public typealias Object = UIColor
	#else
	public typealias Object = NSColor
	#endif
	
	public typealias JSON = String
	
	var prefix: Bool = false
	
	var alpha: Bool = false
	
	public init(prefixToJSON: Bool = false, alphaToJSON: Bool = false) {
		alpha = alphaToJSON
		prefix = prefixToJSON
	}
	
	open func transformFromJSON(_ value: Any?) -> Object? {
		if let rgba = value as? String {
			if rgba.hasPrefix("#") {
				let index = rgba.index(rgba.startIndex, offsetBy: 1)
				let hex = String(rgba[index...])
				return getColor(hex: hex)
			} else {
				return getColor(hex: rgba)
			}
		}
		return nil
	}
	
	open func transformToJSON(_ value: Object?) -> JSON? {
		if let value = value {
			return hexString(color: value)
		}
		return nil
	}
	
	fileprivate func hexString(color: Object) -> String {
		let comps = color.cgColor.components!
		let compsCount = color.cgColor.numberOfComponents
		let r: Int
		let g: Int
		var b: Int
		let a = Int(comps[compsCount - 1] * 255)
		if compsCount == 4 { // RGBA
			r = Int(comps[0] * 255)
			g = Int(comps[1] * 255)
			b = Int(comps[2] * 255)
		} else { // Grayscale
			r = Int(comps[0] * 255)
			g = Int(comps[0] * 255)
			b = Int(comps[0] * 255)
		}
		var hexString: String = ""
		if prefix {
			hexString = "#"
		}
		hexString += String(format: "%02X%02X%02X", r, g, b)
		
		if alpha {
			hexString += String(format: "%02X", a)
		}
		return hexString
	}
	
	fileprivate func getColor(hex: String) -> Object? {
		var red: CGFloat   = 0.0
		var green: CGFloat = 0.0
		var blue: CGFloat  = 0.0
		var alpha: CGFloat = 1.0
		
		let scanner = Scanner(string: hex)
		var hexValue: CUnsignedLongLong = 0
		if scanner.scanHexInt64(&hexValue) {
			switch (hex.count) {
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
		#if os(iOS) || os(tvOS) || os(watchOS)
			return UIColor(red: red, green: green, blue: blue, alpha: alpha)
		#else
			return NSColor(red: red, green: green, blue: blue, alpha: alpha)
		#endif
	}
}
#endif
