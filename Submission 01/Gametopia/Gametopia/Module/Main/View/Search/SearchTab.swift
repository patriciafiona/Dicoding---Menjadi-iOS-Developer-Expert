//
//  SearchTab.swift
//  Gametopia
//
//  Created by Patricia Fiona on 19/11/22.
//

import SwiftUI

import SwiftUI
import Kingfisher

struct SearchTab: View {
  @ObservedObject var presenter: SearchPresenter
  @State var searchKeyword: String = ""
  @State var isLoading = false
  
  var body: some View {
    
    VStack(alignment: .leading) {
      ZStack{
        TextField(
          "Enter game title",
          text: $searchKeyword
        )
        .onSubmit {
          presenter.getSearchResult(keyword: searchKeyword )
        }
        .disableAutocorrection(true)
      }
      .padding(10)
      .background(Color(red: 68/255, green: 68/255, blue: 68/255))
      
      if(presenter.loadingState){
        ShowLoading()
      }else{
        if(!presenter.results.isEmpty){
          ScrollView(.vertical, showsIndicators: false){
            LazyVStack{
              ForEach(presenter.results, id: \.self.id){ game in
                self.presenter.linkBuilder(for: game.id!) {
                  SearchResultItem(presenter: presenter, game: game)
                }.buttonStyle(PlainButtonStyle())
              }
            }
          }
          .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .center
          )
        }else{
          VStack(alignment: .center){
            Spacer()
            ZStack{
              Circle()
                .fill(.white)
                .frame(width: 100 * 2, height: 100 * 2)
              LottieView(
                name: "no_result",
                loopMode: .loop
              )
              .frame(
                width: 150,
                height: 150,
                alignment: .center
              )
            }
            Spacer()
            Text("No Result")
              .foregroundColor(.white)
              .fontWeight(.bold)
              .font(
                Font.custom(
                  "VerminVibesV",
                  size: 24
                )
              )
            Spacer()
          }.frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .center
          )
        }
      }
    }
    .frame(
      minWidth: 0,
      maxWidth: .infinity,
      minHeight: 0,
      maxHeight: .infinity,
      alignment: .center
    )
    .onAppear{
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

struct ShowLoading: View {
  var body: some View {
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
  }
}

struct SearchResultItem: View{
  @ObservedObject var presenter: SearchPresenter
  @State var game: SearchModel?
  
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
            
            Text("| Score: \(game?.score ?? "Unknown Score")")
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
