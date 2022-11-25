//
//  DiscoveryByRatingPresenter.swift
//  Gametopia
//
//  Created by Patricia Fiona on 21/11/22.
//

import Foundation
import SwiftUI
import Combine

class DiscoveryByRatingPresenter: ObservableObject {
  private var cancellables: Set<AnyCancellable> = []
  private let router = DiscoveryByRatingRouter()
  private let discoveryByRatingUseCase: DiscoveryByRatingUseCase
  
  private static var uniqueKey: String {
      UUID().uuidString
  }
  var options: [GenreFilterDropdownOptionModel]?
  
  @Published var games: [GameModel] = []
  
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false
  
  init(discoveryByRatingUseCase: DiscoveryByRatingUseCase) {
    self.discoveryByRatingUseCase = discoveryByRatingUseCase
    self.options = [
      GenreFilterDropdownOptionModel(key: DiscoveryByRatingPresenter.uniqueKey, value: "Best Rating"),
      GenreFilterDropdownOptionModel(key: DiscoveryByRatingPresenter.uniqueKey, value: "Worst Rating"),
    ]
  }
  
  func getGamesFromBest(isBest: Bool) {
    loadingState = true
    discoveryByRatingUseCase.getAllDiscoveryGame(sortFromBest: isBest)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
          print("Get Game Best/Worst from API ERROR: \(completion)")
        case .finished:
          self.loadingState = false
          print("Get Game Best/Worst from API FINISHED")
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
    destination: router.makeDetailView(for: id)) { content() }
  }
  
}
