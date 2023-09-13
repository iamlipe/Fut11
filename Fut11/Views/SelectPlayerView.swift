//
//  SelectPlayerView.swift
//  Fut11
//
//  Created by Felipe Lima on 11/09/23.
//

import SwiftUI

protocol SelectPlayerViewDelegate {
    func addPlayer (player: PlayerModel)
    func filterPlayers (_ players: [PlayerModel]) -> [PlayerModel]
}

struct SelectPlayerView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel = ViewModel()
    
    @State var searchText = ""
    @State private var selection: Int?

    var team: Int
    var delegate: SelectPlayerViewDelegate?
    
    var filteredPlayers: [PlayerModel] {
        if let delegate = delegate {
            if searchText.isEmpty {
                return delegate.filterPlayers(viewModel.players)
            } else {
                return delegate.filterPlayers(viewModel.players).filter {
                    $0.name.lowercased().contains(searchText.lowercased())
                }
            }
        } else {
            if searchText.isEmpty {
                return viewModel.players
            } else {
                return viewModel.players.filter {
                    $0.name.lowercased().contains(searchText.lowercased())
                }
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List(filteredPlayers, id: \.id, selection: $selection) { item in
                HStack {
                    AsyncImage(
                        url: URL(string: item.photo),
                        content: { image in
                            image.resizable()
                                 .aspectRatio(contentMode: .fit)
                                 .frame(maxWidth: 36, maxHeight: 36)
                        },
                        placeholder: {
                            ProgressView()
                        }
                    )
                    
                    Text(item.name)
                        .font(.system(size: 16, weight: .semibold))
                        .lineLimit(1)
                    Text(" - ")
                    Text(item.position)
                        .font(.system(size: 16))
                }
                .listRowSeparator(.hidden)
                .tag(item.id)
            }
            .searchable(text: $searchText)
            .navigationTitle("Selecione um Jogador")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                 Button {
                     if let player = viewModel.players.first(where: { $0.id == selection }) {
                         delegate?.addPlayer(player: player)
                     }
                     
                     dismiss()
                 } label: {
                     Text(selection == nil ? "Cancelar" : "OK")
                         .fontWeight(.bold)
                 }
             }
            .onAppear {
                viewModel.doFetchPlayers(team: String(team))
            }
        }
    }
}

struct SelectPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        SelectPlayerView(team: 32)
    }
}
