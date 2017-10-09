//
//  MapContextTests.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2016-05-10.
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

import XCTest
import ObjectMapper

class MapContextTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
	// MARK: - BaseMappable
	// MARK: Single
	func testMappingWithContext() {
		let JSON = ["name": "Tristan"]
		let context = Context(shouldMap: true)
		
		let person = Mapper<Person>(context: context).map(JSON: JSON)
		
		XCTAssertNotNil(person)
		XCTAssertNotNil(person?.name)
	}
	
	func testMappingWithContextViaMappableExtension() {
		let JSON = ["name": "Tristan"]
		let context = Context(shouldMap: true)
		
		let person = Person(JSON: JSON, context: context)
		
		XCTAssertNotNil(person)
		XCTAssertNotNil(person?.name)
	}
	
	func testMappingWithoutContext() {
		let JSON = ["name": "Tristan"]
		
		let person = Mapper<Person>().map(JSON: JSON)
		
		XCTAssertNotNil(person)
		XCTAssertNil(person?.name)
	}
	
	// MARK: Nested
	func testNestedMappingWithContext() {
		let JSON = ["person": ["name": "Tristan"]]
		let context = Context(shouldMap: true)
		
		let nestedPerson = Mapper<NestedPerson>(context: context).map(JSON: JSON)
		
		XCTAssertNotNil(nestedPerson)
		XCTAssertNotNil(nestedPerson?.person?.name)
	}
	
	func testNestedMappingWithContextViaMappableExtension() {
		let JSON = ["person": ["name": "Tristan"]]
		let context = Context(shouldMap: true)
		
		let nestedPerson = NestedPerson(JSON: JSON, context: context)
		
		XCTAssertNotNil(nestedPerson)
		XCTAssertNotNil(nestedPerson?.person?.name)
	}

	func testNestedMappingWithoutContext() {
		let JSON = ["person": ["name": "Tristan"]]
		
		let nestedPerson = Mapper<NestedPerson>().map(JSON: JSON)
		
		XCTAssertNotNil(nestedPerson)
		XCTAssertNil(nestedPerson?.person?.name)
	}
	
	// MARK: Array
	func testArrayMappingWithContext() {
		let JSON = ["persons": [["name": "Tristan"], ["name": "Anton"]]]
		let context = Context(shouldMap: true)
		
		let person = Mapper<PersonList>(context: context).map(JSON: JSON)
		
		XCTAssertNotNil(person)
		XCTAssertNotNil(person?.persons)
	}
	
	func testArrayMappingWithContextViaMappableExtension() {
		let JSON = ["persons": [["name": "Tristan"], ["name": "Anton"]]]
		let context = Context(shouldMap: true)
		
		let person = PersonList(JSON: JSON, context: context)
		
		XCTAssertNotNil(person)
		XCTAssertNotNil(person?.persons)
	}
	
	func testArrayMappingWithoutContext() {
		let JSON = ["persons": [["name": "Tristan"], ["name": "Anton"]]]
		
		let person = Mapper<PersonList>().map(JSON: JSON)
		
		XCTAssertNotNil(person)
		XCTAssertNil(person?.persons)
	}
	
	// MARK: ImmutableMappable
	// MARK: Single
	func testImmutableMappingWithContext() {
		let JSON = ["name": "Anton"]
		let context = ImmutableContext(isDeveloper: true)
		
		let person = try? Mapper<ImmutablePerson>(context: context).map(JSON: JSON)
		
		XCTAssertNotNil(person)
		
		XCTAssertEqual(person?.isDeveloper ?? !context.isDeveloper, context.isDeveloper)
	}
	
	func testImmutableMappingWithContextViaMappableExtension() {
		let JSON = ["name": "Anton"]
		let context = ImmutableContext(isDeveloper: true)
		
		let person = try? ImmutablePerson(JSON: JSON, context: context)
		
		XCTAssertNotNil(person)
		XCTAssertEqual(person?.isDeveloper ?? !context.isDeveloper, context.isDeveloper)
	}
	
	func testImmutableMappingWithoutContext() {
		let JSON = ["name": "Anton"]
		
		do {
			let _ = try Mapper<ImmutablePerson>().map(JSON: JSON)
		} catch ImmutablePersonMappingError.contextAbsense {
			// Empty
		} catch {
			XCTFail()
		}
	}
	
	// MARK: Nested
	func testNestedImmutableMappingWithContext() {
		let JSON = ["person": ["name": "Anton"]]
		let context = ImmutableContext(isDeveloper: true)
		
		let nestedPerson = try? Mapper<ImmutableNestedPerson>(context: context).map(JSON: JSON)
		
		XCTAssertNotNil(nestedPerson)
		XCTAssertEqual(nestedPerson?.person.isDeveloper ?? !context.isDeveloper, context.isDeveloper)
	}
	
	func testNestedImmutableMappingWithContextViaMappableExtension() {
		let JSON = ["person": ["name": "Anton"]]
		let context = ImmutableContext(isDeveloper: true)
		
		let nestedPerson = try? ImmutableNestedPerson(JSON: JSON, context: context)
		
		XCTAssertNotNil(nestedPerson)
		XCTAssertEqual(nestedPerson?.person.isDeveloper ?? !context.isDeveloper, context.isDeveloper)
	}
	
	func testNestedImmutableMappingWithoutContext() {
		let JSON = ["person": ["name": "Anton"]]
		
		do {
			let _ = try Mapper<ImmutableNestedPerson>().map(JSON: JSON)
		} catch ImmutablePersonMappingError.contextAbsense {
			return
		} catch {
			XCTFail()
		}
		
		XCTFail()
	}
	
	// MARK: Array
	func testArrayImmutableMappingWithContext() {
		let JSON = ["persons": [["name": "Tristan"], ["name": "Anton"]]]
		let context = ImmutableContext(isDeveloper: true)
		
		let personList = try? Mapper<ImmutablePersonList>(context: context).map(JSON: JSON)
		
		XCTAssertNotNil(personList)
		
		personList?.persons.forEach { person in
			XCTAssertEqual(person.isDeveloper, context.isDeveloper)
		}
	}
	
	func testArrayImmutableMappingWithContextViaMappableExtension() {
		let JSON = ["persons": [["name": "Tristan"], ["name": "Anton"]]]
		let context = ImmutableContext(isDeveloper: true)
		
		let personList = try? ImmutablePersonList(JSON: JSON, context: context)
		
		XCTAssertNotNil(personList)
		
		personList?.persons.forEach { person in
			XCTAssertEqual(person.isDeveloper, context.isDeveloper)
		}
	}
	
	func testArrayImmutableMappingWithoutContext() {
		let JSON = ["persons": [["name": "Tristan"], ["name": "Anton"]]]
		
		do {
			let _ = try Mapper<ImmutablePersonList>().map(JSON: JSON)
		} catch ImmutablePersonMappingError.contextAbsense {
			return
		} catch {
			XCTFail()
		}
		
		XCTFail()
	}
	
	// MARK: - Nested Types
	// MARK: BaseMappable
	struct Context: MapContext {
		var shouldMap = false
		
		init(shouldMap: Bool){
			self.shouldMap = shouldMap
		}
	}
	
	class Person: Mappable {
		var name: String?
		
		required init?(map: Map){
			
		}
		
		func mapping(map: Map) {
			if (map.context as? Context)?.shouldMap == true {
				name <- map["name"]
			}
		}
	}
	
	class NestedPerson: Mappable {
		var person: Person?
		
		required init?(map: Map){
			
		}
		
		func mapping(map: Map) {
			if (map.context as? Context)?.shouldMap == true {
				person <- map["person"]
			}
		}
	}
	
	class PersonList: Mappable {
		var persons: [Person]?
		
		required init?(map: Map){
			
		}
		
		func mapping(map: Map) {
			if (map.context as? Context)?.shouldMap == true {
				persons <- map["persons"]
			}
		}
	}
	
	// MARK: ImmutableMappable
	struct ImmutableContext: MapContext {
		let isDeveloper: Bool
	}
	
	enum ImmutablePersonMappingError: Error {
		case contextAbsense
	}
	
	struct ImmutablePerson: ImmutableMappable {
		let name: String
		let isDeveloper: Bool
		
		init(map: Map) throws {
			guard let context = map.context as? ImmutableContext else {
				throw ImmutablePersonMappingError.contextAbsense
			}
			
			name = try map.value("name")
			isDeveloper = context.isDeveloper
		}
	}
	
	struct ImmutableNestedPerson: ImmutableMappable {
		let person: ImmutablePerson
		
		init(map: Map) throws {
			person = try map.value("person")
		}
	}
	
	struct ImmutablePersonList: ImmutableMappable {
		let persons: [ImmutablePerson]
		
		init(map: Map) throws {
			persons = try map.value("persons")
		}
	}
}
