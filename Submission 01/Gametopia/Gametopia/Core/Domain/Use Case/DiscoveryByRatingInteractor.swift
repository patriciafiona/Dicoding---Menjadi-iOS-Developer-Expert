//
//  DiscoveryByRatingInteractor.swift
//  Gametopia
//
//  Created by Patricia Fiona on 21/11/22.
//

import Foundation
import Combine

protocol DiscoveryByRatingUseCase {
  func getAllDiscoveryGame(sortFromBest: Bool) -> AnyPublisher<[GameModel], Error>
}

class DiscoveryByRatingInteractor: DiscoveryByRatingUseCase {
  private let repository: GametopiaRepositoryProtocol
  
  required init(repository: GametopiaRepositoryProtocol) {
    self.repository = repository
  }
  
  func getAllDiscoveryGame(sortFromBest: Bool) -> AnyPublisher<[GameModel], Error> {
    return repository.getAllDiscoveryGame(sortFromBest: sortFromBest)
  }
}
