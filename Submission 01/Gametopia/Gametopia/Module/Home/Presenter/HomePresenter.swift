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
  @Published var genres: [GenreModel] = []
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
          print("Get Discovey from API ERROR: \(completion)")
        case .finished:
          self.loadingState = false
          print("Get Discovey from API FINISHED")
        }
      }, receiveValue: { games in
        self.games = games
      })
      .store(in: &cancellables)
  }
  
  func getGenres() {
    loadingState = true
    homeUseCase.getListGenres()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
          print("Get Genre ERROR: \(completion)")
        case .finished:
          self.loadingState = false
          print("Get Genre FINISHED")
        }
      }, receiveValue: { genres in
        self.genres = genres
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
