//
//  GenreItem.swift
//  Gametopia
//
//  Created by Patricia Fiona on 20/11/22.
//

import SwiftUI
import Kingfisher
import SkeletonUI

struct GenreItem: View {
    var genre: GenreModel
  
    var body: some View {
      ZStack{
          GeometryReader { geometry in
            KFImage.url(URL(string: (genre.image_background) ?? ""))
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
                      GenreHeaderOverlay(genre: genre)
                  }
          }
          
      }
      .frame(height: 150.0)
    }
}

private struct GenreHeaderOverlay: View{
    var genre: GenreModel
    
    var gradient: LinearGradient {
        .linearGradient(
            Gradient(colors: [.black.opacity(0.8), .black.opacity(0)]),
            startPoint: .bottom,
            endPoint: .top)
    }

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            gradient
            VStack(alignment: .leading) {
              Spacer()
              Text(genre.name ?? "Unknown Name")
                  .font(Font.custom("EvilEmpire", size: 16, relativeTo: .title))
                  .foregroundColor(.white)
                  .shadow(color: .black, radius: 5)
              Spacer().frame(height: 3)
              Text("Total games: \(genre.games_count ?? 0)")
                .font(Font.system(size: 12))
                  .foregroundColor(.white)
                  .shadow(color: .black, radius: 5)
            }
            .padding()
        }
    }
}
