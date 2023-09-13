//
//  LeagueListDataProvider.swift
//  Fut11
//
//  Created by Felipe Lima on 12/09/23.
//

import Foundation

protocol LeagueListDataProviderDelegate: DataProviderManagerDelegate {
    func success(model: [LeagueModel])
}

class LeagueListDataProvider: DataProviderManager<LeagueListDataProviderDelegate, [LeagueModel]> {
    private let leagueStore: LeagueStore
    
    init(leagueStore: LeagueStore = LeagueStore()) {
        self.leagueStore = leagueStore
    }

    func fetchLeagues(season: String) {
        Task.init {
            do {
                let object = try await leagueStore.fetchLeagues(season: season)
                
                delegate?.success(model: object.map ({ data -> LeagueModel in
                    return LeagueModel(id: data.league.id, name: data.league.name, logo: data.league.logo)
                }))
            } catch {
                delegate?.errorData(delegate, error: error)
            }
        }
    }
}
