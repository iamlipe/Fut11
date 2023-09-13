//
//  SelectPlayerViewModel.swift
//  Fut11
//
//  Created by Felipe Lima on 11/09/23.
//

import Foundation

extension SelectPlayerView {
    @MainActor class ViewModel: ObservableObject, PlayerListDataProviderDelegate {

        @Published var players = [PlayerModel]()
        
        private let dataProviderPlayer = PlayerListDataProvider()
        
        init() {
            self.dataProviderPlayer.delegate = self
        }
        
        func doFetchPlayers(team: String) {
            self.dataProviderPlayer.fetchPlayers(team: team)
            
        }
        
        nonisolated func success(model: [PlayerModel]) {
            DispatchQueue.main.async {
                self.players = model
            }
        }
    }
}
