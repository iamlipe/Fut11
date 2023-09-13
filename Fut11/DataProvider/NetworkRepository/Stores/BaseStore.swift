//
//  File.swift
//  Fut11
//
//  Created by Felipe Lima on 12/09/23.
//

import Foundation

class BaseStore {
    let error = NSError(domain: "",
                        code: 901,
                        userInfo: [NSLocalizedDescriptionKey: "Error get information"])
}

struct Paging: Codable {
    let current, total: Int
}

struct Parameters: Codable {
    let team: String
}

struct LeagueListResult: Codable {
    let get: String
    let results: Int
    let paging: Paging
    var response: [LeagueObject]
    
    init(data: Data?, response: URLResponse?) throws {
        guard let data = data, let response = response else {
            throw NSError(domain: "",
                          code: 901,
                          userInfo: [NSLocalizedDescriptionKey: "Error get information"])
        }
        
        print("response: \(response)")
        print("data: \(data)")
        
        self = try JSONDecoder().decode(LeagueListResult.self, from: data)
    }
}

struct TeamListResult: Codable {
    let get: String
    let results: Int
    let paging: Paging
    var response: [TeamObject]
    
    init(data: Data?, response: URLResponse?) throws {
        guard let data = data, let response = response else {
            throw NSError(domain: "",
                          code: 901,
                          userInfo: [NSLocalizedDescriptionKey: "Error get information"])
        }
        
        print("response: \(response)")
        print("data: \(data)")
        
        self = try JSONDecoder().decode(TeamListResult.self, from: data)
    }
}

struct PlayerListResult: Codable {
    let get: String
    let results: Int
    let paging: Paging
    var response: [PlayerObject]
    
    init(data: Data?, response: URLResponse?) throws {
        guard let data = data, let response = response else {
            throw NSError(domain: "",
                          code: 901,
                          userInfo: [NSLocalizedDescriptionKey: "Error get information"])
        }
        
        print("response: \(response)")
        print("data: \(data)")
        
        self = try JSONDecoder().decode(PlayerListResult.self, from: data)
    }
}
