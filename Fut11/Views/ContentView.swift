//
//  ContentView.swift
//  Fut11
//
//  Created by Felipe Lima on 11/09/23.
//

import SwiftUI

struct ContentView: View {
    @State var selectedLeague: LeagueModel?
    @State var selectedTeam: TeamModel?
    @State var isPresentedSelectedLeague = false
    @State var isPresentedSelectedTeam = false
    @State var canGoToField = false
    @State var isPresentedField = false
    
    var body: some View {
        VStack {
            Image("logo")
                .padding(.bottom, 40)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Liga:")
                    .foregroundColor(.gray)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(.gray, lineWidth: 1)
                        .foregroundColor(.white)
                        .frame(height: 44)
                    
                    HStack {
                        Text(selectedLeague?.name ?? "Selecione...")
                            .foregroundColor(selectedLeague != nil ? .black : .gray)
                            .padding(.horizontal)
                            .lineLimit(1)
                        
                        Spacer()
                                                
                        Image(systemName: "chevron.up.chevron.down")
                            .foregroundColor(.accentColor)
                            .padding(.horizontal)
                    }
                }
            }
            .padding(.bottom, 12)
            .onTapGesture {
                isPresentedSelectedLeague.toggle()
            }
            .sheet(isPresented: $isPresentedSelectedLeague) {
                SelectLeagueView(delegate: self)
            }
            
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Time:")
                    .foregroundColor(.gray)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(.gray, lineWidth: 1)
                        .foregroundColor(.white)
                        .frame(height: 44)
                    
                    HStack {
                        Text(selectedTeam?.name ?? "Selecione...")
                            .foregroundColor(selectedTeam != nil ? .black : .gray)
                            .padding(.horizontal)
                        
                        Spacer()
                                                
                        Image(systemName: "chevron.up.chevron.down")
                            .foregroundColor(selectedLeague != nil ? .accentColor : .gray)
                            .padding(.horizontal)
                    }
                }
            }
            .padding(.bottom, 40)
            .onTapGesture {
                if selectedLeague != nil {
                    isPresentedSelectedTeam.toggle()
                }
            }
            .sheet(isPresented: $isPresentedSelectedTeam) {
                if let league = selectedLeague?.id {
                    SelectTeamView(league: league, delegate: self)
                }
            }
            
            
            Button {
                isPresentedField.toggle()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(canGoToField ? .accentColor : .gray)
                        .frame(width: 120, height: 44)
                    
                    Text("Começar")
                        .foregroundColor(.white)
                }
            }
            .disabled(!canGoToField)
            .fullScreenCover(isPresented: $isPresentedField) {
                if let team = selectedTeam {
                    FieldView(team: team)
                }
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 40)
    }
}

extension ContentView: SelectTeamViewDelegate {
    func selectTeam(_ team: TeamModel) {
        self.selectedTeam = team
        self.canGoToField = true
    }
}

extension ContentView: SelectLeagueViewDelegate {
    func selectLeague(_ league: LeagueModel) {
        self.selectedTeam = nil
        self.canGoToField = false
        self.selectedLeague = league
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
