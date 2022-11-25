//
//  GenrePresenter.swift
//  Gametopia
//
//  Created by Patricia Fiona on 25/11/22.
//

import Foundation

class DetailPresenter: ObservableObject {
  private var cancellables: Set<AnyCancellable> = []
  private let detailGenreUseCase: DetailGenreUseCase

  @Published var detailGenre: GenreModel? = nil
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false

  init(detailGenreUseCase: DetailGenreUseCase) {
    self.detailGenreUseCase = detailGenreUseCase
  }
  
  func getDetailGenre() {
    loadingState = true
    detailGenreUseCase.getDetailGame()
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
