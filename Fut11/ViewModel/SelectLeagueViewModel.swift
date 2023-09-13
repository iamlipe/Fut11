//
//  SelectLeagueViewModel.swift
//  Fut11
//
//  Created by Felipe Lima on 13/09/23.
//

import Foundation

extension SelectLeagueView {
    @MainActor class ViewModel: ObservableObject, LeagueListDataProviderDelegate {

        @Published var leagues = [LeagueModel]()
        
        private let dataProviderLeague = LeagueListDataProvider()
        
        init() {
            self.dataProviderLeague.delegate = self
        }
        
        func doFetchLeagues() {
            let date = Date()
            let calendar = Calendar.current
            let year = calendar.component(.year, from: date)
            let yearString = String(format: "%04d", year)
            self.dataProviderLeague.fetchLeagues(season: yearString)
        }
        
        
        nonisolated func success(model: [LeagueModel]) {
            DispatchQueue.main.async {
                self.leagues = model.sorted(by: { $0.name < $1.name  })
            }
        }
    }
}
