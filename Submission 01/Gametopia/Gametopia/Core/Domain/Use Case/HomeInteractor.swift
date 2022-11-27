//
//  HomeInteractor.swift
//  Gametopia
//
//  Created by Patricia Fiona on 19/11/22.
//

import Foundation
import Combine

protocol HomeUseCase {
  func getFewDiscoveryGame() -> AnyPublisher<[DetailGameModel], Error>
  func getListGenres() -> AnyPublisher<[GenreModel], Error>
  func getListDevelopers() -> AnyPublisher<[DeveloperModel], Error>
  func updateFavoriteGame(id: Int, isFavorite: Bool) -> AnyPublisher<DetailGameModel, Error>
}

class HomeInteractor: HomeUseCase {
  private let repository: GametopiaRepositoryProtocol
  
  required init(repository: GametopiaRepositoryProtocol) {
    self.repository = repository
  }
  
  func getFewDiscoveryGame() -> AnyPublisher<[DetailGameModel], Error> {
    return repository.getFewDiscoveryGame()
  }
  
  func getListGenres() -> AnyPublisher<[GenreModel], Error> {
    return repository.getListGenres()
  }
  
  func getListDevelopers() -> AnyPublisher<[DeveloperModel], Error> {
    return repository.getListDevelopers()
  }
  
  func updateFavoriteGame(id: Int, isFavorite: Bool) -> AnyPublisher<DetailGameModel, Error>{
    return repository.updateFavoriteGame(id: id, isFavorite: isFavorite)
  }

}
