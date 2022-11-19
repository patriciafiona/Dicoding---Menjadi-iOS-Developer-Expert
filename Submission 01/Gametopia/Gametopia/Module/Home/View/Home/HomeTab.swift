//
//  HomeTab.swift
//  Gametopia
//
//  Created by Patricia Fiona on 19/11/22.
//

import SwiftUI
import Lottie

struct HomeTab: View {
  @ObservedObject var presenter: HomePresenter
  
  var body: some View {
    NavigationView{
      ZStack {
        if presenter.loadingState {
          ZStack{
            LottieView(
              name: "loading",
              loopMode: .loop
            )
          }
          .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
          )
          .background(.black)
          
        } else {
          ScrollView(.vertical, showsIndicators: false){
            VStack(alignment: .leading){
              //Top bar section
              HStack{
                Text("Gametopia")
                  .font(
                    Font.custom(
                      "VerminVibesV",
                      size: 24
                    )
                  )
                Spacer()
                Image("user")
                  .resizable()
                  .frame(width: 40, height: 40)
                  .clipShape(Circle())
              }
              
              Spacer().frame(height: 20)
              
              //Home carousel section
              HomeCarousel()
              
              Spacer().frame(height: 20)
              
              //Discovery section
              HStack {
                TitleSubtitle(title: "Discovery", subtitle: "Based on best rating")
                Spacer()
                Button(action: {
                  //TODO:: GO TO DISCOVERY BY RATING
                }) {
                  Image(
                    systemName: "arrow.right.circle"
                  )
                  .tint(Color.yellow)
                }
              }
              
              ScrollView(.horizontal, showsIndicators: false){
                LazyHStack{
                  ForEach(
                    self.presenter.games,
                    id: \.id
                  ) { game in
                    ZStack {
                      self.presenter.linkBuilder(for: game) {
                        GameItem(game: game)
                      }.buttonStyle(PlainButtonStyle())
                    }.padding(8)
                  }
                }
              }
              
              Spacer().frame(height: 20)
              
              //Genre section
              TitleSubtitle(title: "Genres", subtitle: "Find your game genre here")
              
              Spacer().frame(height: 20)
              
              //Developer section
              TitleSubtitle(title: "Developers", subtitle: "Find your favorite developer here")
              
            }
            .frame(
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: .infinity,
              alignment: .topLeading
            )
            .padding(EdgeInsets.init(top: 16, leading: 20, bottom: 50, trailing: 20))
          }
        }
      }.onAppear {
        if self.presenter.games.count == 0 {
          self.presenter.getGames()
        }
      }
    }
  }
}

struct HomeCarousel: View {
  var body: some View {
    GeometryReader { geometry in
      ImageCarouselTemplate(numberOfImages: 5) {
        Image("home_banner_01")
          .resizable()
          .scaledToFill()
          .frame(width: geometry.size.width, height: geometry.size.height)
          .clipped()
        Image("home_banner_02")
          .resizable()
          .scaledToFill()
          .frame(width: geometry.size.width, height: geometry.size.height)
          .clipped()
        Image("home_banner_03")
          .resizable()
          .scaledToFill()
          .frame(width: geometry.size.width, height: geometry.size.height)
          .clipped()
        Image("home_banner_04")
          .resizable()
          .scaledToFill()
          .frame(width: geometry.size.width, height: geometry.size.height)
          .clipped()
        Image("home_banner_05")
          .resizable()
          .scaledToFill()
          .frame(width: geometry.size.width, height: geometry.size.height)
          .clipped()
      }
    }
    .frame(width: UIScreen.main.bounds.width - 40, height: 200, alignment: .center)
    .cornerRadius(20)
  }
}
