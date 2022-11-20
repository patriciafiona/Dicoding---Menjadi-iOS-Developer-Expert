//
//  DeveloperItem.swift
//  Gametopia
//
//  Created by Patricia Fiona on 20/11/22.
//

import SwiftUI
import SkeletonUI
import Kingfisher

struct DeveloperItem: View {
  var developer: DeveloperModel
  
  var body: some View {
    ZStack {
      GeometryReader { geometry in
        KFImage.url(URL(string: (developer.image_background) ?? ""))
          .placeholder {
            Image("gametopia_icon")
              .resizable()
              .scaledToFit()
          }
          .cacheMemoryOnly()
          .fade(duration: 0.25)
          .resizable()
          .aspectRatio(contentMode: .fill)
          .edgesIgnoringSafeArea(.all)
          .frame(maxWidth: geometry.size.width,
                 maxHeight: geometry.size.height)
          .mask(
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.black, Color.black, Color.black.opacity(0)]), startPoint: .top, endPoint: .bottom)
          )
          .overlay{
            DeveloperHeaderOverlay(developer: developer)
          }
      }
    }
    .padding(8)
    .frame(height: 300)
  }
}

private struct DeveloperHeaderOverlay: View{
  var developer: DeveloperModel
  
  var gradient: LinearGradient {
    .linearGradient(
      Gradient(colors: [.black.opacity(0.8), .black.opacity(0.5)]),
      startPoint: .bottom,
      endPoint: .top)
  }
  
  var body: some View {
    ZStack(alignment: .center) {
      gradient
      VStack(alignment: .center) {
        Text(developer.name ?? "Unknown Developer Name")
          .font(Font.custom("EvilEmpire", size: 24, relativeTo: .title))
          .foregroundColor(.white)
          .shadow(color: .black, radius: 5)
        Spacer().frame(height: 50)
        VStack(alignment: .leading) {
          Text("Popular Games: ")
            .font(Font.system(size: 18))
            .fontWeight(Font.Weight.bold)
            .foregroundColor(.yellow)
          LazyVStack{
            ForEach(developer.games.prefix(3), id: \.id){ game in
              DeveloperGameItem(game: game)
            }
          }
        }
        .frame(
          minWidth: 0,
          maxWidth: .infinity,
          minHeight: 0
        )
      }
      .padding()
    }
  }
}

struct DeveloperGameItem: View{
  var game: GameInDeveloperModel
  
  var body: some View {
    GeometryReader { geo in
      HStack{
        Text(game.name)
          .foregroundColor(.white)
          .frame(width: geo.size.width * 0.7, alignment: .leading)
        Text(String(game.added ?? 0))
          .foregroundColor(.gray)
          .fontWeight(Font.Weight.bold)
          .frame(width: geo.size.width * 0.3, alignment: .trailing)
      }
    }
    .padding(.bottom, 10)
  }
}
