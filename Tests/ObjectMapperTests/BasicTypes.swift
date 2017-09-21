//
//  BasicTypes.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2015-02-17.
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
import ObjectMapper

class BasicTypes: Mappable {
	var bool: Bool = true
	var boolOptional: Bool?
	var boolImplicityUnwrapped: Bool!

	var int: Int = 0
	var intOptional: Int?
	var intImplicityUnwrapped: Int!

	var int8: Int8 = 0
	var int8Optional: Int8?
	var int8ImplicityUnwrapped: Int8!

	var int16: Int16 = 0
	var int16Optional: Int16?
	var int16ImplicityUnwrapped: Int16!

	var int32: Int32 = 0
	var int32Optional: Int32?
	var int32ImplicityUnwrapped: Int32!

	var int64: Int64 = 0
	var int64Optional: Int64?
	var int64ImplicityUnwrapped: Int64!

	var uint: UInt = 0
	var uintOptional: UInt?
	var uintImplicityUnwrapped: UInt!

	var uint8: UInt8 = 0
	var uint8Optional: UInt8?
	var uint8ImplicityUnwrapped: UInt8!

	var uint16: UInt16 = 0
	var uint16Optional: UInt16?
	var uint16ImplicityUnwrapped: UInt16!

	var uint32: UInt32 = 0
	var uint32Optional: UInt32?
	var uint32ImplicityUnwrapped: UInt32!

	var uint64: UInt64 = 0
	var uint64Optional: UInt64?
	var uint64ImplicityUnwrapped: UInt64!

	var double: Double = 1.1
	var doubleOptional: Double?
	var doubleImplicityUnwrapped: Double!
	var float: Float = 1.11
	var floatOptional: Float?
	var floatImplicityUnwrapped: Float!
	var string: String = ""
	var stringOptional: String?
	var stringImplicityUnwrapped: String!
	var anyObject: Any = true
	var anyObjectOptional: Any?
	var anyObjectImplicitlyUnwrapped: Any!
	
	var arrayBool: Array<Bool> = []
	var arrayBoolOptional: Array<Bool>?
	var arrayBoolImplicityUnwrapped: Array<Bool>!
	var arrayInt: Array<Int> = []
	var arrayIntOptional: Array<Int>?
	var arrayIntImplicityUnwrapped: Array<Int>!
	var arrayDouble: Array<Double> = []
	var arrayDoubleOptional: Array<Double>?
	var arrayDoubleImplicityUnwrapped: Array<Double>!
	var arrayFloat: Array<Float> = []
	var arrayFloatOptional: Array<Float>?
	var arrayFloatImplicityUnwrapped: Array<Float>!
	var arrayString: Array<String> = []
	var arrayStringOptional: Array<String>?
	var arrayStringImplicityUnwrapped: Array<String>!
	var arrayAnyObject: Array<Any> = []
	var arrayAnyObjectOptional: Array<Any>?
	var arrayAnyObjectImplicitlyUnwrapped: Array<Any>!
	
	var dictBool: Dictionary<String,Bool> = [:]
	var dictBoolOptional: Dictionary<String, Bool>?
	var dictBoolImplicityUnwrapped: Dictionary<String, Bool>!
	var dictInt: Dictionary<String,Int> = [:]
	var dictIntOptional: Dictionary<String,Int>?
	var dictIntImplicityUnwrapped: Dictionary<String,Int>!
	var dictDouble: Dictionary<String,Double> = [:]
	var dictDoubleOptional: Dictionary<String,Double>?
	var dictDoubleImplicityUnwrapped: Dictionary<String,Double>!
	var dictFloat: Dictionary<String,Float> = [:]
	var dictFloatOptional: Dictionary<String,Float>?
	var dictFloatImplicityUnwrapped: Dictionary<String,Float>!
	var dictString: Dictionary<String,String> = [:]
	var dictStringOptional: Dictionary<String,String>?
	var dictStringImplicityUnwrapped: Dictionary<String,String>!
	var dictAnyObject: Dictionary<String, Any> = [:]
	var dictAnyObjectOptional: Dictionary<String, Any>?
	var dictAnyObjectImplicitlyUnwrapped: Dictionary<String, Any>!

