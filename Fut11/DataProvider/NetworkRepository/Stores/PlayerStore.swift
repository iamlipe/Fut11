//
//  PlayerStore.swift
//  Fut11
//
//  Created by Felipe Lima on 12/09/23.
//

import Foundation

protocol PlayerStoreProtocol {
    func fetchPlayers(team: String) async throws -> [PlayerObject]
}

class PlayerStore: BaseStore, PlayerStoreProtocol {
    func fetchPlayers(team: String) async throws -> [PlayerObject] {
        guard let urlRequest = try SportsRouter.players(team: team).asUrlRequest(method: .get) else {
            throw error
        }
                
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        let players = try PlayerListResult(data: data, response: response).response

        return players
    }
}
