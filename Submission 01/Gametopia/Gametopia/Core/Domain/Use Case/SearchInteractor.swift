//
//  SearchInteractor.swift
//  Gametopia
//
//  Created by Patricia Fiona on 28/11/22.
//

import Foundation
import Combine

protocol SearchUseCase {
  func getSearchGameResult(keyword: String) -> AnyPublisher<[SearchModel], Error>
}

class SearchInteractor: SearchUseCase {

  private let repository: GametopiaRepositoryProtocol
  
  required init(repository: GametopiaRepositoryProtocol){
    self.repository = repository
  }

  func getSearchGameResult(keyword: String) -> AnyPublisher<[SearchModel], Error> {
    return repository.getSearchGameResult(keyword: keyword)
  }

}
