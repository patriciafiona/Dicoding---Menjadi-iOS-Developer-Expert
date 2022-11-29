//
//  SearchRouter.swift
//  Gametopia
//
//  Created by Patricia Fiona on 28/11/22.
//

import Foundation
import SwiftUI

class SearchRouter {
  func makeDetailView(for id: Int) -> some View {
    let detailUseCase = Injection.init().provideDetail(id: id, isAdd: true)
    let presenter = DetailPresenter(detailUseCase: detailUseCase)
    return DetailView(presenter: presenter)
  }
}
