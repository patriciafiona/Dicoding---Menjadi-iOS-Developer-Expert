//
//  GameMapper.swift
//  Gametopia
//
//  Created by Patricia Fiona on 19/11/22.
//

import Foundation

final class GameMapper {
  static func mapGameResponsesToDomains(
    input gameResponses: [GameResult]
  ) -> [GameModel] {
    
    return gameResponses.map { result in
      return GameModel(
        id: result.id ?? 0,
        name: result.name ?? "Unknown Name",
        released: result.released ?? "Unknown Release",
        background_image: result.background_image ?? "",
        rating: result.rating ?? 0.0,
        rating_top: result.rating_top ?? 0.0,
        suggestions_count: result.suggestions_count ?? 0,
        updated: result.updated ?? "Unknown date",
        reviews_count: result.reviews_count ?? 0,
        community_rating: result.community_rating ?? 0,
        platforms: (result.platforms ?? nil) as? [PlatformModel],
        genres: (result.genres ?? nil) as? [GenreInGameModel],
        parent_platforms: (result.parent_platforms ?? nil) as? [ParentPlatformPlatformModel]
      )
    }
  }
}
