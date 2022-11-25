//
//  DiscoveryByRatingRouter.swift
//  Gametopia
//
//  Created by Patricia Fiona on 21/11/22.
//

import SwiftUI

class DiscoveryByRatingRouter {

  func makeDetailView(for id: Int) -> some View {
    let detailUseCase = Injection.init().provideDetail(id: id)
    let presenter = DetailPresenter(detailUseCase: detailUseCase)
    return DetailView(presenter: presenter)
  }
  
}
