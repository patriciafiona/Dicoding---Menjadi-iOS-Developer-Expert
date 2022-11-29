//
//  MyFavoriteUseCase.swift
//  Gametopia
//
//  Created by Patricia Fiona on 27/11/22.
//

import Foundation
import Combine

protocol MyFavoriteUseCase {
  func getAllFavorites() -> AnyPublisher<[DetailGameModel], Error>
}

class MyFavoritesInteractor: MyFavoriteUseCase {

  private let repository: GametopiaRepositoryProtocol
  
  required init(repository: GametopiaRepositoryProtocol){
    self.repository = repository
  }

  func getAllFavorites() -> AnyPublisher<[DetailGameModel], Error> {
    return repository.getAllFavoriteGame()
  }

}
