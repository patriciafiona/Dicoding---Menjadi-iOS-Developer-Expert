//
//  FavoritePresenter.swift
//  Gametopia
//
//  Created by Patricia Fiona on 27/11/22.
//

import SwiftUI
import Combine

class FavoritesPresenter: ObservableObject {
  private var cancellables: Set<AnyCancellable> = []
  private let router = FavoriteRouter()
  private let favoriteUseCase: MyFavoriteUseCase

  @Published var games: [DetailGameModel] = []
  
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false
  
  init(favoriteUseCase: MyFavoriteUseCase) {
    self.favoriteUseCase = favoriteUseCase
  }
  
  func getFavoritesGames() {
    loadingState = true
    favoriteUseCase.getAllFavorites()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
          print("Get My Favorites from Database ERROR: \(completion)")
        case .finished:
          self.loadingState = false
          print("Get  My Favorites from Database FINISHED")
        }
      }, receiveValue: { games in
        self.games = games
      })
      .store(in: &cancellables)
  }
  
  func linkBuilder<Content: View>(
    for id: Int,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(
      destination: router.makeDetailView(for: id)
    ) { content() }
  }
  
}

