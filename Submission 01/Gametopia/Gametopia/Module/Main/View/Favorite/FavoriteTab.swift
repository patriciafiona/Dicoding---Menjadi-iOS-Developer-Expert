//
//  FavoriteTab.swift
//  Gametopia
//
//  Created by Patricia Fiona on 19/11/22.
//

import SwiftUI
import Kingfisher

struct FavoriteTab: View {
  @ObservedObject var presenter: FavoritesPresenter
  
  var body: some View {
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
        VStack(alignment: .leading){
          Text("My Favorites")
            .font(
              Font.custom("EvilEmpire", size: 24, relativeTo: .title)
            )
            .foregroundColor(.yellow)
          
          if(!presenter.games.isEmpty){
            LazyVStack{
              ForEach(presenter.games, id: \.self.id){ game in
                self.presenter.linkBuilder(for: game.id!) {
                  GameFavoriteItem(presenter: presenter, game: game)
                }.buttonStyle(PlainButtonStyle())
              }
            }
            .padding(.top, 10)
            .zIndex(-1)
          }else{
            VStack(alignment: .center){
              Spacer()
              ZStack{
                Circle()
                  .fill(.white)
                  .frame(width: 100 * 2, height: 100 * 2)
                LottieView(
                  name: "no_favorite",
                  loopMode: .playOnce
                )
                .frame(
                  width: 150,
                  height: 150,
                  alignment: .center
                )
              }
              Spacer()
              Text("No Favorite")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .font(
                  Font.custom(
                    "VerminVibesV",
                    size: 24
                  )
                )
              Spacer()
            }
            .frame(
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: .infinity,
              alignment: .center
            )
          }
        }
        .padding(16)
        .frame(
          minWidth: 0,
          maxWidth: .infinity,
          minHeight: 0,
          maxHeight: .infinity,
          alignment: .topLeading
        )
      }
    }
    .onAppear{
      presenter.getFavoritesGames()
      self.presenter.objectWillChange.send()
      
      //tab bar appearance
      let tabBarAppearance = UITabBarAppearance()
      tabBarAppearance.configureWithDefaultBackground()
      UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
    .navigationBarTitle("")
    .navigationBarHidden(true)
  }
}

struct GameFavoriteItem: View{
    @ObservedObject var presenter: FavoritesPresenter
    @State var game: DetailGameModel?
    
    var body: some View {
        HStack{
            KFImage.url(URL(string: (game?.backgroundImage) ?? ""))
                .placeholder {
                    Image("gametopia_icon")
                        .resizable()
                        .scaledToFit()
                }
                .cacheOriginalImage()
                .fade(duration: 0.25)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .clipped()
                .skeleton(with: game == nil)
                .shape(type: .rectangle)
                .appearance(type: .solid(color: .yellow, background: .black))
            
            HStack{
                VStack(alignment: .leading){
                    Text(game?.name)
                        .lineLimit(1)
                        .font(Font.custom("EvilEmpire", size: 18, relativeTo: .title))
                        .foregroundColor(.yellow)
                        .skeleton(with: game == nil)
                        .shape(type: .rectangle)
                        .appearance(type: .solid(color: .yellow, background: .black))
                        .skeleton(with: game == nil)
                        .shape(type: .rectangle)
                        .appearance(type: .solid(color: .yellow, background: .black))
                    
                    if let releaseDate = game?.released {
                        Text("Release on \(dateFormat(dateTxt:releaseDate))")
                            .foregroundColor(Color(red: 241 / 255, green: 242 / 255, blue: 246 / 255))
                            .font(.system(size: 12))
                            .skeleton(with: game == nil)
                            .shape(type: .rectangle)
                            .appearance(type: .solid(color: .yellow, background: .black))
                    }else{
                        Text("Unknown release date")
                            .foregroundColor(Color(red: 241 / 255, green: 242 / 255, blue: 246 / 255))
                            .font(.system(size: 12))
                            .skeleton(with: game == nil)
                            .shape(type: .rectangle)
                            .appearance(type: .solid(color: .yellow, background: .black))
                    }
                    
                    HStack{
                        Label("", systemImage: "star.fill")
                            .labelStyle(.iconOnly)
                            .foregroundColor(.yellow)
                            .font(.system(size: 12))
                            .skeleton(with: game == nil)
                            .shape(type: .rectangle)
                            .appearance(type: .solid(color: .yellow, background: .black))
                        
                        Text("\(game?.rating ?? 0.0, specifier: "%.2f")")
                            .foregroundColor(.white)
                            .font(Font.custom("EvilEmpire", size: 14, relativeTo: .title))
                            .fontWeight(.bold)
                            .skeleton(with: game == nil)
                            .shape(type: .rectangle)
                            .appearance(type: .solid(color: .yellow, background: .black))
                        
                      Text("| Total Review: \(game?.reviewsCount ?? 0)")
                            .foregroundColor(.white)
                            .font(Font.custom("EvilEmpire", size: 14, relativeTo: .title))
                            .skeleton(with: game == nil)
                            .shape(type: .rectangle)
                            .appearance(type: .solid(color: .yellow, background: .black))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 10)
        }
    }
}
