//
//  DetailGenreInteractor.swift
//  Gametopia
//
//  Created by Patricia Fiona on 25/11/22.
//

import Foundation
import Combine

protocol DetailGenreUseCase {
  func getDetailGenre() -> AnyPublisher<GenreModel, Error>
}

class DetailGenreInteractor: DetailGenreUseCase {

  private let repository: GametopiaRepositoryProtocol
  private let id: Int
  
  required init(repository: GametopiaRepositoryProtocol, id: Int ){
    self.repository = repository
    self.id = id
  }

  func getDetailGenre() -> AnyPublisher<GenreModel, Error> {
    return repository.getGenreDetail(id: id)
  }

}
