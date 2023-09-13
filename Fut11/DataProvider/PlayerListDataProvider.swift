//
//  PlayerListDataProvider.swift
//  Fut11
//
//  Created by Felipe Lima on 13/09/23.
//

import Foundation

protocol PlayerListDataProviderDelegate: DataProviderManagerDelegate {
    func success(model: [PlayerModel])
}

class PlayerListDataProvider: DataProviderManager<PlayerListDataProviderDelegate, [PlayerModel]> {
    private var playerStore: PlayerStore
    
    init(playerStore: PlayerStore = PlayerStore()) {
        self.playerStore = playerStore
    }
    
    func fetchPlayers(team: String) {
        Task.init {
            do {
                let object = try await playerStore.fetchPlayers(team: team).first?.players ?? []
                
                delegate?.success(model: object.map({ data -> PlayerModel in
                    return PlayerModel(id: data.id,
                                       name: data.name,
                                       age: data.age,
                                       position: data.position,
                                       photo: data.photo)
                }))
                
            } catch {
                delegate?.errorData(delegate, error: error)
            }
        }
    }
    
}
