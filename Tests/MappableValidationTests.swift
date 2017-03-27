//
//  MappableValidationTests.swift
//  ObjectMapper
//
//  Created by Milen Halachev on 11/14/16.
//  Copyright © 2016 hearst. All rights reserved.
//

import Foundation
import XCTest
import ObjectMapper

class MappableValidationTests: XCTestCase {
	
	/*
	
	Use case:

		We are receiving data with required propoerties that needs to be validated, so
		- every required property should be present, otherwise the whole object becomes invalid.
		- PaymentCard's expiringDate should validated that is is max 3 years in the future
		- PaymentCard.Owner's firstName and lastName should be validated if they are not empty strings.
	
	*/
	
	func testValidMappableValidation() {
		
		let expiringDate = CustomDateFormatTransform(formatString: "dd.MM.yyyy").transformToJSON(Date().adding(years: 2))!
		let JSON = "{\"cardType\":\"visa\",\"owner\":{\"firstName\":\"John\",\"lastName\":\"Smith\"},\"expiringDate\":\"\(expiringDate)\"}"
		let card = Mapper<PaymentCard>().map(JSONString: JSON)
		XCTAssertNotNil(card)
	}
	
	func testInvalidFutureDateMappableValidation() {
		
		let expiringDate = CustomDateFormatTransform(formatString: "dd.MM.yyyy").transformToJSON(Date().adding(years: 5))!
		let JSON = "{\"cardType\":\"visa\",\"owner\":{\"firstName\":\"John\",\"lastName\":\"Smith\"},\"expiringDate\":\"\(expiringDate)\"}"
		let card = Mapper<PaymentCard>().map(JSONString: JSON)
		XCTAssertNil(card)
	}
	
	func testInvalidPastDateMappableValidation() {
		
		let expiringDate = CustomDateFormatTransform(formatString: "dd.MM.yyyy").transformToJSON(Date().adding(years: -5))!
		let JSON = "{\"cardType\":\"visa\",\"owner\":{\"firstName\":\"John\",\"lastName\":\"Smith\"},\"expiringDate\":\"\(expiringDate)\"}"
		let card = Mapper<PaymentCard>().map(JSONString: JSON)
		XCTAssertNil(card)
	}
	
	func testInvalidCardTypeMappableValidation() {
		
		let expiringDate = CustomDateFormatTransform(formatString: "dd.MM.yyyy").transformToJSON(Date().adding(years: 2))!
		let JSON = "{\"cardType\":\"amex\",\"owner\":{\"firstName\":\"John\",\"lastName\":\"Smith\"},\"expiringDate\":\"\(expiringDate)\"}"
		let card = Mapper<PaymentCard>().map(JSONString: JSON)
		XCTAssertNil(card)
	}
	
	func testOwnerNilFirstNameMappableValidation() {
		
		let expiringDate = CustomDateFormatTransform(formatString: "dd.MM.yyyy").transformToJSON(Date().adding(years: 2))!
		let JSON = "{\"cardType\":\"visa\",\"owner\":{\"firstName\":null,\"lastName\":\"Smith\"},\"expiringDate\":\"\(expiringDate)\"}"
		let card = Mapper<PaymentCard>().map(JSONString: JSON)
		XCTAssertNil(card)
	}
	
	func testOwnerMissingLastNameMappableValidation() {
		
		let expiringDate = CustomDateFormatTransform(formatString: "dd.MM.yyyy").transformToJSON(Date().adding(years: 2))!
		let JSON = "{\"cardType\":\"visa\",\"owner\":{\"firstName\":\"John\"},\"expiringDate\":\"\(expiringDate)\"}"
		let card = Mapper<PaymentCard>().map(JSONString: JSON)
		XCTAssertNil(card)
	}
	
	func testOwnerIntervalsLastNameMappableValidation() {
		
		let expiringDate = CustomDateFormatTransform(formatString: "dd.MM.yyyy").transformToJSON(Date().adding(years: 2))!
		let JSON = "{\"cardType\":\"visa\",\"owner\":{\"firstName\":\"John\",\"lastName\":\"   \"},\"expiringDate\":\"\(expiringDate)\"}"
		let card = Mapper<PaymentCard>().map(JSONString: JSON)
		XCTAssertNil(card)
	}
	
	func testOwnerEmptyFirstNameMappableValidation() {
		
		let expiringDate = CustomDateFormatTransform(formatString: "dd.MM.yyyy").transformToJSON(Date().adding(years: 2))!
		let JSON = "{\"cardType\":\"visa\",\"owner\":{\"firstName\":\"\",\"lastName\":\"Smith\"},\"expiringDate\":\"\(expiringDate)\"}"
		let card = Mapper<PaymentCard>().map(JSONString: JSON)
		XCTAssertNil(card)
	}
	
