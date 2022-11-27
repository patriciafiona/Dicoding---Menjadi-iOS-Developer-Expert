//
//  FavoriteRouter.swift
//  Gametopia
//
//  Created by Patricia Fiona on 27/11/22.
//

import Foundation
import SwiftUI

class FavoriteRouter {
  func makeDetailView(for id: Int) -> some View {
    let detailUseCase = Injection.init().provideDetail(id: id)
    let presenter = DetailPresenter(detailUseCase: detailUseCase)
    return DetailView(presenter: presenter)
  }
}
