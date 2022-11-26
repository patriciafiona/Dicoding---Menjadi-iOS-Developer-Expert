//
//  GenreMapper.swift
//  Gametopia
//
//  Created by Patricia Fiona on 20/11/22.
//

import Foundation
import RealmSwift

final class GenreMapper {
  
  static func mapGenresResponsesToEntities(
    input genreResponses: [GenreResult]
  ) -> [GenreEntity] {
    return genreResponses.map { result in
      let newGenre = GenreEntity()
      
      newGenre.id = result.id ?? 0
      newGenre.name = result.name ?? "Unknown Name"
      newGenre.slug = result.slug ?? "Unknown Slug"
      newGenre.game_count = result.games_count ?? 0
      newGenre.image_background = result.image_background ?? ""
      let temp = List<GameInGenreEntity>()
      for game in result.games! {
        let gameTemp = GameInGenreEntity()
        gameTemp.id = String(game.id ?? 0)
        gameTemp.added = game.added ?? 0
        gameTemp.slug = game.slug ?? "Unknown Slug"
        gameTemp.name = game.name ?? "Unknown Name"
        
        temp.append(
          gameTemp
        )
      }
      newGenre.games = temp
      return newGenre
    }
  }
  
  static func mapGenresResponsesToEntity(
    input result: DetailGenreResponse
  ) -> GenreEntity {
    let newGenre = GenreEntity()
    
    newGenre.id = result.id ?? 0
    newGenre.name = result.name ?? "Unknown Name"
    newGenre.slug = result.slug ?? "Unknown Slug"
    newGenre.game_count = result.games_count ?? 0
    newGenre.image_background = result.image_background ?? ""
    newGenre.desc = result.description ?? ""
    return newGenre
  }

  static func mapGenresEntitiesToDomains(
    input genreEntities: [GenreEntity]
  ) -> [GenreModel] {
    return genreEntities.map { result in
      return GenreModel(
        id: Int(result.id),
        name: result.name,
        slug: result.slug,
        games_count: result.game_count,
        image_background: result.image_background,
        games: result.games.map { game in
          return GameInGenreModel(
            id: Int(game.id),
            name: game.name,
            slug: game.slug,
            added: game.added
          )
        }
      )
    }
  }
  
  static func mapGenresEntityToDomains(
    input result: GenreEntity
  ) -> GenreModel {
    return GenreModel(
      id: Int(result.id),
      name: result.name,
      slug: result.slug,
      games_count: result.game_count,
      image_background: result.image_background,
      desc: result.desc,
      games: result.games.map { game in
        return GameInGenreModel(
          id: Int(game.id),
          name: game.name,
          slug: game.slug,
          added: game.added
        )
      }
    )
  }
  
  static func mapGenreResponsesToDomains(
    input genreResponses: [GenreResult]
  ) -> [GenreModel] {
    
    return genreResponses.map { result in
      return GenreModel(
        id: result.id ?? 0,
        name: result.name ?? "Unknown Name",
        slug: result.slug ?? "Unknown Slug",
        games_count: result.games_count ?? 0,
        image_background: result.image_background ?? "",
        games: (result.games!) as! [GameInGenreModel]
      )
    }
  }
}