	func testMissingOwnerMappableValidation() {
		
		let expiringDate = CustomDateFormatTransform(formatString: "dd.MM.yyyy").transformToJSON(Date().adding(years: 2))!
		let JSON = "{\"cardType\":\"visa\",\"expiringDate\":\"\(expiringDate)\"}"
		let card = Mapper<PaymentCard>().map(JSONString: JSON)
		XCTAssertNil(card)
	}
	
	func testMissingExpiringDateMappableValidation() {
		
		let JSON = "{\"cardType\":\"visa\",\"owner\":{\"firstName\":\"John\",\"lastName\":\"Smith\"}}"
		let card = Mapper<PaymentCard>().map(JSONString: JSON)
		XCTAssertNil(card)
	}
	
	func testNilCardTypeMappableValidation() {
		
		let expiringDate = CustomDateFormatTransform(formatString: "dd.MM.yyyy").transformToJSON(Date().adding(years: 2))!
		let JSON = "{\"cardType\":null,\"owner\":{\"firstName\":\"John\",\"lastName\":\"Smith\"},\"expiringDate\":\"\(expiringDate)\"}"
		let card = Mapper<PaymentCard>().map(JSONString: JSON)
		XCTAssertNil(card)
	}
}



private class PaymentCard: Mappable {
	
	var cardType: CardType
	var owner: Owner
	var expiringDate: Date
	
	required init?(map: Map) {
		
		//because we use required properties, we have to initialize them to some value that represents undefined and invalid state prior mapping
		self.cardType = .undefined
		self.owner = .undefined
		self.expiringDate = .undefined
	}
	
	func mapping(map: Map) {
	
		self.cardType <- map["cardType"]
		self.owner <- map["owner"]
		self.expiringDate <- (map["expiringDate"], CustomDateFormatTransform(formatString: "dd.MM.yyyy"))
	}
	
	func validateMapping(map: Map) -> Bool {
		
		guard
		
		//we make sure that required properties are not undefined - this usually happens when the values are nil or from different type and the mapper is unable to map them
		self.cardType != .undefined,
		self.owner != .undefined,
		self.expiringDate != .undefined,
			
		//we perform date validation on already mapped Date object, because it is easier
		//we make sure that the date is maximum in 3 years in the future
		let maxDate = Date().adding(years: 3),
		let years = self.expiringDate.years(to: maxDate),
		years >= 0,
		years <= 3
		else {
			
			return false
		}
		
		return true
	}
}

extension PaymentCard {
	
	enum CardType: String {
		
		case visa = "visa"
		case masterCard = "masterCard"
		
		//we need this as default invalid value for initialization
		case undefined = "undefined"
	}

	struct Owner: Mappable {
		
		var firstName: String
		var lastName: String
		
		init(firstName: String, lastName: String) {
			
			self.firstName = firstName
			self.lastName = lastName
		}
		
		init?(map: Map) {
			
			//because we use required properties, we have to initialize them to some value that represents undefined and invalid state prior mapping
			self.firstName = .undefined
			self.lastName = .undefined
		}
		
		mutating func mapping(map: Map) {
			
			self.firstName <- map["firstName"]
			self.lastName <- map["lastName"]
		}
		
		func validateMapping(map: Map) -> Bool {
			
			guard
				
			//we make sure that required properties are not undefined - this usually happens when the values are nil or from different type and the mapper is unable to map them
			self.firstName != .undefined,
			self.lastName != .undefined,
			
			//we make sure that firstName and lastName are not empty strings
			self.firstName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty == false,
			self.lastName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty == false
			else {
				
				return false
			}
			
			return true
		}
	}
}

extension PaymentCard.Owner: Equatable {

	fileprivate static func ==(lhs: PaymentCard.Owner, rhs: PaymentCard.Owner) -> Bool {
		
		return lhs.firstName == rhs.firstName
			&& lhs.lastName == rhs.lastName
	}
}

extension Date {
	
	fileprivate func adding(years: Int, calendar: Calendar = .current) -> Date? {
		
		var components = DateComponents()
		components.year = years
		
		return calendar.date(byAdding: components, to: self)
	}
	
	fileprivate func years(to date: Date, calendar: Calendar = .current) -> Int? {
		
		return calendar.dateComponents([.year], from: self, to: date).year
	}
}

extension PaymentCard.Owner {
	
	//we need this as default invalid value for initialization
	fileprivate static let undefined = PaymentCard.Owner.init(firstName: .undefined, lastName: .undefined)
}

extension String {
	
	//we need this as default invalid value for initialization
	fileprivate static let undefined = NSUUID().uuidString
}

extension Date {

	//we need this as default invalid value for initialization
	fileprivate static let undefined = Date.distantPast
}
