//
//  GameModel.swift
//  Gametopia
//
//  Created by Patricia Fiona on 19/11/22.
//

import Foundation

struct GameModel: Equatable {
    let id: Int?
    let name, released: String?
    let background_image: String?
    let rating, rating_top: Double?
    let suggestions_count: Int?
    let updated: String?
    let reviews_count: Int?
    let community_rating: Int?
    let platforms: [PlatformModel]?
    let genres: [GenreModel]?
    let parent_platforms: [ParentPlatformPlatformModel]?
}

// MARK: - Platform
struct PlatformsModel: Equatable {
    let platform: PlatformModel?
    let released_at: String?
}

// MARK: - Platform
struct PlatformModel: Equatable, Identifiable {
    let id: Int?
    let name, slug: String?
}

// MARK: - ParentPlatformPlatform
struct ParentPlatformPlatformModel: Equatable, Identifiable {
    let id: Int?
    let name, slug: String?
}

// MARK: - Genre
struct GenreModel: Equatable, Identifiable {
    let id: Int?
    let name, slug: String?
    let games_count: Int?
    let image_background: String?
    let language: String?
}

