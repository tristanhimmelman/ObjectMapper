//
//  CacheManager.swift
//  ObjectMapper
//
//  Created by Zhiji Zhang on 2017/5/13.
//
//  The MIT License (MIT)
//
//  Copyright (c) 2014-2016 Hearst
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

class CacheManager {
	
	//path for cache file
	static private func filePath(_ fileName:String) -> URL?{
		let manager = FileManager.default
		guard let cachePath = manager.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
		let directory = cachePath.appendingPathComponent("ObjectMapperCache")
		if !manager.fileExists(atPath: directory.path){
			do{
				try manager.createDirectory(atPath: directory.path, withIntermediateDirectories: true, attributes: nil)
			}catch{
				return nil
			}
		}
		let path = directory.appendingPathComponent(fileName)
		return path
	}
	
	@discardableResult
	static open func setCache(object:BaseMappable, for fileName: String) -> Bool{
		return setCache(json: object.toJSON(), for: fileName)
	}
	
	/** declare like this,let a:Art = CacheManager.cache(for: "cacheName")
	参照http://stackoverflow.com/questions/27965439/cannot-explicitly-specialize-a-generic-function */
	static open func cache<T: BaseMappable>(for fileName: String) -> T?{
		guard let jsonDict = cacheJson(for: fileName) as? [String: Any] else {return nil}
		return Mapper<T>().map(JSON: jsonDict)
	}
	
	//save as array
	@discardableResult
	static open func setCache(array: [BaseMappable], for fileName: String) -> Bool{
		return self.setCache(json: array.map({$0.toJSON()}), for: fileName)
	}
	
	//get array
	static open func cacheArray<T: BaseMappable>(for fileName: String) -> Array<T>?{
		guard let jsonArray = cacheJson(for: fileName) as? [[String: Any]] else {return nil}
		return Mapper<T>().mapArray(JSONArray: jsonArray)
	}
	
	//save as json
	@discardableResult
	static open func setCache(json: Any, for fileName: String) -> Bool{
		guard let filePath = filePath(fileName) else {return false}
		if let array = json as? [Any]{
			let jsonArray = NSArray(array: array)
			return jsonArray.write(to: filePath, atomically: true)
		}else if let dict = json as? [String: Any]{
			let jsonDict = NSDictionary(dictionary: dict)
			return jsonDict.write(to: filePath, atomically: true)
		}else {
			return false
		}
	}
	
	//get json
	static open func cacheJson(for fileName: String) -> Any?{
		guard let filePath = filePath(fileName) else {return nil}
		if let jsonArray = NSArray(contentsOf: filePath){
			return jsonArray
		}else if let jsonDict = NSDictionary(contentsOf: filePath){
			return jsonDict
		}else{
			return nil
		}
	}
}


