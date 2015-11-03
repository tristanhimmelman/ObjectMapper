//
//  FromJSON.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2014-10-09.
//
//  The MIT License (MIT)
//
//  Copyright (c) 2014-2015 Hearst
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

internal final class FromJSON {
	
	/// Basic type
	class func basicType<FieldType>(inout field: FieldType, object: FieldType?) {
		if let value = object {
			field = value
		}
	}

	/// optional basic type
	class func optionalBasicType<FieldType>(inout field: FieldType?, object: FieldType?) {
		if let value = object {
			field = value
		}
	}

	/// Implicitly unwrapped optional basic type
	class func optionalBasicType<FieldType>(inout field: FieldType!, object: FieldType?) {
		if let value = object {
			field = value
		}
	}

	/// Mappable object
	class func object<N: Mappable>(inout field: N, object: AnyObject?) {
		if let value: N = Mapper().map(object) {
			field = value
		}
	}

	/// Optional Mappable Object
	class func optionalObject<N: Mappable>(inout field: N?, object: AnyObject?) {
		field = Mapper().map(object)
	}

	/// Implicitly unwrapped Optional Mappable Object
	class func optionalObject<N: Mappable>(inout field: N!, object: AnyObject?) {
		field = Mapper().map(object)
	}

	/// mappable object array
	class func objectArray<N: Mappable>(inout field: Array<N>, object: AnyObject?) {
		if let objects = Mapper<N>().mapArray(object) {
			field = objects
		}
	}

	/// optional mappable object array
	class func optionalObjectArray<N: Mappable>(inout field: Array<N>?, object: AnyObject?) {
		field = Mapper().mapArray(object)
	}

	/// Implicitly unwrapped optional mappable object array
	class func optionalObjectArray<N: Mappable>(inout field: Array<N>!, object: AnyObject?) {
		field = Mapper().mapArray(object)
	}
	
	/// mappable object array
	class func twoDimensionalObjectArray<N: Mappable>(inout field: Array<Array<N>>, object: AnyObject?) {
		if let objects = Mapper<N>().mapArrayOfArrays(object) {
			field = objects
		}
	}
	
	/// optional mappable 2 dimentional object array
	class func optionalTwoDimensionalObjectArray<N: Mappable>(inout field: Array<Array<N>>?, object: AnyObject?) {
		field = Mapper().mapArrayOfArrays(object)
	}
	
	/// Implicitly unwrapped optional 2 dimentional mappable object array
	class func optionalTwoDimensionalObjectArray<N: Mappable>(inout field: Array<Array<N>>!, object: AnyObject?) {
		field = Mapper().mapArrayOfArrays(object)
	}
	
	/// Dctionary containing Mappable objects
	class func objectDictionary<N: Mappable>(inout field: Dictionary<String, N>, object: AnyObject?) {
		let parsedObjects = Mapper<N>().mapDictionary(object)

		if let objects = parsedObjects {
			field = objects
		}
	}

	/// Optional dictionary containing Mappable objects
	class func optionalObjectDictionary<N: Mappable>(inout field: Dictionary<String, N>?, object: AnyObject?) {
		field = Mapper().mapDictionary(object)
	}

	/// Implicitly unwrapped Dictionary containing Mappable objects
	class func optionalObjectDictionary<N: Mappable>(inout field: Dictionary<String, N>!, object: AnyObject?) {
		field = Mapper().mapDictionary(object)
	}
	
	/// Dictionary containing Array of Mappable objects
	class func objectDictionaryOfArrays<N: Mappable>(inout field: Dictionary<String, [N]>, object: AnyObject?) {
		let parsedObjects = Mapper<N>().mapDictionaryOfArrays(object)
		
		if let objects = parsedObjects {
			field = objects
		}
	}
	
	/// Optional Dictionary containing Array of Mappable objects
	class func optionalObjectDictionaryOfArrays<N: Mappable>(inout field: Dictionary<String, [N]>?, object: AnyObject?) {
		field = Mapper<N>().mapDictionaryOfArrays(object)
	}
	
	/// Implicitly unwrapped Dictionary containing Array of Mappable objects
	class func optionalObjectDictionaryOfArrays<N: Mappable>(inout field: Dictionary<String, [N]>!, object: AnyObject?) {
		field = Mapper<N>().mapDictionaryOfArrays(object)
	}

	
	/// mappable object Set
	class func objectSet<N: Mappable>(inout field: Set<N>, object: AnyObject?) {
		let parsedObjects = Mapper<N>().mapSet(object)
		
		if let objects = parsedObjects {
			field = objects
		}
	}
	
	/// optional mappable object array
	class func optionalObjectSet<N: Mappable>(inout field: Set<N>?, object: AnyObject?) {
		field = Mapper().mapSet(object)
	}
	
	/// Implicitly unwrapped optional mappable object array
	class func optionalObjectSet<N: Mappable>(inout field: Set<N>!, object: AnyObject?) {
		field = Mapper().mapSet(object)
	}
	
}
