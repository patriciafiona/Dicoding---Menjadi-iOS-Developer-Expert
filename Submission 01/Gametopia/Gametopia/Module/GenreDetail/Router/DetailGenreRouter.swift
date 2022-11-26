//
//  DetailGenreRouter.swift
//  Gametopia
//
//  Created by Patricia Fiona on 26/11/22.
//

import SwiftUI

class DetailGenreRouter {

  func makeDetailView(for id: Int) -> some View {
    let detailUseCase = Injection.init().provideDetail(id: id)
    let presenter = DetailPresenter(detailUseCase: detailUseCase)
    return DetailView(presenter: presenter)
  }
}
