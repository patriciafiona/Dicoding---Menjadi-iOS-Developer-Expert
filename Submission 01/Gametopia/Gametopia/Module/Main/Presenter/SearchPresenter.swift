//
//  SearchPresenter.swift
//  Gametopia
//
//  Created by Patricia Fiona on 28/11/22.
//

import SwiftUI
import Combine

class SearchPresenter: ObservableObject {
  private var cancellables: Set<AnyCancellable> = []
  private let router = SearchRouter()
  private let searchUseCase: SearchUseCase

  @Published var results: [SearchModel] = []
  
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false
  
  init(searchUseCase: SearchUseCase) {
    self.searchUseCase = searchUseCase
  }
  
  func getSearchResult(keyword: String) {
    loadingState = true
    searchUseCase.getSearchGameResult(keyword: keyword )
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
          print("Get Search from Remote ERROR: \(completion)")
        case .finished:
          self.loadingState = false
          print("Get Search from Remote FINISHED")
        }
      }, receiveValue: { res in
        self.results = res
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
