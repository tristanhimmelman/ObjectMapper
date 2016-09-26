//
//  MappableTypesWithTransformsTests.swift
//  ObjectMapper
//
//  Created by Paddy O'Brien on 2015-12-04.
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


class MappableTypesWithTransformsTests: XCTestCase {
	// This is a func so that it can be collapsed
	func JSONPayload() -> [String: Any] {
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
	
	
	// MARK: - Non-Optional Tests
	func testParsingSingleInstanceWithTransform() {
		let game = Mapper<Game>().map(JSONObject: JSONPayload()["game"])
		
		XCTAssertNotNil(game)
		XCTAssertNotEqual(game!.winner.URI, "FAKE")
	}
	
	func testParsingArrayOfObjectsWithTransform() {
		let teams = Mapper<Team>().mapArray(JSONObject: JSONPayload()["teams"])

		XCTAssertNotNil(teams)
		XCTAssertNotEqual(teams!.count, 0)
		
		XCTAssertNotEqual(teams!.first!.players.count, 0)
	}
	
	func testParsing2DimensionalArrayOfObjectsWithTransform() {
		let game = Mapper<Game>().map(JSONObject: JSONPayload()["game"])

		XCTAssertNotNil(game)
		XCTAssertNotEqual(game!.players.count, 0)
		XCTAssertNotEqual(game!.players.first!.count, 0)
		XCTAssertNotEqual(game!.players.last!.count, 0)
	}
	
	func testParsingDictionaryOfObjectsWithTransform() {
		let game = Mapper<Game>().map(JSONObject: JSONPayload()["game"])

		XCTAssertNotNil(game)
		XCTAssertNotEqual(game!.team1Lineup.count, 0)
		XCTAssertNotEqual(game!.team2Lineup.count, 0)
	}
	
	func testParsingDictionaryOfArrayOfObjectsWithTransform() {
		let game = Mapper<Game>().map(JSONObject: JSONPayload()["game"])
		
		XCTAssertNotNil(game)
		for (position, players) in game!.headToHead {
			XCTAssertNotEqual(players.count, 0, "No players were mapped for \(position)")
		}
	}
	
	func testParsingSetOfObjectsWithTransform() {
		let game = Mapper<Game>().map(JSONObject: JSONPayload()["game"])
		
		XCTAssertNotNil(game)
		XCTAssertNotEqual(game!.teams.count, 0)
	}
	
	
	// MARK: - Optional Tests
	func testParsingOptionalSingleInstanceWithTransform() {
		let game = Mapper<Game>().map(JSONObject: JSONPayload()["game"])
		
		XCTAssertNotNil(game)
		XCTAssertNotNil(game!.O_winner)
	}
	
	func testParsingOptionalArrayOfObjectsWithTransform() {
		let teams = Mapper<Team>().mapArray(JSONObject: JSONPayload()["teams"])
		
		XCTAssertNotNil(teams)
		XCTAssertNotEqual(teams!.count, 0)
		
		XCTAssertNotNil(teams!.first!.O_players)
		XCTAssertNotEqual(teams!.first!.O_players!.count, 0)
	}
	
	func testParsingOptional2DimensionalArrayOfObjectsWithTransform() {
		let game = Mapper<Game>().map(JSONObject: JSONPayload()["game"])
		
		XCTAssertNotNil(game)
		XCTAssertNotNil(game!.O_players)
		XCTAssertNotEqual(game!.O_players!.count, 0)
		XCTAssertNotEqual(game!.O_players!.first!.count, 0)
		XCTAssertNotEqual(game!.O_players!.last!.count, 0)
	}
	
	func testParsingOptionalDictionaryOfObjectsWithTransform() {
		let game = Mapper<Game>().map(JSONObject: JSONPayload()["game"])
		
		XCTAssertNotNil(game)
		XCTAssertNotNil(game!.O_team1Lineup)
		XCTAssertNotEqual(game!.O_team1Lineup!.count, 0)
		XCTAssertNotNil(game!.O_team2Lineup)
		XCTAssertNotEqual(game!.O_team2Lineup!.count, 0)
	}
	
	func testParsingOptionalDictionaryOfArrayOfObjectsWithTransform() {
		let game = Mapper<Game>().map(JSONObject: JSONPayload()["game"])
		
		XCTAssertNotNil(game)
		XCTAssertNotNil(game!.O_headToHead)
		for (position, players) in game!.O_headToHead! {
			XCTAssertNotEqual(players.count, 0, "No players were mapped for \(position)")
		}
	}
	
	func testParsingOptionalSetOfObjectsWithTransform() {
		let game = Mapper<Game>().map(JSONObject: JSONPayload()["game"])
		
		XCTAssertNotNil(game)
		XCTAssertNotNil(game!.O_teams)
		XCTAssertNotEqual(game!.O_teams!.count, 0)
	}

	// MARK: - Implicitly Unwrapped Optional Tests
	func testParsingImplicitlyUnwrappedSingleInstanceWithTransform() {
		let game = Mapper<Game>().map(JSONObject: JSONPayload()["game"])
		
		XCTAssertNotNil(game)
		XCTAssertNotNil(game!.I_winner)
	}
	
	func testParsingImplicitlyUnwrappedArrayOfObjectsWithTransform() {
		let teams = Mapper<Team>().mapArray(JSONObject: JSONPayload()["teams"])
		
		XCTAssertNotNil(teams)
		XCTAssertNotEqual(teams!.count, 0)
		
		XCTAssertNotNil(teams!.first!.I_players)
		XCTAssertNotEqual(teams!.first!.I_players!.count, 0)
	}
	
	func testParsingImplicitlyUnwrapped2DimensionalArrayOfObjectsWithTransform() {
		let game = Mapper<Game>().map(JSONObject: JSONPayload()["game"])
		
		XCTAssertNotNil(game)
		XCTAssertNotNil(game!.I_players)
		XCTAssertNotEqual(game!.I_players!.count, 0)
		XCTAssertNotEqual(game!.I_players!.first!.count, 0)
		XCTAssertNotEqual(game!.I_players!.last!.count, 0)
	}
	
	func testParsingImplicitlyUnwrappedDictionaryOfObjectsWithTransform() {
		let game = Mapper<Game>().map(JSONObject: JSONPayload()["game"])
		
		XCTAssertNotNil(game)
		XCTAssertNotNil(game!.I_team1Lineup)
		XCTAssertNotEqual(game!.I_team1Lineup!.count, 0)
		XCTAssertNotNil(game!.I_team2Lineup)
		XCTAssertNotEqual(game!.I_team2Lineup!.count, 0)
	}
	
	func testParsingImplicitlyUnwrappedDictionaryOfArrayOfObjectsWithTransform() {
		let game = Mapper<Game>().map(JSONObject: JSONPayload()["game"])
		
		XCTAssertNotNil(game)
		XCTAssertNotNil(game!.I_headToHead)
		for (position, players) in game!.I_headToHead! {
			XCTAssertNotEqual(players.count, 0, "No players were mapped for \(position)")
		}
	}
	
	func testParsingImplicitlyUnwrappedSetOfObjectsWithTransform() {
		let game = Mapper<Game>().map(JSONObject: JSONPayload()["game"])
		
		XCTAssertNotNil(game)
		XCTAssertNotNil(game!.I_teams)
		XCTAssertNotEqual(game!.I_teams!.count, 0)
	}

	// MARK: - Internal classes for testing
	class Game: Mappable, URIInitiable {
		var URI: String?
		var players: [[Player]] = [[]]
		var team1Lineup: [String: Player] = [:]
		var team2Lineup: [String: Player] = [:]
		var headToHead: [String: [Player]] = [:]
		var teams: Set<Team> = []
		var winner: Team = Team(URI: "FAKE")

		// Optional
		var O_players: [[Player]]?
		var O_team1Lineup: [String: Player]?
		var O_team2Lineup: [String: Player]?
		var O_headToHead: [String: [Player]]?
		var O_teams: Set<Team>?
		var O_winner: Team?
		
		// Implicitly Unwrapped
		var I_players: [[Player]]!
		var I_team1Lineup: [String: Player]!
		var I_team2Lineup: [String: Player]!
		var I_headToHead: [String: [Player]]!
		var I_teams: Set<Team>!
		var I_winner: Team!
		
		required init(URI: String) { self.URI = URI }
		required init?(map: Map) {}
		
		func mapping(map: Map) {
			players		<- (map["players"], RelationshipTransform<Player>())		// 2D Array with transform
			team1Lineup	<- (map["team1_lineup"], RelationshipTransform<Player>())	// Dictionary with transform
			team2Lineup	<- (map["team1_lineup"], RelationshipTransform<Player>())
			headToHead	<- (map["head_to_head"], RelationshipTransform<Player>())	// Dictionary of arrays with transform
			teams		<- (map["teams"], RelationshipTransform<Team>())			// Set with transform
			winner		<- (map["winning_team_url"], RelationshipTransform<Team>())	// Single instance with transform

			// Optional
			O_players		<- (map["players"], RelationshipTransform<Player>())
			O_team1Lineup	<- (map["team1_lineup"], RelationshipTransform<Player>())
			O_team2Lineup	<- (map["team1_lineup"], RelationshipTransform<Player>())
			O_headToHead	<- (map["head_to_head"], RelationshipTransform<Player>())
			O_teams			<- (map["teams"], RelationshipTransform<Team>())
			O_winner		<- (map["winning_team_url"], RelationshipTransform<Team>())
			
			// Implicitly Unwrapped
			I_players		<- (map["players"], RelationshipTransform<Player>())
			I_team1Lineup	<- (map["team1_lineup"], RelationshipTransform<Player>())
			I_team2Lineup	<- (map["team1_lineup"], RelationshipTransform<Player>())
			I_headToHead	<- (map["head_to_head"], RelationshipTransform<Player>())
			I_teams			<- (map["teams"], RelationshipTransform<Team>())
			I_winner		<- (map["winning_team_url"], RelationshipTransform<Team>())
		}
	}
	
	class Team: NSObject, Mappable, URIInitiable {
		var URI: String?
		var players: [Player] = []
		var O_players: [Player]?
		var I_players: [Player]?
		
		required init(URI: String) { self.URI = URI }
		required init?(map: Map) {}
		
		func mapping(map: Map) {
			players		<- (map["players"], RelationshipTransform<Player>())
			O_players	<- (map["players"], RelationshipTransform<Player>())
			I_players	<- (map["players"], RelationshipTransform<Player>())
		}
	}
	
	class Player: Mappable, URIInitiable {
		required init(URI: String) {}
		required init?(map: Map) {}
		
		func mapping(map: Map) {}
	}
}

protocol URIInitiable {
	init(URI: String)
}

class RelationshipTransform<ObjectType>: TransformType where ObjectType: Mappable & URIInitiable {
	typealias Object = ObjectType
	typealias JSON = [String: AnyObject]
	
	func transformFromJSON(_ value: Any?) -> Object? {
		guard let URI = value as? String else { return nil }
		let relation = ObjectType(URI: URI)
		
		return relation
	}
	
	func transformToJSON(_ value: Object?) -> JSON? {
		return nil
	}
}
