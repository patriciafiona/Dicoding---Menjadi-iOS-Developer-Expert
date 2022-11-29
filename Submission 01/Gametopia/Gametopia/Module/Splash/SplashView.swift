//
//  SplashView.swift
//  Gametopia
//
//  Created by Patricia Fiona on 19/11/22.
//

import SwiftUI

struct SplashView: View {
  @State var pushNewView: Bool = false
  
  @EnvironmentObject var homePresenter: HomePresenter
  @EnvironmentObject var favoritePresenter: FavoritesPresenter
  @EnvironmentObject var searchPresenter: SearchPresenter
  
  var body: some View {
    NavigationView{
      NavigationLink(isActive: $pushNewView) {
        HomeView(
          homePresenter: homePresenter,
          favoritePresenter: favoritePresenter,
          searchPresenter: searchPresenter
        )
      } label: {
        SplashContent()
      }
      .onAppear {
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
          pushNewView = true
        }
      }
    }
  }
}

struct SplashContent: View{
  @State var isAnimating = false
  var body: some View{
    VStack(alignment: .center){
      Spacer()
      Image("gametopia_icon")
        .resizable()
        .frame(width: 250.0, height: 250.0)
        .animation(
          Animation.easeInOut(duration: 1)
            .repeatForever(autoreverses: true),
          value: isAnimating
        ).onAppear(perform: {
          isAnimating = true
        })
      Spacer().frame(height: 50)
      Text("Gametopia")
        .font(
          Font.custom(
            "VerminVibesV",
            size: 40
          )
        )
        .foregroundColor(Color.white)
      Spacer()
    }
    .background(Color.black)
    .preferredColorScheme(.dark)
  }
}

struct SplashView_Previews: PreviewProvider {
  static var previews: some View {
    SplashView()
  }
}
