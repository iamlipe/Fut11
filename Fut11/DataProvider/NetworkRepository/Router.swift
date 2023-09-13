//
//  SportsRouter.swift
//  Fut11
//
//  Created by Felipe Lima on 12/09/23.
//

import Foundation

enum SportsRouter {
    case leagues(season: String)
    case teams(league: String, season: String)
    case players(team: String)
    
    var path: String {
        switch self {
        case .leagues:
            return SportsApi.leagues
        case .teams:
            return SportsApi.teams
        case .players:
            return SportsApi.players
        }
    }
    
    func asUrlRequest(method: HttpMethods) throws -> URLRequest? {
        guard var url = URL(string: SportsApi.baseUrl) else {
            return nil
        }
        
        switch self {
        case .leagues(let season):
            url.append(queryItems: [
                URLQueryItem(name: "season", value: season)
            ])
        case .teams(let league, let season):
            url.append(queryItems: [
                URLQueryItem(name: "league", value: league),
                URLQueryItem(name: "season", value: season)
            ])
        case .players(let team):
            url.append(queryItems: [
                URLQueryItem(name: "team", value: team)
            ])
        }
        
        var request = URLRequest(url: url.appendingPathComponent(path), timeoutInterval: Double.infinity)
        request.httpMethod = method.rawValue
        request.addValue(SportsApi.apiKey, forHTTPHeaderField: "x-rapidapi-key")
        return request
    }
}