	enum EnumInt: Int {
		case Default
		case Another
	}
	var enumInt: EnumInt = .Default
	var enumIntOptional: EnumInt?
	var enumIntImplicitlyUnwrapped: EnumInt!

	enum EnumDouble: Double {
		case Default
		case Another
	}
	var enumDouble: EnumDouble = .Default
	var enumDoubleOptional: EnumDouble?
	var enumDoubleImplicitlyUnwrapped: EnumDouble!

	enum EnumFloat: Float {
		case Default
		case Another
	}
	var enumFloat: EnumFloat = .Default
	var enumFloatOptional: EnumFloat?
	var enumFloatImplicitlyUnwrapped: EnumFloat!

	enum EnumString: String {
		case Default = "Default"
		case Another = "Another"
	}
	var enumString: EnumString = .Default
	var enumStringOptional: EnumString?
	var enumStringImplicitlyUnwrapped: EnumString!

	var arrayEnumInt: [EnumInt] = []
	var arrayEnumIntOptional: [EnumInt]?
	var arrayEnumIntImplicitlyUnwrapped: [EnumInt]!

	var dictEnumInt: [String: EnumInt] = [:]
	var dictEnumIntOptional: [String: EnumInt]?
	var dictEnumIntImplicitlyUnwrapped: [String: EnumInt]!

	init(){
		
	}
	
	required init?(map: Map){

	}
	
