//
//  TeamListDataProvider.swift
//  Fut11
//
//  Created by Felipe Lima on 12/09/23.
//

import Foundation

protocol TeamListDataProviderDelegate: DataProviderManagerDelegate {
    func success(model: [TeamModel])
}

class TeamListDataProvider: DataProviderManager<TeamListDataProviderDelegate, [TeamModel]> {
    private var teamStore: TeamStore
    
    init(teamStore: TeamStore = TeamStore()) {
        self.teamStore = teamStore
    }
    
    func fetchTeams(league: String, season: String) {
        Task.init {
            do {
                let object = try await teamStore.fetchTeams(league: league, season: season)
                
                delegate?.success(model: object.map({ data -> TeamModel in
                    return TeamModel(id: data.team.id, name: data.team.name, logo: data.team.logo)
                }))
            } catch {
                delegate?.errorData(delegate, error: error)
            }
        }
    }
}
