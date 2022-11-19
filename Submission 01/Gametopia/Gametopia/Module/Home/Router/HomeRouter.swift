//
//  HomeRouter.swift
//  Gametopia
//
//  Created by Patricia Fiona on 19/11/22.
//

import Foundation
import SwiftUI

class HomeRouter {

  func makeDetailView(for game: GameModel) -> some View {
    let detailUseCase = Injection.init().provideDetail(game: game)
    let presenter = DetailPresenter(detailUseCase: detailUseCase)
    return DetailView(presenter: presenter)
  }
  
}
