//
//  SelectPlayerViewModel.swift
//  Fut11
//
//  Created by Felipe Lima on 11/09/23.
//

import Foundation

class SelectPlayerViewModel: ObservableObject {
    @Published var players: [Player] = [
        Player(name: "Ronaldo", position: "ATA"),
        Player(name: "Ronaldinho", position: "MEI")
    ]
}
