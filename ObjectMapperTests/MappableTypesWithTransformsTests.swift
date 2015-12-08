//
//  MappableTypesWithTransformsTests.swift
//  ObjectMapper
//
//  Created by Paddy O'Brien on 2015-12-04.
//  Copyright © 2015 hearst. All rights reserved.
//

import XCTest
import ObjectMapper


class MappableTypesWithTransformsTests: XCTestCase {
	func testParsingJSONAPIExample() {
		guard let location = NSBundle(forClass: MappableTypesWithTransformsTests.self).URLForResource("JSONAPI-Article-Example", withExtension: "json") else {
			XCTFail("Unable to find JSON test data: JSONAPI-Article-Example.json")
			return
		}
		
		guard let
			data = NSData(contentsOfURL: location),
			jsonDictionary = (try? NSJSONSerialization.JSONObjectWithData(data, options: [])) as? [String : AnyObject] else {
			XCTFail("Unable to load JSONtest data at \(location)")
			return
		}
		
		
		let articles = Mapper<Article>().mapArray(jsonDictionary["data"])
		
		XCTAssertNotNil(articles)
		XCTAssertNotEqual(articles?.count, 0)
		
		let article = articles!.first!
		XCTAssertNotNil(article.id)
		XCTAssertNotNil(article.title)
		XCTAssertNotNil(article.author)
		XCTAssertNotNil(article.comments)
		XCTAssertNotEqual(article.comments!.count, 0)
	}
	
			
	// MARK: - Internal classes for testing
	class Person: Mappable {
		var id: String?
		var firstName: String?
		var lastName: String?
		var twitter: String?
		
		required init?(_ map: Map) {}
		
		func mapping(map: Map) {
			id <- map["id"]
			firstName <- map["attributes.first-name"]
			lastName <- map["attributes.last-name"]
			twitter <- map["attributes.twitter"]
		}
	}
	
	class Comment: Mappable {
		var id: String?
		var body: String?
		var author: Person?
		
		required init?(_ map: Map) {}
		
		func mapping(map: Map) {
			id <- map["id"]
			body <- map["attributes.body"]
			author <- (map["relationships.author.data"], JSONAPITransform<Person>())
		}
	}
	
	class Article: Mappable {
		var id: String?
		var title: String?
		var author: Person?
		var comments: [Comment]?
		
		required init?(_ map: Map) {}
		
		func mapping(map: Map) {
			id <- map["id"]
			title <- map["attributes.title"]
			author <- (map["relationships.author.data"], JSONAPITransform<Person>())
			comments <- (map["relationships.comments.data"], JSONAPITransform<Comment>())
		}
	}
}


// Yes, this is a little contrived
class JSONAPITransform<ObjectType where ObjectType: Mappable>: TransformType {
	typealias Object = ObjectType
	typealias JSON = [String: AnyObject]
	
	func transformFromJSON(value: AnyObject?) -> Object? {
		let relation = Mapper<ObjectType>().map(value)

		return relation
	}
	
	func transformToJSON(value: Object?) -> JSON? {
		return nil
	}
}
