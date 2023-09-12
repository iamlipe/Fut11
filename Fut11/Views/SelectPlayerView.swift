//
//  SelectPlayerView.swift
//  Fut11
//
//  Created by Felipe Lima on 11/09/23.
//

import SwiftUI

protocol SelectPlayerViewDelegate {
    func addPlayer (player: Player)
    func filterPlayers (_ players: [Player]) -> [Player]
}

struct SelectPlayerView: View {
    @Environment(\.dismiss) var dismiss
        
    @StateObject var viewModel = SelectPlayerViewModel()
    
    @State private var selection: UUID?
    @State private var searchText = ""
        
    var delegate: SelectPlayerViewDelegate?

    var body: some View {
        NavigationView {
            List(delegate?.filterPlayers(viewModel.players) ?? [], id: \.id, selection: $selection) { item in
                HStack {
                    Text(item.name)
                }
                .tag(item.id)
            }
            .searchable(text: $searchText)
            .navigationTitle("Selecionar Jogador")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    if let playerIndex = viewModel.players.firstIndex(where: { $0.id == selection }) {
                        delegate?.addPlayer(player: viewModel.players[playerIndex])
                    }
                    
                    dismiss()
                } label: {
                    Text("Selecionar")
                }
            }
        }
        
    }
}

struct SelectPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        SelectPlayerView()
    }
}
