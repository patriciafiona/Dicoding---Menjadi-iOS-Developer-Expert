//
//  HomeInteractor.swift
//  Gametopia
//
//  Created by Patricia Fiona on 19/11/22.
//

import Foundation
import Combine

protocol HomeUseCase {
  func getFewDiscoveryGame() -> AnyPublisher<[GameModel], Error>
}

class HomeInteractor: HomeUseCase {
  private let repository: GametopiaRepositoryProtocol
  
  required init(repository: GametopiaRepositoryProtocol) {
    self.repository = repository
  }
  
  func getFewDiscoveryGame() -> AnyPublisher<[GameModel], Error> {
    return repository.getFewDiscoveryGame()
  }

}
