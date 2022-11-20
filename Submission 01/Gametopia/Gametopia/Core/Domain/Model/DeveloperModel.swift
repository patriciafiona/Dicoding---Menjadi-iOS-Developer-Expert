//
//  DeveloperModel.swift
//  Gametopia
//
//  Created by Patricia Fiona on 20/11/22.
//

import Foundation

struct DeveloperModel: Equatable, Identifiable {
    let id: Int?
    let name, slug: String?
    let games_count: Int?
    let image_background: String?
    let games: [GameInDeveloperModel]
}

struct GameInDeveloperModel: Equatable, Identifiable {
    let id: Int?
    let name, slug: String?
    let added: Int?
}
