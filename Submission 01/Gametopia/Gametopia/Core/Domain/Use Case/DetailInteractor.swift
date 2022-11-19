//
//  DetailInteractor.swift
//  Gametopia
//
//  Created by Patricia Fiona on 19/11/22.
//

import Foundation

protocol DetailUseCase {

  func getGame() -> GameModel

}

class DetailInteractor: DetailUseCase {

  private let repository: GametopiaRepositoryProtocol
  private let game: GameModel

  required init(
    repository: GametopiaRepositoryProtocol,
    game: GameModel
  ) {
    self.repository = repository
    self.game = game
  }

  func getGame() -> GameModel {
    return game
  }

}
