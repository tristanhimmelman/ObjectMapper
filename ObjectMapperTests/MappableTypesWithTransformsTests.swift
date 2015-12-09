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
	// This is a func so that it can be collapsed
	func JSONPayload() -> [String : AnyObject] {
		return [
			"teams": [[
				"api_uri": "/teams/8",
				"full_name": "Team Secret",
				"short_name": "Secret",
				"players": ["/players/1", "/players/2", "/players/3", "/players/4", "/players/5"]
				], [
					"api_uri": "/teams/43",
					"full_name": "Mineski",
					"short_name": "Mski",
					"players": ["/players/6", "/players/7", "/players/8", "/players/9", "/players/10"]
				]],
			"game": [
				"api_uri": "/games/2723",
				"game_time": "33:49",
				"players": [
					["/players/1", "/players/2", "/players/3", "/players/4", "/players/5"],
					["/players/6", "/players/7", "/players/8", "/players/9", "/players/10"]
				],
				"team1_lineup": [
					"top": "/players/1",
					"mid": "/players/2",
					"bottom": "/players/3",
					"support": "/players/4",
					"carry": "/players/5"
				],
				"team2_lineup": [
					"top": "/players/6",
					"mid": "/players/7",
					"bottom": "/players/8",
					"support": "/players/9",
					"carry": "/players/10"
				],
				"head_to_head": [
					"top": ["/players/1", "/players/6"],
					"mid": ["/players/2", "/players/7"],
					"bottom": ["/players/3", "/players/8"],
					"support": ["/players/4", "/players/9"],
					"carry": ["/players/5", "/players/10"]
				],
				"teams": ["/teams/43", "/teams/8"],
				"winning_team_url": "/teams/8"
			]
		]
	}
	
	func testParsingSingleInstanceWithTransform() {
		let game = Mapper<Game>().map(JSONPayload()["game"])
		
		XCTAssertNotNil(game)
		XCTAssertNotNil(game!.winner)
	}
	
	func testParsingArrayOfObjectsWithTransform() {
		let teams = Mapper<Team>().mapArray(JSONPayload()["teams"])

		XCTAssertNotNil(teams)
		XCTAssertNotEqual(teams!.count, 0)
		
		XCTAssertNotNil(teams!.first!.players)
		XCTAssertNotEqual(teams!.first!.players!.count, 0)
	}
	
	func testParsing2DimensionalArrayOfObjectsWithTransform() {
		let game = Mapper<Game>().map(JSONPayload()["game"])

		XCTAssertNotNil(game)
		XCTAssertNotNil(game!.players)
		XCTAssertNotEqual(game!.players!.count, 0)
		XCTAssertNotEqual(game!.players!.first!.count, 0)
		XCTAssertNotEqual(game!.players!.last!.count, 0)
	}
	
	func testParsingDictionaryOfObjectsWithTransform() {
		let game = Mapper<Game>().map(JSONPayload()["game"])

		XCTAssertNotNil(game)
		XCTAssertNotNil(game!.team1Lineup)
		XCTAssertNotEqual(game!.team1Lineup!.count, 0)
		XCTAssertNotNil(game!.team2Lineup)
		XCTAssertNotEqual(game!.team2Lineup!.count, 0)
	}
	
	func testParsingDictionaryOfArrayOfObjectsWithTransform() {
		let game = Mapper<Game>().map(JSONPayload()["game"])
		
		XCTAssertNotNil(game)
		XCTAssertNotNil(game!.headToHead)
		for (position, players) in game!.headToHead! {
			XCTAssertNotEqual(players.count, 0, "No players were mapped for \(position)")
		}
	}
	
	func testParsingSetOfObjectsWithTransform() {
		let game = Mapper<Game>().map(JSONPayload()["game"])
		
		XCTAssertNotNil(game)
		XCTAssertNotNil(game!.teams)
		XCTAssertNotEqual(game!.teams!.count, 0)
	}
	
	// MARK: - Internal classes for testing
	class Game: Mappable, URIInitiable {
		var players: [[Player]]?
		var team1Lineup: [String : Player]?
		var team2Lineup: [String : Player]?
		var headToHead: [String : [Player]]?
		var teams: Set<Team>?
		var winner: Team?
		
		required init(URI: String) {}
		required init?(_ map: Map) {}
		
		func mapping(map: Map) {
			players <- (map["players"], RelationshipTransform<Player>())			// 2D Array with transform
			team1Lineup <- (map["team1_lineup"], RelationshipTransform<Player>())	// Dictionary with transform
			team2Lineup <- (map["team1_lineup"], RelationshipTransform<Player>())
			headToHead <- (map["head_to_head"], RelationshipTransform<Player>())		// Dictionary of arrays with transform
			teams <- (map["teams"], RelationshipTransform<Team>())					// Set with transform
			winner <- (map["winning_team_url"], RelationshipTransform<Team>())		// Single instance with transform
		}
	}
	
	class Team: NSObject, Mappable, URIInitiable {
		var players: [Player]?
		
		required init(URI: String) {}
		required init?(_ map: Map) {}
		
		func mapping(map: Map) {
			players <- (map["players"], RelationshipTransform<Player>())
		}
	}
	
	class Player: Mappable, URIInitiable {
		required init(URI: String) {}
		required init?(_ map: Map) {}
		
		func mapping(map: Map) {}
	}
}

protocol URIInitiable {
	init(URI: String)
}

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
