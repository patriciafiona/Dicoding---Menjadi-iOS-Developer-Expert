//
//  FavoriteTab.swift
//  Gametopia
//
//  Created by Patricia Fiona on 19/11/22.
//

import SwiftUI
import Kingfisher
import SkeletonUI

struct FavoriteTab: View {
  @ObservedObject var presenter: FavoritesPresenter
  
  private let templateSkeletonView = [
    templateSkeleton(), templateSkeleton(), templateSkeleton(), templateSkeleton(),
    templateSkeleton(), templateSkeleton(), templateSkeleton(), templateSkeleton(),
    templateSkeleton(), templateSkeleton(), templateSkeleton(), templateSkeleton()
  ]
  
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
        ScrollView(.vertical, showsIndicators: false){
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
              if #available(iOS 16.0, *) {
                SkeletonList(with: templateSkeletonView, quantity: templateSkeletonView.count) { loading, user in
                  GameFavoriteItem(presenter: presenter, game: nil)
                    .skeleton(with: loading)
                    .shape(type: .rectangle)
                    .appearance(type: .solid(color: .yellow, background: .black))
                    .listRowBackground(Color.black)
                }
                .frame(height: 800)
                .scrollContentBackground(.hidden)
                .zIndex(-1)
              }else{
                SkeletonList(with: templateSkeletonView, quantity: templateSkeletonView.count) { loading, user in
                  GameFavoriteItem(presenter: presenter, game: nil)
                    .skeleton(with: loading)
                    .shape(type: .rectangle)
                    .appearance(type: .solid(color: .yellow, background: .black))
                    .listRowBackground(Color.black)
                }
                .frame(height: 800)
                .background(.black)
                .zIndex(-1)
              }
            }
          }
        }
      }
    }
    .onAppear{
      if(presenter.games.count == 0){
        presenter.getFavoritesGames()
      }
    }
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
