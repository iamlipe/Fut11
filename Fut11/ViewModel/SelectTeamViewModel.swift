//
//  SelectTeamViewModel.swift
//  Fut11
//
//  Created by Felipe Lima on 13/09/23.
//

import Foundation

extension SelectTeamView {
    @MainActor class ViewModel: ObservableObject, TeamListDataProviderDelegate {

        @Published var teams = [TeamModel]()
        
        private let dataProviderTeam = TeamListDataProvider()
        
        init() {
            self.dataProviderTeam.delegate = self
        }
        
        func doFetchTeam(league: String) {
            let date = Date()
            let calendar = Calendar.current
            let year = calendar.component(.year, from: date)
            let yearString = String(format: "%04d", year)
            self.dataProviderTeam.fetchTeams(league: league, season: yearString)
            
        }
        
        nonisolated func success(model: [TeamModel]) {
            DispatchQueue.main.async {
                self.teams = model.sorted(by: { $0.name < $1.name  })
            }
        }
    }
}
