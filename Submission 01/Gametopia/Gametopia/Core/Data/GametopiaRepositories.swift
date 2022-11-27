//
//  GametopiaRepositories.swift
//  Gametopia
//
//  Created by Patricia Fiona on 19/11/22.
//

import Foundation
import Combine
 
protocol GametopiaRepositoryProtocol {
  func getAllDiscoveryGame(sortFromBest: Bool) -> AnyPublisher<[GameModel], Error>
  func getFewDiscoveryGame() -> AnyPublisher<[DetailGameModel], Error>
  
  func getListGenres() -> AnyPublisher<[GenreModel], Error>
  func getGenreDetail(id: Int) -> AnyPublisher<GenreModel, Error>
  
  func getListDevelopers() -> AnyPublisher<[DeveloperModel], Error>
  func getGameDetail(id: Int, isAdd: Bool) -> AnyPublisher<DetailGameModel, Error>
  func updateFavoriteGame(id: Int, isFavorite: Bool) -> AnyPublisher<DetailGameModel, Error>
  
  func getAllFavoriteGame() -> AnyPublisher<[DetailGameModel], Error>
}

final class GametopiaRepository: NSObject {
  typealias GametopiaInstance = (LocaleDataSource, RemoteDataSource) -> GametopiaRepository

  fileprivate let remote: RemoteDataSource
  fileprivate let locale: LocaleDataSource

  private init(locale: LocaleDataSource, remote: RemoteDataSource) {
    self.locale = locale
    self.remote = remote
  }

  static let sharedInstance: GametopiaInstance = { localeRepo, remoteRepo in
    return GametopiaRepository(locale: localeRepo, remote: remoteRepo)
  }

}

extension GametopiaRepository: GametopiaRepositoryProtocol {
  
  func getAllFavoriteGame() -> AnyPublisher<[DetailGameModel], Error> {
    return self.locale.getAllFavoriteGames()
      .flatMap { result -> AnyPublisher<[DetailGameModel], Error> in
        return self.locale.getAllFavoriteGames()
          .flatMap { _ in self.locale.getAllFavoriteGames()
            .map { DetailGameMapper.mapDetailGameEntitiesToDomains(input: $0) }
          }
          .eraseToAnyPublisher()
      }.eraseToAnyPublisher()
  }
  
  
  func updateFavoriteGame(id: Int, isFavorite: Bool) -> AnyPublisher<DetailGameModel, Error> {
    return self.locale.getDetailGame(id: id )
      .flatMap { result -> AnyPublisher<DetailGameModel, Error> in
        return self.remote.getGameDetails(id: id)
          .map { DetailGameMapper.mapDetailGameResponsesToEntities(input: $0) }
          .flatMap { res in
            self.locale.updateFavoriteGames(id: res.id, isFavorite: isFavorite)
          }
          .filter { $0 }
          .flatMap { _ in self.locale.getDetailGame(id: id )
            .map { DetailGameMapper.mapDetailGameEntityToDomain(input: $0) }
          }
          .eraseToAnyPublisher()
      }.eraseToAnyPublisher()
  }

  func getAllDiscoveryGame(sortFromBest: Bool) -> AnyPublisher<[GameModel], Error> {
    return self.remote.getAllDiscoveryGame(sortFromBest: sortFromBest)
      .flatMap { result -> AnyPublisher<[GameModel], Error> in
        return self.remote.getAllDiscoveryGame(sortFromBest: sortFromBest )
          .flatMap { _ in self.remote.getAllDiscoveryGame(sortFromBest: sortFromBest )
            .map { GameMapper.mapGameResponsesToDomains(input: $0) }
          }
          .eraseToAnyPublisher()
      }.eraseToAnyPublisher()
  }
  
