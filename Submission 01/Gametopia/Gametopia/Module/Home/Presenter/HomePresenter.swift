//
//  HomePresenter.swift
//  Gametopia
//
//  Created by Patricia Fiona on 19/11/22.
//

import SwiftUI
import Combine

class HomePresenter: ObservableObject {
  private var cancellables: Set<AnyCancellable> = []
  private let router = HomeRouter()
  private let homeUseCase: HomeUseCase

  @Published var games: [GameModel] = []
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false
  
  init(homeUseCase: HomeUseCase) {
    self.homeUseCase = homeUseCase
  }
  
  func getGames() {
    loadingState = true
    homeUseCase.getFewDiscoveryGame()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
          print("Get from API ERROR: \(completion)")
        case .finished:
          self.loadingState = false
          print("Get from API FINISHED")
        }
      }, receiveValue: { games in
        self.games = games
      })
      .store(in: &cancellables)
  }
  
  func linkBuilder<Content: View>(
    for game: GameModel,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(
    destination: router.makeDetailView(for: game)) { content() }
  }


}
