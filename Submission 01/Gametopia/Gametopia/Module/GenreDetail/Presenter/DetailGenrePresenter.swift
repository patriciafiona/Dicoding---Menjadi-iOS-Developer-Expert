//
//  GenrePresenter.swift
//  Gametopia
//
//  Created by Patricia Fiona on 25/11/22.
//

import SwiftUI
import Combine

class DetailGenrePresenter: ObservableObject {
  private var cancellables: Set<AnyCancellable> = []
  private let detailGenreUseCase: DetailGenreUseCase
  private let router = DetailGenreRouter()

  @Published var detailGenre: GenreModel? = nil
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false

  init(detailGenreUseCase: DetailGenreUseCase) {
    self.detailGenreUseCase = detailGenreUseCase
  }
  
  func getDetailGenre() {
    loadingState = true
    detailGenreUseCase.getDetailGenre()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
          print("Get Detail Genre from API ERROR: \(completion)")
        case .finished:
          print("Get Detail Genre from API Success")
          self.loadingState = false
        }
      }, receiveValue: { detail in
        self.detailGenre = detail
        print("Detail Genre: \(detail)")
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