	func mapping(map: Map) {
		bool								<- map["bool"]
		boolOptional						<- map["boolOpt"]
		boolImplicityUnwrapped				<- map["boolImp"]

		int									<- map["int"]
		intOptional							<- map["intOpt"]
		intImplicityUnwrapped				<- map["intImp"]

		int8                    			<- map["int8"]
		int8Optional            			<- map["int8Opt"]
		int8ImplicityUnwrapped  			<- map["int8Imp"]

		int16                   			<- map["int16"]
		int16Optional           			<- map["int16Opt"]
		int16ImplicityUnwrapped 			<- map["int16Imp"]

		int32                   			<- map["int32"]
		int32Optional           			<- map["int32Opt"]
		int32ImplicityUnwrapped 			<- map["int32Imp"]

		int64								<- map["int64"]
		int64Optional						<- map["int64Opt"]
		int64ImplicityUnwrapped				<- map["int64Imp"]

		uint								<- map["uint"]
		uintOptional						<- map["uintOpt"]
		uintImplicityUnwrapped				<- map["uintImp"]

		uint8                    			<- map["uint8"]
		uint8Optional            			<- map["uint8Opt"]
		uint8ImplicityUnwrapped  			<- map["uint8Imp"]

		uint16                   			<- map["uint16"]
		uint16Optional           			<- map["uint16Opt"]
		uint16ImplicityUnwrapped 			<- map["uint16Imp"]

		uint32                   			<- map["uint32"]
		uint32Optional           			<- map["uint32Opt"]
		uint32ImplicityUnwrapped 			<- map["uint32Imp"]

		uint64								<- map["uint64"]
		uint64Optional						<- map["uint64Opt"]
		uint64ImplicityUnwrapped			<- map["uint64Imp"]

		double								<- map["double"]
		doubleOptional						<- map["doubleOpt"]
		doubleImplicityUnwrapped			<- map["doubleImp"]
		float								<- map["float"]
		floatOptional						<- map["floatOpt"]
		floatImplicityUnwrapped				<- map["floatImp"]
		string								<- map["string"]
		stringOptional						<- map["stringOpt"]
		stringImplicityUnwrapped			<- map["stringImp"]
		anyObject							<- map["anyObject"]
		anyObjectOptional					<- map["anyObjectOpt"]
		anyObjectImplicitlyUnwrapped		<- map["anyObjectImp"]
		
		arrayBool							<- map["arrayBool"]
		arrayBoolOptional					<- map["arrayBoolOpt"]
		arrayBoolImplicityUnwrapped			<- map["arrayBoolImp"]
		arrayInt							<- map["arrayInt"]
		arrayIntOptional					<- map["arrayIntOpt"]
		arrayIntImplicityUnwrapped			<- map["arrayIntImp"]
		arrayDouble							<- map["arrayDouble"]
		arrayDoubleOptional					<- map["arrayDoubleOpt"]
		arrayDoubleImplicityUnwrapped		<- map["arrayDoubleImp"]
		arrayFloat							<- map["arrayFloat"]
		arrayFloatOptional					<- map["arrayFloatOpt"]
		arrayFloatImplicityUnwrapped		<- map["arrayFloatImp"]
		arrayString							<- map["arrayString"]
		arrayStringOptional					<- map["arrayStringOpt"]
		arrayStringImplicityUnwrapped		<- map["arrayStringImp"]
		arrayAnyObject						<- map["arrayAnyObject"]
		arrayAnyObjectOptional				<- map["arrayAnyObjectOpt"]
		arrayAnyObjectImplicitlyUnwrapped	<- map["arrayAnyObjectImp"]
		
		dictBool							<- map["dictBool"]
		dictBoolOptional					<- map["dictBoolOpt"]
		dictBoolImplicityUnwrapped			<- map["dictBoolImp"]
		dictInt								<- map["dictInt"]
		dictIntOptional						<- map["dictIntOpt"]
		dictIntImplicityUnwrapped			<- map["dictIntImp"]
		dictDouble							<- map["dictDouble"]
		dictDoubleOptional					<- map["dictDoubleOpt"]
		dictDoubleImplicityUnwrapped		<- map["dictDoubleImp"]
		dictFloat							<- map["dictFloat"]
		dictFloatOptional					<- map["dictFloatOpt"]
		dictFloatImplicityUnwrapped			<- map["dictFloatImp"]
		dictString							<- map["dictString"]
		dictStringOptional					<- map["dictStringOpt"]
		dictStringImplicityUnwrapped		<- map["dictStringImp"]
		dictAnyObject						<- map["dictAnyObject"]
		dictAnyObjectOptional				<- map["dictAnyObjectOpt"]
		dictAnyObjectImplicitlyUnwrapped	<- map["dictAnyObjectImp"]

		enumInt								<- map["enumInt"]
		enumIntOptional						<- map["enumIntOpt"]
		enumIntImplicitlyUnwrapped			<- map["enumIntImp"]
		enumDouble							<- map["enumDouble"]
		enumDoubleOptional					<- map["enumDoubleOpt"]
		enumDoubleImplicitlyUnwrapped		<- map["enumDoubleImp"]
		enumFloat							<- map["enumFloat"]
		enumFloatOptional					<- map["enumFloatOpt"]
		enumFloatImplicitlyUnwrapped		<- map["enumFloatImp"]
		enumString							<- map["enumString"]
		enumStringOptional					<- map["enumStringOpt"]
		enumStringImplicitlyUnwrapped		<- map["enumStringImp"]

		arrayEnumInt						<- map["arrayEnumInt"]
		arrayEnumIntOptional				<- map["arrayEnumIntOpt"]
		arrayEnumIntImplicitlyUnwrapped		<- map["arrayEnumIntImp"]
		
		dictEnumInt							<- map["dictEnumInt"]
		dictEnumIntOptional					<- map["dictEnumIntOpt"]
		dictEnumIntImplicitlyUnwrapped		<- map["dictEnumIntImp"]
	}
}

class TestCollectionOfPrimitives: Mappable {
	var dictStringString: [String: String] = [:]
	var dictStringInt: [String: Int] = [:]
	var dictStringBool: [String: Bool] = [:]
	var dictStringDouble: [String: Double] = [:]
	var dictStringFloat: [String: Float] = [:]
	
	var arrayString: [String] = []
	var arrayInt: [Int] = []
	var arrayBool: [Bool] = []
	var arrayDouble: [Double] = []
	var arrayFloat: [Float] = []
	
	init(){
		
	}
	
	required init?(map: Map){
		if map["value"].value() == nil {
			
		}
		if map.JSON["value"] == nil {
			
		}
	}
	
	func mapping(map: Map) {
		dictStringString    <- map["dictStringString"]
		dictStringBool      <- map["dictStringBool"]
		dictStringInt       <- map["dictStringInt"]
		dictStringDouble    <- map["dictStringDouble"]
		dictStringFloat     <- map["dictStringFloat"]
		arrayString         <- map["arrayString"]
		arrayInt            <- map["arrayInt"]
		arrayBool           <- map["arrayBool"]
		arrayDouble         <- map["arrayDouble"]
		arrayFloat          <- map["arrayFloat"]
	}
}
