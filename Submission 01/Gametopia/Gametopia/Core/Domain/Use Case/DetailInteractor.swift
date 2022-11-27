//
//  DetailInteractor.swift
//  Gametopia
//
//  Created by Patricia Fiona on 19/11/22.
//

import Foundation
import Combine

protocol DetailUseCase {
  func getDetailGame() -> AnyPublisher<DetailGameModel, Error>
}

class DetailInteractor: DetailUseCase {

  private let repository: GametopiaRepositoryProtocol
  private let id: Int
  private var isAdd: Bool = false
  
  required init(repository: GametopiaRepositoryProtocol, id: Int, isAdd: Bool ){
    self.repository = repository
    self.id = id
    self.isAdd = isAdd
  }

  func getDetailGame() -> AnyPublisher<DetailGameModel, Error> {
    return repository.getGameDetail(id: id, isAdd: self.isAdd)
  }

}
