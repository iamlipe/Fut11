//
//  LeagueStore.swift
//  Fut11
//
//  Created by Felipe Lima on 12/09/23.
//

import Foundation

protocol LeagueStoreProtocol {
    func fetchLeagues(season: String) async throws -> [LeagueObject]
}

class LeagueStore: BaseStore, LeagueStoreProtocol {
    func fetchLeagues(season: String) async throws -> [LeagueObject] {
        guard let urlRequest = try SportsRouter.leagues(season: season).asUrlRequest(method: .get) else {
            throw error
        }
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        let leagues = try LeagueListResult(data: data, response: response).response

        return leagues
    }
}
