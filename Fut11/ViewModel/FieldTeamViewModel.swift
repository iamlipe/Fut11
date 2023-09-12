//
//  FieldTeamViewModel.swift
//  Fut11
//
//  Created by Felipe Lima on 12/09/23.
//

import Foundation

class FieldTeam: ObservableObject {
    @Published private var model = Field(formation: .fourfourtwo)
    
    var positions: [Field.Position] {
        return model.positions
    }
    
    var places: [Field.Place] {
        return model.places
    }
    
    var formations: [Formation] {
        return [.fourfourtwo,
                .fourthreethree,
                .fourOneFourOne,
                .fourFiveOne,
                .threeFourThree,
                .threeFiveTwo,
                .threeOneFiveOne,
                .fiveThreeTwo,
                .fiveFourOne]
    }
    
    func movePlayer(_ placeToMove: Field.Place, to: CGPoint) {
        model.movePlayer(placeToMove, to: to)
    }
    
    func addPlayerToPlace(_ placeToAdd: Field.Place, player: Player) {
        model.addPlayer(placeToAdd, player: player)
    }
    
    func changeFormation(_ formation: Formation) {
        model.changeFormation(formation)
    }
}
