//
//  PlayerModel.swift
//  Fut11
//
//  Created by Felipe Lima on 11/09/23.
//

import Foundation

struct Player: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var position: String
}
