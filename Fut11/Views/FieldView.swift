//
//  FieldView.swift
//  Fut11
//
//  Created by Felipe Lima on 11/09/23.
//

import SwiftUI

struct FieldView: View {
    @StateObject var viewModel = ViewModel()
    @GestureState private var dragOffset: CGSize = .zero
    @State private var selectedFormation: Formation = .fourfourtwo
    @State private var placeId: UUID?
    @State private var isPresentedSelectPlayer = false
    @State private var selectedPlace: Field.Place? {
        didSet {
            isPresentedSelectPlayer.toggle()
        }
    }
    
    var team: TeamModel
    
    private func takeScreenshot() -> UIImage? {
        // CODE HERE
        
        return nil
    }

    private func shareScreenshot() {
        // CODE HERE
    }
    
    private var field: some View {
        ZStack {
            VStack(spacing: 0) {
                Rectangle()
                    .frame(height: UIScreen.main.bounds.height * 0.1)
                    .foregroundColor(.green)
                    .opacity(0.8)
                Rectangle()
                    .frame(height: UIScreen.main.bounds.height * 0.1)
                    .foregroundColor(.green)
                    .opacity(0.6)
                Rectangle()
                    .frame(height: UIScreen.main.bounds.height * 0.1)
                    .foregroundColor(.green)
                    .opacity(0.8)
                Rectangle()
                    .frame(height: UIScreen.main.bounds.height * 0.1)
                    .foregroundColor(.green)
                    .opacity(0.6)
                Rectangle()
                    .frame(height: UIScreen.main.bounds.height * 0.1)
                    .foregroundColor(.green)
                    .opacity(0.8)
                Rectangle()
                    .frame(height: UIScreen.main.bounds.height * 0.1)
                    .foregroundColor(.green)
                    .opacity(0.6)
                Rectangle()
                    .frame(height: UIScreen.main.bounds.height * 0.1)
                    .foregroundColor(.green)
                    .opacity(0.8)
            }
            
            VStack {
                ZStack {
                    Circle()
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width * 0.02,
                               height: UIScreen.main.bounds.width * 0.02)
                    
                    Rectangle()
                        .stroke(.white, lineWidth: 2)
                        .frame(width: UIScreen.main.bounds.width * 0.5,
                               height: UIScreen.main.bounds.height * 0.125)
                }
                Spacer()
                ZStack {
                    Circle()
                        .stroke(.white, lineWidth: 2)
                        .frame(width: UIScreen.main.bounds.width * 0.3,
                               height: UIScreen.main.bounds.width * 0.3)
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.white)
                    
                    Circle()
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width * 0.04,
                               height: UIScreen.main.bounds.width * 0.04)
                }
                Spacer()
                ZStack {
                    Circle()
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width * 0.02,
                               height: UIScreen.main.bounds.width * 0.02)
                    
