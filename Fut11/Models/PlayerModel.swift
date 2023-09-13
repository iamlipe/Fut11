//
//  PlayerModel.swift
//  Fut11
//
//  Created by Felipe Lima on 11/09/23.
//

import Foundation

struct PlayerModel: Identifiable, Equatable {
    let id: Int
    let name: String
    let age: Int?
    let position: String
    let photo: String
}