  func getFewDiscoveryGame() -> AnyPublisher<[DetailGameModel], Error> {
    return self.locale.getBestRatingGames()
      .flatMap { result -> AnyPublisher<[DetailGameModel], Error> in
        if result.isEmpty {
          return self.remote.getFewDiscoveryGame()
            .map { DetailGameMapper.mapDetailGameResponseToEntities(input: $0) }
            .flatMap { self.locale.addGames(from: $0) }
            .filter { $0 }
            .flatMap { _ in self.locale.getBestRatingGames()
              .map { DetailGameMapper.mapDetailGameEntitiesToDomains(input: $0) }
            }
            .eraseToAnyPublisher()
        } else {
          return self.locale.getBestRatingGames()
            .map { DetailGameMapper.mapDetailGameEntitiesToDomains(input: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }
  
  func getListGenres() -> AnyPublisher<[GenreModel], Error> {
    return self.locale.getGenres()
      .flatMap { result -> AnyPublisher<[GenreModel], Error> in
        if result.isEmpty {
          return self.remote.getListGenres()
            .map { GenreMapper.mapGenresResponsesToEntities(input: $0) }
            .flatMap { self.locale.addGenres(from: $0) }
            .filter { $0 }
            .flatMap { _ in self.locale.getGenres()
              .map { GenreMapper.mapGenresEntitiesToDomains(input: $0) }
            }
            .eraseToAnyPublisher()
        } else {
          return self.locale.getGenres()
            .map { GenreMapper.mapGenresEntitiesToDomains(input: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }
  
  func getListDevelopers() -> AnyPublisher<[DeveloperModel], Error> {
    return self.locale.getDevelopers()
      .flatMap { result -> AnyPublisher<[DeveloperModel], Error> in
        if result.isEmpty {
          return self.remote.getListDevelopers()
            .map { DeveloperMapper.mapDevelopersResponsesToEntities(input: $0) }
            .flatMap { self.locale.addDevelopers(from: $0) }
            .filter { $0 }
            .flatMap { _ in self.locale.getDevelopers()
              .map { DeveloperMapper.mapDeveloperEntitiesToDomains(input: $0) }
            }
            .eraseToAnyPublisher()
        } else {
          return self.locale.getDevelopers()
            .map { DeveloperMapper.mapDeveloperEntitiesToDomains(input: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }
  
  func getGameDetail(id: Int, isAdd: Bool = false) -> AnyPublisher<DetailGameModel, Error> {
    return self.locale.getDetailGame(id: id )
      .flatMap { result -> AnyPublisher<DetailGameModel, Error> in
        if result.desc == "" {
          return self.remote.getGameDetails(id: id)
            .map { DetailGameMapper.mapDetailGameResponsesToEntities(input: $0) }
            .flatMap { res in
              if(isAdd){
                return self.locale.addGame(from: res)
              }else{
                return self.locale.updateGames(gameEntity: res)
              }
            }
            .filter { $0 }
            .flatMap { _ in self.locale.getDetailGame(id: id )
              .map { DetailGameMapper.mapDetailGameEntityToDomain(input: $0) }
            }
            .eraseToAnyPublisher()
        } else {
          return self.locale.getDetailGame(id: id )
            .map { DetailGameMapper.mapDetailGameEntityToDomain(input: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }
  
  func getGenreDetail(id: Int) -> AnyPublisher<GenreModel, Error> {
    return self.locale.getDetailGenre(id: id )
      .flatMap { result -> AnyPublisher<GenreModel, Error> in
        if result.desc.elementsEqual("Unknown Description") {
          return self.remote.getGenreDetails(id: id)
            .map { GenreMapper.mapGenresResponsesToEntity(input: $0) }
            .flatMap { res in
              self.locale.updateGenre(id: id, desc: res.desc)
            }
            .filter { $0 }
            .flatMap { _ in self.locale.getDetailGenre(id: id )
              .map { GenreMapper.mapGenresEntityToDomains(input: $0) }
            }
            .eraseToAnyPublisher()
        } else {
          return self.locale.getDetailGenre(id: id )
            .map { GenreMapper.mapGenresEntityToDomains(input: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }
  
}
