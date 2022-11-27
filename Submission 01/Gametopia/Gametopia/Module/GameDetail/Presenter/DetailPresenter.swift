//
//  DetailPresenter.swift
//  Gametopia
//
//  Created by Patricia Fiona on 19/11/22.
//

import SwiftUI
import Combine

class DetailPresenter: ObservableObject {
  private var cancellables: Set<AnyCancellable> = []
  private let detailUseCase: DetailUseCase

  @Published var detailGame: DetailGameModel? = nil
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false

  init(detailUseCase: DetailUseCase) {
    self.detailUseCase = detailUseCase
  }
  
  func updateFavoriteGame(id: Int, isFavorite: Bool){
    detailUseCase.updateFavoriteGame(id: id, isFavorite: isFavorite)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
          print("Update Favorite ERROR: \(completion)")
        case .finished:
          print("Update Favorite FINISHED")
        }
      }, receiveValue: { game in
        self.detailGame = game
      })
      .store(in: &cancellables)
  }
  
  func getDetailGame() {
    loadingState = true
    detailUseCase.getDetailGame()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
          print("Get Detail Game from API ERROR: \(completion)")
        case .finished:
          self.loadingState = false
        }
      }, receiveValue: { detail in
        self.detailGame = detail
      })
      .store(in: &cancellables)
  }

}
