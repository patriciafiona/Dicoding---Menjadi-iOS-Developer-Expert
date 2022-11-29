//
//  GametopiaApp.swift
//  Gametopia
//
//  Created by Patricia Fiona on 19/11/22.
//

import SwiftUI

@main
struct GametopiaApp: App {
  @Environment(\.scenePhase) private var scenePhase
  
  var body: some Scene {
    WindowGroup {
      let homeUseCase = Injection.init().provideHome()
      let homePresenter = HomePresenter(homeUseCase: homeUseCase)
      
      let favoriteUseCase = Injection.init().provideMyFavorites()
      let favoritePresenter = FavoritesPresenter(favoriteUseCase: favoriteUseCase)
      
      let seachUseCase = Injection.init().provideSearch()
      let searchPresenter = SearchPresenter(searchUseCase: seachUseCase)
      
      SplashView()
        .environmentObject(homePresenter)
        .environmentObject(favoritePresenter)
        .environmentObject(searchPresenter)
    }
    .onChange(of: scenePhase) { phase in
      if phase == .background {
        //perform cleanup
      }
    }
  }
}
