//
//  FieldModel.swift
//  Fut11
//
//  Created by Felipe Lima on 11/09/23.
//

import Foundation
import UIKit

struct Field {
    private(set) var places: [Place]
    private(set) var positions: [Position]
    
    private var playerSize = CGFloat(UIScreen.main.bounds.width * 0.08)
    private var fieldSize = CGSize(width: UIScreen.main.bounds.width * 0.9,
                                  height: UIScreen.main.bounds.height * 0.6)
    
    
    private mutating func setPosition() {
        let fieldWidth = fieldSize.width
        let fieldHeight = fieldSize.height
                
        // GK
        positions.append(Position(CGPoint(x: 0, y: fieldHeight * 0.45)))
        
        // DEF
        positions.append(Position(CGPoint(x: -fieldWidth/2 + playerSize/2 - playerSize/2 + fieldWidth/5/2 - 0.2 * fieldWidth/5, y: fieldHeight * 0.225)))
        positions.append(Position(CGPoint(x: -fieldWidth/2 + playerSize/2 - playerSize/2 + fieldWidth/5/2 + 1.0 * fieldWidth/5, y: fieldHeight * 0.25)))
        positions.append(Position(CGPoint(x: -fieldWidth/2 + playerSize/2 - playerSize/2 + fieldWidth/5/2 + 2.0 * fieldWidth/5, y: fieldHeight * 0.275)))
        positions.append(Position(CGPoint(x: -fieldWidth/2 + playerSize/2 - playerSize/2 + fieldWidth/5/2 + 3.0 * fieldWidth/5, y: fieldHeight * 0.25)))
        positions.append(Position(CGPoint(x: -fieldWidth/2 + playerSize/2 - playerSize/2 + fieldWidth/5/2 + 4.2 * fieldWidth/5, y: fieldHeight * 0.225)))
        
        // MEI
        positions.append(Position(CGPoint(x: -fieldWidth/2 + playerSize/2 - playerSize/2 + fieldWidth/5/2 + 1.1 * fieldWidth/5, y: fieldHeight * 0)))
        positions.append(Position(CGPoint(x: -fieldWidth/2 + playerSize/2 - playerSize/2 + fieldWidth/5/2 + 2.0 * fieldWidth/5, y: fieldHeight * 0.1)))
        positions.append(Position(CGPoint(x: -fieldWidth/2 + playerSize/2 - playerSize/2 + fieldWidth/5/2 + 2.9 * fieldWidth/5, y: fieldHeight * 0)))
        positions.append(Position(CGPoint(x: -fieldWidth/2 + playerSize/2 - playerSize/2 + fieldWidth/5/2 + 0.2 * fieldWidth/5, y: fieldHeight * -0.075)))
        positions.append(Position(CGPoint(x: -fieldWidth/2 + playerSize/2 - playerSize/2 + fieldWidth/5/2 + 2.0 * fieldWidth/5, y: fieldHeight * -0.075)))
        positions.append(Position(CGPoint(x: -fieldWidth/2 + playerSize/2 - playerSize/2 + fieldWidth/5/2 + 3.8 * fieldWidth/5, y: fieldHeight * -0.075)))
        
        // ATA
        positions.append(Position(CGPoint(x: -fieldWidth/2 + playerSize/2 - playerSize/2 + fieldWidth/5/2 + 1.0 * fieldWidth/5, y: fieldHeight * -0.225)))
        positions.append(Position(CGPoint(x: -fieldWidth/2 + playerSize/2 - playerSize/2 + fieldWidth/5/2 + 2.0 * fieldWidth/5, y: fieldHeight * -0.25)))
        positions.append(Position(CGPoint(x: -fieldWidth/2 + playerSize/2 - playerSize/2 + fieldWidth/5/2 + 3.0 * fieldWidth/5, y: fieldHeight * -0.225)))
    }
    
    init(formation: Formation = .fourfourtwo) {
        self.places = []
        self.positions = []

        setPosition()
                
        for index in 0..<11 {
            places.append(Place(position: positions[formation.positions[index]].position))
        }
    }
    
    mutating func changeFormation(_ formation: Formation) {
        for index in 0..<11 {
            places[index].position = positions[formation.positions[index]].position
        }
    }
    
    mutating func addPlayer(_ placeToAdd: Place, player: PlayerModel) {
        if let placeIndex = places.firstIndex(where: { $0.id == placeToAdd.id }) {
            places[placeIndex].player = player
        }
    }
    
    mutating func movePlayer(_ placeToMove: Place, to newPosition: CGPoint) {
        if let placeIndex = places.firstIndex(where: { $0.id == placeToMove.id }) {
            var nearestPositionIndex = 0
            var shortestDistance: CGFloat?
            
            for (index, _) in positions.enumerated() {
                var currentDistance: CGFloat = 0
                
                currentDistance += abs(positions[index].position.x - newPosition.x)
                currentDistance += abs(positions[index].position.y - newPosition.y)
                
                if let minDistance = shortestDistance {
                    if currentDistance < minDistance {
                        shortestDistance = currentDistance
                        nearestPositionIndex = index
                    }
                } else {
                    shortestDistance = currentDistance
                }
            }
            
            var isPositionOccupied = false
            
            for otherPlace in places {
                if otherPlace.position == positions[nearestPositionIndex].position {
                    isPositionOccupied = true
                    break
                }
            }
            
            if !isPositionOccupied {
                places[placeIndex].position = positions[nearestPositionIndex].position
            }
        }
    }
    
    struct Position {
        let id = UUID()
        var position: CGPoint
        
        init(_ position: CGPoint) {
            self.position = position
        }
    }
    
    struct Place: Identifiable {
        let id = UUID()
        var position: CGPoint
        var player: PlayerModel?
    }
    
}
