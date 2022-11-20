//
//  GenreResponse.swift
//  Gametopia
//
//  Created by Patricia Fiona on 20/11/22.
//

import Foundation

// MARK: - Welcome
struct GenreResponse: Decodable {
    let count: Int?
    let next, previous: String?
    let results: [GenreResult]?
}

// MARK: - Result
struct GenreResult: Decodable {
    let id: Int?
    let name, slug: String?
    let games_count: Int?
    let image_background: String?
    let games: [GameInGenre]?
}

// MARK: - Game
struct GameInGenre: Decodable {
    let id: Int?
    let name, slug: String?
    let added: Int?
}
