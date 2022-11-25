//
//  HomeRouter.swift
//  Gametopia
//
//  Created by Patricia Fiona on 19/11/22.
//

import Foundation
import SwiftUI

class HomeRouter {

  func makeDetailView(for id: Int) -> some View {
    let detailUseCase = Injection.init().provideDetail(id: id)
    let presenter = DetailPresenter(detailUseCase: detailUseCase)
    return DetailView(presenter: presenter)
  }
  
  func makeDiscoverByRatingView() -> some View {
    let discoverUseCase = Injection.init().provideDiscoveryByRating()
    let presenter = DiscoveryByRatingPresenter(discoveryByRatingUseCase: discoverUseCase)
    return DiscoveryByRatingView(presenter: presenter)
  }
  
}
