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
      
      SplashView()
        .environmentObject(homePresenter)
    }
    .onChange(of: scenePhase) { phase in
      if phase == .background {
        //perform cleanup
      }
    }
  }
}
