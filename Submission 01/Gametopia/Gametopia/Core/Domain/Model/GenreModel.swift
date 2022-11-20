//
//  GenreModel.swift
//  Gametopia
//
//  Created by Patricia Fiona on 20/11/22.
//

import Foundation

// MARK: - Result
struct GenreModel: Equatable, Identifiable {
    let id: Int?
    let name, slug: String?
    let games_count: Int?
    let image_background: String?
    let games: [GameInGenreModel]?
}

// MARK: - Game
struct GameInGenreModel: Equatable, Identifiable {
    let id: Int?
    let name, slug: String?
    let added: Int?
}
