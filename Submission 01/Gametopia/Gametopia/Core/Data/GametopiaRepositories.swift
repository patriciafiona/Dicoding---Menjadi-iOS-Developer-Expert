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
  
  func getFewDiscoveryGame() -> AnyPublisher<[GameModel], Error> {
    return self.remote.getFewDiscoveryGame()
      .flatMap { result -> AnyPublisher<[GameModel], Error> in
        return self.remote.getFewDiscoveryGame()
          .flatMap { _ in self.remote.getFewDiscoveryGame()
            .map { GameMapper.mapGameResponsesToDomains(input: $0) }
          }
          .eraseToAnyPublisher()
      }.eraseToAnyPublisher()
  }
}
