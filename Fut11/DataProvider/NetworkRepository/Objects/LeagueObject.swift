//
//  ListLeaguesObject.swift
//  Fut11
//
//  Created by Felipe Lima on 12/09/23.
    //

import Foundation

struct LeagueObject: Codable {
    let league: League
    let country: Country
    let seasons: [Season]
}

struct League: Codable {
    let id: Int
    let name: String
    let type: String
    let logo: String
}

struct Country: Codable {
    let name: String
    let code: String?
    let flag: String?
}

struct Season: Codable {
    let year: Int
    let start, end: String
    let current: Bool
    let coverage: Coverage
}

struct Coverage: Codable {
    let fixtures: Fixtures
    let standings, players, topScorers, topAssists: Bool
    let topCards, injuries, predictions, odds: Bool

    enum CodingKeys: String, CodingKey {
        case fixtures, standings, players
        case topScorers = "top_scorers"
        case topAssists = "top_assists"
        case topCards = "top_cards"
        case injuries, predictions, odds
    }
}

struct Fixtures: Codable {
    let events, lineups, statisticsFixtures, statisticsPlayers: Bool

    enum CodingKeys: String, CodingKey {
        case events, lineups
        case statisticsFixtures = "statistics_fixtures"
        case statisticsPlayers = "statistics_players"
    }
}
