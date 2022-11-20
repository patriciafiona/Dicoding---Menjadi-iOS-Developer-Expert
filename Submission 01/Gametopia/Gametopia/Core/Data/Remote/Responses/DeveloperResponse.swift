//
//  DeveloperResponse.swift
//  Gametopia
//
//  Created by Patricia Fiona on 20/11/22.
//

import Foundation

// MARK: - Welcome
struct DeveloperResponse: Decodable {
    let count: Int?
    let next, previous: String?
    let results: [DeveloperResult]?
}

// MARK: - Result
struct DeveloperResult: Decodable {
    let id: Int?
    let name, slug: String?
    let games_count: Int?
    let image_background: String?
    let games: [GameInDeveloper]?
}

struct GameInDeveloper: Decodable {
    let id: Int?
    let name, slug: String?
    let added: Int?
}
