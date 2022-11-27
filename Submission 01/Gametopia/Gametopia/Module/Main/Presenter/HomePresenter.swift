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

  @Published var games: [DetailGameModel] = []
  @Published var gameUpdated: DetailGameModel?
  @Published var genres: [GenreModel] = []
  @Published var developers: [DeveloperModel] = []
  
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false
  @Published var discoveryLoadingState: Bool = false
  
  init(homeUseCase: HomeUseCase) {
    self.homeUseCase = homeUseCase
  }
  
  func getGames() {
    discoveryLoadingState = true
    homeUseCase.getFewDiscoveryGame()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
          print("Get Discovey from API ERROR: \(completion)")
        case .finished:
          self.discoveryLoadingState = false
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
  
  func getDevelopers() {
    loadingState = true
    homeUseCase.getListDevelopers()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
          print("Get Developer ERROR: \(completion)")
        case .finished:
          self.loadingState = false
          print("Get Developer FINISHED")
        }
      }, receiveValue: { developers in
        self.developers = developers
      })
      .store(in: &cancellables)
  }
  
  func updateFavoriteGame(id: Int, isFavorite: Bool){
    homeUseCase.updateFavoriteGame(id: id, isFavorite: isFavorite)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
          print("Update Favorite ERROR: \(completion)")
        case .finished:
          self.discoveryLoadingState = false
          print("Update Favorite FINISHED")
        }
      }, receiveValue: { game in
        self.gameUpdated = game
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
  
  func linkDetailFromDeveloperBuilder<Content: View>(
    for id: Int,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(
      destination: router.makeDetailGameFromDeveloperView(for: id)
    ) { content() }
  }
  
  func discoveryLinkBuilder<Content: View>(
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(
      destination: router.makeDiscoverByRatingView()
    ) { content() }
  }
  
  func genreLinkBuilder<Content: View>(
    for id: Int,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(
      destination: router.makeDetailGenreView(for: id )
    ) { content() }
  }
  
}
