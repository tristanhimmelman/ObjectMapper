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
		
		
		let game = Mapper<Game>().map(jsonDictionary["game"])
		let teams = Mapper<Team>().mapArray(jsonDictionary["teams"])
		
		XCTAssertNotNil(game)

		// 2D Array of Players
		XCTAssertNotNil(game!.players)
			XCTAssertNotEqual(game!.players!.count, 0)
				XCTAssertNotEqual(game!.players!.first!.count, 0)
				XCTAssertNotEqual(game!.players!.last!.count, 0)
		
		// Dictionary of Players
		XCTAssertNotNil(game!.team1Lineup)
			XCTAssertNotEqual(game!.team1Lineup!.count, 0)
		XCTAssertNotNil(game!.team2Lineup)
			XCTAssertNotEqual(game!.team2Lineup!.count, 0)
		
		// Dictionary of [Players]
		XCTAssertNotNil(game!.headToHead)
		for (position, players) in game!.headToHead! {
			XCTAssertNotEqual(players.count, 0, "No players were mapped for \(position)")
		}
		
		// Set of Teams
		XCTAssertNotNil(game!.teams)
			XCTAssertNotEqual(game!.teams!.count, 0)
		
		// Single Instance
		XCTAssertNotNil(game!.winner)
		
		XCTAssertNotNil(teams)
		XCTAssertNotEqual(teams!.count, 0)
		
		// Array of players
		XCTAssertNotNil(teams!.first!.players)
			XCTAssertNotEqual(teams!.first!.players!.count, 0)
	}
	
			
	// MARK: - Internal classes for testing
	class Game: Mappable, URIInitiable {
		var uri: String?
		var time: String?
		var players: [[Player]]?
		var team1Lineup: [String : Player]?
		var team2Lineup: [String : Player]?
		var headToHead: [String : [Player]]?
		var teams: Set<Team>?
		var winner: Team?

		required init(URI: String) {}
		required init?(_ map: Map) {}
		
		func mapping(map: Map) {
			uri <- map["api_uri"]
			time <- map["game_time"]
			
			players <- (map["players"], RelationshipTransform<Player>())			// 2D Array with transform
			team1Lineup <- (map["team1_lineup"], RelationshipTransform<Player>())	// Dictionary with transform
			team2Lineup <- (map["team1_lineup"], RelationshipTransform<Player>())
			headToHead <- (map["head_to_head"], RelationshipTransform<Player>())		// Dictionary of arrays with transform
			teams <- (map["teams"], RelationshipTransform<Team>())					// Set with transform
			winner <- (map["winning_team_url"], RelationshipTransform<Team>())		// Single instance with transform
		}
	}
	
	class Team: NSObject, Mappable, URIInitiable {
		var uri: String?
		var name: String?
		var shortName: String?
		var players: [Player]?
		
		required init(URI: String) {}
		required init?(_ map: Map) {}
		
		func mapping(map: Map) {
			"api_uri"
			"full_name"
			"short_name"
			"players"
			
			uri <- map["api_uri"]
			name <- map["full_name"]
			shortName <- map["short_name"]
			players <- (map["players"], RelationshipTransform<Player>())
		}
	}
	
	class Player: Mappable, URIInitiable {
		var uri: String?
		
		required init(URI: String) {}
		required init?(_ map: Map) {}
		
		func mapping(map: Map) {}
	}
}

protocol URIInitiable {
	init(URI: String)
}

// Yes, this is a little contrived
class RelationshipTransform<ObjectType where ObjectType: protocol<Mappable, URIInitiable>>: TransformType {
	typealias Object = ObjectType
	typealias JSON = [String: AnyObject]
	
	func transformFromJSON(value: AnyObject?) -> Object? {
		guard let URI = value as? String else { return nil }
		let relation = ObjectType(URI: URI)

		return relation
	}
	
	func transformToJSON(value: Object?) -> JSON? {
		return nil
	}
}
