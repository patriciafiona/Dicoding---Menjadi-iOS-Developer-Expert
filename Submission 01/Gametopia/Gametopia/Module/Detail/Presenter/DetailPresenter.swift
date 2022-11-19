//
//  DetailPresenter.swift
//  Gametopia
//
//  Created by Patricia Fiona on 19/11/22.
//

import SwiftUI

class DetailPresenter: ObservableObject {

  private let detailUseCase: DetailUseCase

  @Published var game: GameModel
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false

  init(detailUseCase: DetailUseCase) {
    self.detailUseCase = detailUseCase
    game = detailUseCase.getGame()
  }

}