                    Rectangle()
                        .stroke(.white, lineWidth: 2)
                        .frame(width: UIScreen.main.bounds.width * 0.5,
                               height: UIScreen.main.bounds.height * 0.125)
                }
            }
        }
        .rotation3DEffect(Angle(degrees: 45), axis: (x: 1, y: 0, z: 0))
    }
    
    private var positions: some View {
        ForEach(viewModel.positions, id: \.id ) { item in
            Image(systemName: "plus.square.dashed")
                .font(.system(size: UIScreen.main.bounds.width * 0.1))
                .foregroundColor(.gray)
                .opacity(dragOffset != .zero ? 0.2 : 0)
                .offset(x: item.position.x)
                .offset(y: item.position.y)
        }
    }
    
    private var players: some View {
        ForEach(viewModel.places, id: \.id) { item in
            VStack(spacing: 2) {
                ZStack {
                    Image(systemName: "tshirt.fill")
                        .font(.system(size: UIScreen.main.bounds.width * 0.1))
                        .foregroundColor(item.player?.name != nil ? .accentColor : .gray)
                        .opacity(0.8)
                }
                
                ZStack {
                    Rectangle()
                        .stroke(.black, lineWidth: 0.7)
                        .frame(width: UIScreen.main.bounds.width * 0.15,
                               height: UIScreen.main.bounds.width * 0.035)
                        .background(.white)

                    
                    Text(item.player?.name ?? "")
                        .foregroundColor(.black)
                        .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .semibold))
                        .frame(maxWidth: UIScreen.main.bounds.width * 0.14)
                        .lineLimit(1)
                }
                
            }
            .offset(x: placeId == item.id ? item.position.x + dragOffset.width : item.position.x,
                    y: placeId == item.id ? item.position.y + dragOffset.height : item.position.y)
            .onTapGesture {
                selectedPlace = item
            }
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, state, _ in
                        state = value.translation
                    }
                    .onChanged { _ in
                        placeId = item.id
                    }
                    .onEnded { value in
                        let newPosition = CGPoint(x: item.position.x + value.translation.width,
                                                  y: item.position.y + value.translation.height)

                        viewModel.movePlayer(item, to: newPosition)

                        placeId = nil
                    }
            )
        }
        .fullScreenCover(isPresented: $isPresentedSelectPlayer) {
            SelectPlayerView(team: team.id,delegate: self)
        }
    }
    
    private var header: some View {
        VStack(spacing: 12) {
            Text(team.name)
                .font(.system(size: UIScreen.main.bounds.width * 0.05,
                              weight: .bold))
            
            AsyncImage(
                url: URL(string: team.logo),
                content: { image in
                    image.resizable()
                         .aspectRatio(contentMode: .fit)
                         .frame(width: UIScreen.main.bounds.width * 0.25,
                                height: UIScreen.main.bounds.width * 0.25)
                },
                placeholder: {
                    ProgressView()
                }
            )
        }
        .frame(width: UIScreen.main.bounds.width * 0.9)
        .offset(y: UIScreen.main.bounds.height * 0.075)
    }
    
    private var formationPicker: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Formação:")
                .font(.system(size: 16,
                              weight: .semibold))
                .foregroundColor(.gray)
            
            ZStack {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(.gray, lineWidth: 1)
                    .frame(width: 100,
                           height: 32)
                    
                Picker("Formações", selection: $selectedFormation) {
                    ForEach(viewModel.formations, id: \.self) { formation in
                        Text(formation.toString()).tag(formation)
                    }
                }
                .pickerStyle(.automatic)
                .onChange(of: selectedFormation) { value in
                    withAnimation {
                        viewModel.changeFormation(value)
                    }
                }
            }
        }
        .padding(.horizontal)
        .offset(y: UIScreen.main.bounds.height * 0.125)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            header
            Spacer()
            formationPicker
            ZStack {
                field
                positions
                players
            }
            .frame(width: UIScreen.main.bounds.width * 0.9,
                   height: UIScreen.main.bounds.height * 0.7)
            .offset(y: UIScreen.main.bounds.height * 0.01)
        }
        .toolbar {
            Button {
                shareScreenshot()
            } label: {
                Image(systemName: "square.and.arrow.up")
            }
        }
    }
}

extension FieldView: SelectPlayerViewDelegate {
    func filterPlayers(_ players: [PlayerModel]) -> [PlayerModel] {
        var filteredPlayers: [PlayerModel] = []

        for player in players {
            let playerNotInPlaces = !viewModel.places.contains(where: {
                $0.player?.name == player.name
            })

            if playerNotInPlaces {
                filteredPlayers.append(player)
            }
        }

        return filteredPlayers
    }
    
    func addPlayer(player: PlayerModel) {
        if let place = self.selectedPlace {
            viewModel.addPlayerToPlace(place, player: player)
        }
    }
}

struct FieldView_Previews: PreviewProvider {
    static var previews: some View {
        FieldView(team: TeamModel(id: 50,
                                  name: "Manchester City",
                                  logo: String("https://media-4.api-sports.io//football//teams//50.png") ))
    }
}
