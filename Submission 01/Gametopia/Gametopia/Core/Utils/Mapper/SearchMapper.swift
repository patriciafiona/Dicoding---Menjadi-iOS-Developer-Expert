//
//  SearchMapper.swift
//  Gametopia
//
//  Created by Patricia Fiona on 28/11/22.
//

import Foundation

final class SearchMapper {
  static func mapSearchResponsesToDomains(
    input searchResponses: [SearchResult]
  ) -> [SearchModel] {
    
    return searchResponses.map { result in
      return SearchModel(
        id: result.id ?? 0,
        name: result.name ?? "Unknown Name",
        slug: result.slug ?? "Unknown Slug",
        playtime: result.playtime ?? 0,
        released: result.released ?? "Unknown released",
        rating: result.rating ?? 0.0,
        score: result.score ?? "Unknown score",
        backgroundImage: result.backgroundImage ?? ""
      )
    }
  }
}
