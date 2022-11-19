// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

struct GamesResponse: Decodable {
  let games: GameResponse
}

// MARK: - Welcome
struct GameResponse: Decodable {
    let count: Int?
    let next, previous: String?
    let results: [GameResult]?
}

// MARK: - Result
struct GameResult: Decodable {
    let id: Int?
    let name, released: String?
    let background_image: String?
    let rating, rating_top: Double?
    let suggestions_count: Int?
    let updated: String?
    let reviews_count: Int?
    let community_rating: Int?
    let platforms: [Platform]?
    let genres: [Genre]?
    let parent_platforms: [ParentPlatformPlatform]?
}

// MARK: - Platform
struct Platforms: Decodable {
    let platform: Platform?
    let released_at: String?
}

// MARK: - Platform
struct Platform: Decodable {
    let id: Int?
    let name, slug: String?
}

// MARK: - ParentPlatformPlatform
struct ParentPlatformPlatform: Decodable {
    let id: Int?
    let name, slug: String?
}

// MARK: - Genre
struct Genre: Decodable {
    let id: Int?
    let name, slug: String?
    let games_count: Int?
    let image_background: String?
    let language: String?
}
