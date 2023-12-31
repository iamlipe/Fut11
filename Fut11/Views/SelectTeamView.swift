//
//  SelectTeamView.swift
//  Fut11
//
//  Created by Felipe Lima on 12/09/23.
//

import SwiftUI

protocol SelectTeamViewDelegate {
    func selectTeam (_ team: TeamModel)
}

struct SelectTeamView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel = ViewModel()
    
    @State var searchText = ""
    @State private var selection: Int?

    var league: Int
    var delegate: SelectTeamViewDelegate?
    
    var filteredTeams: [TeamModel] {
        if searchText.isEmpty {
            return viewModel.teams
        }
        
        return viewModel.teams.filter {
            $0.name.lowercased().contains(searchText.lowercased())
        }
    }
    
    var body: some View {
        NavigationView {
            List(filteredTeams, id: \.id, selection: $selection) { item in
                HStack {
                    AsyncImage(
                        url: URL(string: item.logo),
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
                }
                .listRowSeparator(.hidden)
                .tag(item.id)
            }
            .searchable(text: $searchText)
            .navigationTitle("Selecione um Time")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                 Button {
                     if let team = viewModel.teams.first(where: { $0.id == selection }) {
                         delegate?.selectTeam(team)
                     }
                     
                     dismiss()
                 } label: {
                     Text(selection == nil ? "Cancelar" : "OK")
                         .fontWeight(.bold)
                 }
             }
            .onAppear {
                viewModel.doFetchTeam(league: String(league))
            }
        }
    }
}

struct SelectTeamView_Previews: PreviewProvider {
    static var previews: some View {
        SelectTeamView(league: 33)
    }
}
