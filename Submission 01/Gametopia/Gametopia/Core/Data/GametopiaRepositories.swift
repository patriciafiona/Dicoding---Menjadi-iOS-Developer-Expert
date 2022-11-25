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
  func getFewDiscoveryGame() -> AnyPublisher<[GameModel], Error>
  
  func getListGenres() -> AnyPublisher<[GenreModel], Error>
  func getListDevelopers() -> AnyPublisher<[DeveloperModel], Error>
  func getGameDetail(id: Int) -> AnyPublisher<DetailGameModel, Error>
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
  
//  func getAllDiscoveryGame(sortFromBest: Bool) -> AnyPublisher<[DetailGameModel], Error> {
//    return self.locale.getGames()
//      .flatMap { result -> AnyPublisher<[DetailGameModel], Error> in
//        if result.isEmpty {
//          self.remote.getAllDiscoveryGame(sortFromBest: sortFromBest )
//            .map {
//              for game in $0 {
//                return self.remote.getGameDetails(id: game.id ?? 0)
//                  .map { detailRes in
//                    DetailGameMapper.mapDetailGameResponsesToEntities(input: detailRes)
//                  }
//                  .flatMap { self.locale.addGames(from: $0) }
//                  .filter { $0 }
//                  .eraseToAnyPublisher()
//              }
//            }
//            .flatMap { _ in self.locale.getGames()
//              .map { DetailGameMapper.mapDetailGameEntitiesToDomains(input: $0) }
//            }
//            .eraseToAnyPublisher()
//        } else {
//          return self.locale.getGames()
//            .map { DetailGameMapper.mapDetailGameEntitiesToDomains(input: $0) }
//            .eraseToAnyPublisher()
//        }
//      }.eraseToAnyPublisher()
//  }
  
  func getFewDiscoveryGame() -> AnyPublisher<[GameModel], Error> {
    return self.remote.getFewDiscoveryGame()
      .flatMap { result -> AnyPublisher<[GameModel], Error> in
        return self.remote.getFewDiscoveryGame()
          .flatMap { _ in self.remote.getFewDiscoveryGame()
            .map { GameMapper.mapGameResponsesToDomains(input: $0 as [GameResult]) }
          }
          .eraseToAnyPublisher()
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
  
//  func getGameDetail(id: Int) -> AnyPublisher<DetailGameModel, Error> {
//    return self.remote.getGameDetails(id: id)
//      .flatMap { result -> AnyPublisher<DetailGameModel, Error> in
//        return self.remote.getGameDetails(id: id)
//          .flatMap { _ in self.remote.getGameDetails(id: id)
//            .map { DetailGameMapper.mapDetailGameResponsesToDomains(input: $0 as DetailGameResponse) }
//          }
//          .eraseToAnyPublisher()
//      }.eraseToAnyPublisher()
//  }
  
  func getGameDetail(id: Int) -> AnyPublisher<DetailGameModel, Error> {
    return self.locale.getDetailGame(id: id )
      .flatMap { result -> AnyPublisher<DetailGameModel, Error> in
        if result.name == "" {
          return self.remote.getGameDetails(id: id)
            .map { DetailGameMapper.mapDetailGameResponsesToEntities(input: $0) }
            .flatMap { self.locale.addGames(from: $0) }
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
    return self.locale.getDetailGame(id: id )
      .flatMap { result -> AnyPublisher<DetailGameModel, Error> in
        if result.name == "" {
          return self.remote.getGameDetails(id: id)
            .map { DetailGameMapper.mapDetailGameResponsesToEntities(input: $0) }
            .flatMap { self.locale.addGames(from: $0) }
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
}
