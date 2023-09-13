//
//  TeamStore.swift
//  Fut11
//
//  Created by Felipe Lima on 12/09/23.
//

import Foundation

protocol TeamStoreProtocol {
    func fetchTeams(league: String, season: String) async throws -> [TeamObject]
}

class TeamStore: BaseStore, TeamStoreProtocol {
    func fetchTeams(league: String, season: String) async throws -> [TeamObject] {
        guard let urlRequest = try SportsRouter.teams(league: league, season: season).asUrlRequest(method: .get) else {
            throw error
        }
                
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        let teams = try TeamListResult(data: data, response: response).response

        return teams
    }
}
