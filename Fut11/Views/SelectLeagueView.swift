//
//  SelectLeagueView.swift
//  Fut11
//
//  Created by Felipe Lima on 13/09/23.
//

import SwiftUI

protocol SelectLeagueViewDelegate {
    func selectLeague (_ league: LeagueModel)
}

struct SelectLeagueView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel = ViewModel()
    
    @State var searchText = ""
    @State private var selection: Int?

    var delegate: SelectLeagueViewDelegate?
    
    var filteredLeagues: [LeagueModel] {
        if searchText.isEmpty {
            return viewModel.leagues
        }
        
        return viewModel.leagues.filter {
            $0.name.lowercased().contains(searchText.lowercased())
        }
    }
    
    var body: some View {
        NavigationView {
            List(filteredLeagues, id: \.id, selection: $selection) { item in
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
            .navigationTitle("Selecione uma Liga")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                 Button {
                     if let league = viewModel.leagues.first(where: { $0.id == selection }) {
                         delegate?.selectLeague(league)
                     }
                     
                     dismiss()
                 } label: {
                     Text(selection == nil ? "Cancelar" : "OK")
                         .fontWeight(.bold)
                 }
             }
            .onAppear {
                viewModel.doFetchLeagues()
            }
        }
    }
}

struct SelectLeagueView_Previews: PreviewProvider {
    static var previews: some View {
        SelectLeagueView()
    }
}
