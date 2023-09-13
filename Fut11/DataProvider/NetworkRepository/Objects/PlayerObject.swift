//
//  PlayerObject.swift
//  Fut11
//
//  Created by Felipe Lima on 12/09/23.
//

import Foundation

struct PlayerObject: Codable {
    let team: TeamPlayer
    let players: [Player]
}

struct TeamPlayer: Codable {
    let id: Int
    let name: String
    let logo: String
}

struct Player: Codable {
    let id: Int
    let name: String
    let age: Int?
    let number: Int?
    let position: String
    let photo: String
}
