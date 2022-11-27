//
//  DetailView.swift
//  Gametopia
//
//  Created by Patricia Fiona on 19/11/22.
//

import SwiftUI
import Kingfisher
import SkeletonUI

struct DetailView: View {
  @ObservedObject var presenter: DetailPresenter
  
  var body: some View {
    RootContent(presenter: presenter)
  }
}

struct RootContent: View{
  @Environment(\.presentationMode) var presentationMode
  @ObservedObject var presenter: DetailPresenter
  @State var isFavorite: Bool = false
  
  var body: some View{
    NavigationView {
      ScrollView{
        VStack(alignment: .leading) {
          TopSection(presenter: presenter)
          Divider()
          BottomSection(presenter: presenter)
        }
        .navigationBarTitle("Details")
        .padding(.bottom, 50)
      }
      .background(Color.black)
      .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
      .navigationBarItems(leading: Button {
        self.presentationMode.wrappedValue.dismiss()
      } label: {
        HStack {
          Image(systemName: "arrow.left.circle")
            .foregroundColor(.yellow)
          Text("Go Back")
            .foregroundColor(.yellow)
        }
      })
      .navigationBarItems(trailing: Button {
        //TODO: ADD OR REMOVE FROM DATABASE
      } label: {
        Image(systemName: isFavorite == true ? "heart.circle.fill" : "heart.circle")
          .foregroundColor(isFavorite == true ?.red : .gray)
      }
        .skeleton(with: presenter.loadingState)
        .shape(type: .circle)
        .appearance(type: .solid(color: .yellow, background: .black))
      )
    }
    .navigationBarBackButtonHidden(true)
    .phoneOnlyStackNavigationView()
    .statusBar(hidden: true)
    .onAppear {
      if self.presenter.detailGame == nil {
        self.presenter.getDetailGame()
      }
    }
  }
}

struct TopSection: View {
  @ObservedObject var presenter: DetailPresenter
  
  var body: some View {
    ZStack{
      GeometryReader { geometry in
        KFImage.url(URL(string: (presenter.detailGame?.backgroundImage) ?? ""))
          .placeholder {
            Image("gametopia_icon")
              .resizable()
              .scaledToFit()
          }
          .cacheOriginalImage()
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
            HeaderOverlay(game: presenter.detailGame)
              .skeleton(with: presenter.loadingState)
              .shape(type: .rectangle)
              .appearance(type: .solid(color: .yellow, background: .black))
          }
      }
      
    }
    .frame(height: 450.0)
    
  }
  
}

struct BottomSection: View {
  @ObservedObject var presenter: DetailPresenter
  
  var body: some View {
    VStack(alignment: .leading){
      Text("Genres")
        .font(Font.custom("EvilEmpire", size: 24, relativeTo: .title))
        .foregroundColor(.yellow)
        .skeleton(with: presenter.loadingState)
        .shape(type: .rectangle)
        .appearance(type: .solid(color: .yellow, background: .black))
      ScrollView{
        HStack{
          if(presenter.detailGame?.genres != nil){
            ForEach((presenter.detailGame?.genres)!, id: \.self.id){ genreData in
              VStack{
                Text(genreData.name)
                  .font(Font.custom("EvilEmpire", size: 14, relativeTo: .title))
                  .fontWeight(.bold)
              }
              .padding(.vertical, 10)
              .padding(.horizontal, 15)
              .foregroundColor(.yellow)
              .background(Color.indigo)
              .cornerRadius(.infinity)
              .lineLimit(1)
            }
          }
        }
      }
      
      Text("About")
        .font(Font.custom("EvilEmpire", size: 24, relativeTo: .title))
        .foregroundColor(.yellow)
        .skeleton(with: presenter.loadingState)
        .shape(type: .rectangle)
        .appearance(type: .solid(color: .yellow, background: .black))
      
      HTMLStringView(htmlContent: presenter.detailGame?.description ?? "No description")
        .frame(minHeight: 200, maxHeight: 400)
        .padding(.bottom, 20)
        .skeleton(with: presenter.loadingState)
        .shape(type: .rectangle)
        .appearance(type: .solid(color: .yellow, background: .black))
        .multiline(lines: 20, scales: [1: 0.5])
      
      Text("Platform")
        .font(Font.custom("EvilEmpire", size: 24, relativeTo: .title))
        .foregroundColor(.yellow)
        .skeleton(with: presenter.loadingState)
        .shape(type: .rectangle)
        .appearance(type: .solid(color: .yellow, background: .black))
      
      if(presenter.detailGame?.platforms != nil){
        LazyVStack{
          ForEach((presenter.detailGame?.platforms)!, id: \.platform?.id){ platformData in
            PlatformItem(released_at: presenter.detailGame?.released, platform: platformData.platform)
              .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
          }
        }
        .padding(.bottom, 20)
        .skeleton(with: presenter.loadingState)
        .shape(type: .rectangle)
        .appearance(type: .solid(color: .yellow, background: .black))
      }
      
      HStack{
        VStack(alignment: .leading){
          Text("Developer")
            .font(Font.custom("EvilEmpire", size: 24, relativeTo: .title))
            .foregroundColor(.yellow)
            .skeleton(with: presenter.loadingState)
            .shape(type: .rectangle)
            .appearance(type: .solid(color: .yellow, background: .black))
          if(presenter.detailGame?.developers != nil){
            LazyVStack(alignment: .leading){
              ForEach((presenter.detailGame?.developers)!, id: \.self.id){developer in
                Text(developer.name)
                  .foregroundColor(.white)
                  .font(.system(size: 14))
                  .underline()
              }
            }
            .skeleton(with: presenter.loadingState)
            .shape(type: .rectangle)
            .appearance(type: .solid(color: .yellow, background: .black))
          }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        
        VStack(alignment: .leading){
          Text("Publisher")
            .font(Font.custom("EvilEmpire", size: 24, relativeTo: .title))
            .foregroundColor(.yellow)
            .skeleton(with: presenter.loadingState)
            .shape(type: .rectangle)
            .appearance(type: .solid(color: .yellow, background: .black))
          
          if((presenter.detailGame?.publishers) != nil){
            LazyVStack(alignment: .leading){
              ForEach((presenter.detailGame?.publishers)!, id: \.self.id){publisher in
                Text(publisher.name)
                  .foregroundColor(.white)
                  .font(.system(size: 14))
                  .underline()
              }
            }
            .skeleton(with: presenter.loadingState)
            .shape(type: .rectangle)
            .appearance(type: .solid(color: .yellow, background: .black))
          }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
      }
      .padding(.bottom, 20)
      
      Text("Website")
        .font(Font.custom("EvilEmpire", size: 24, relativeTo: .title))
        .foregroundColor(.yellow)
        .skeleton(with: presenter.loadingState)
        .shape(type: .rectangle)
        .appearance(type: .solid(color: .yellow, background: .black))
      
      if let websiteLink = (presenter.detailGame?.website){
        Button(action: {
          if let url = URL(string: websiteLink) {
            UIApplication.shared.open(url)
          }
        }) {
          Text(websiteLink)
            .foregroundColor(.white)
            .font(.system(size: 14))
            .underline()
        }
      }
      
    }
    .padding(10)
  }
}

struct HeaderOverlay: View{
  var game: DetailGameModel?
  
  var gradient: LinearGradient {
    .linearGradient(
      Gradient(colors: [.black.opacity(0.6), .black.opacity(0)]),
      startPoint: .bottom,
      endPoint: .center)
  }
  
  var body: some View {
    ZStack(alignment: .bottomLeading) {
      gradient
      VStack(alignment: .leading) {
        HStack{
          Text(game?.name ?? "Unknown Name")
            .font(Font.custom("EvilEmpire", size: 32, relativeTo: .title))
            .foregroundColor(.white)
            .shadow(color: .black, radius: 5)
          
          Spacer()
          
          Label("", systemImage: "star.fill")
            .labelStyle(.iconOnly)
            .foregroundColor(.yellow)
          
          Text("\(game?.rating ?? 0.0, specifier: "%.2f")")
            .foregroundColor(.white)
            .font(Font.custom("EvilEmpire", size: 22, relativeTo: .title))
            .fontWeight(.bold)
            .shadow(color: .black, radius: 5)
        }
        
        HStack{
          VStack(alignment: .leading){
            Text("Added to")
              .foregroundColor(Color(red: 241 / 255, green: 242 / 255, blue: 246 / 255))
              .font(.caption)
            HStack{
              Text("Wishlist")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .font(.system(size: 14))
                .lineLimit(1)
              
              Text("\(game?.added ?? 0)")
                .foregroundColor(Color(red: 241 / 255, green: 242 / 255, blue: 246 / 255))
                .fontWeight(.bold)
                .font(.system(size: 12))
            }
            
          }
          .padding(.horizontal, 10)
          .padding(.vertical, 10)
          .overlay(RoundedRectangle(cornerRadius: 15)
            .stroke(.white, lineWidth: 3))
          .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
          
          VStack(alignment: .leading){
            Text("Achievements")
              .foregroundColor(Color(red: 241 / 255, green: 242 / 255, blue: 246 / 255))
              .font(.caption)
            HStack{
              Text("\(game?.achievementsCount ?? 0)")
                .foregroundColor(Color(red: 241 / 255, green: 242 / 255, blue: 246 / 255))
                .fontWeight(.bold)
                .font(.system(size: 12))
              
              Text("Achievements")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .font(.system(size: 14))
                .lineLimit(1)
            }
            
          }
          .padding(.horizontal, 10)
          .padding(.vertical, 10)
          .overlay(RoundedRectangle(cornerRadius: 15)
            .stroke(.white, lineWidth: 3))
          .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
          
          VStack(alignment: .leading){
            Text("Rating")
              .foregroundColor(Color(red: 241 / 255, green: 242 / 255, blue: 246 / 255))
              .font(.caption)
            HStack{
              Text("\(game?.ratingsCount ?? 0)")
                .foregroundColor(Color(red: 241 / 255, green: 242 / 255, blue: 246 / 255))
                .fontWeight(.bold)
                .font(.system(size: 12))
              
              Text("Rating")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .font(.system(size: 14))
                .lineLimit(1)
            }
            
          }
          .padding(.horizontal, 10)
          .padding(.vertical, 10)
          .overlay(RoundedRectangle(cornerRadius: 15)
            .stroke(.white, lineWidth: 3))
          .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
          
          Spacer()
        }
        
      }
      .padding()
    }
  }
}

extension String {
  func markdownToAttributed() -> AttributedString {
    do {
      return try AttributedString(markdown: self)
    } catch {
      return AttributedString("Error parsing markdown: \(error)")
    }
  }
}

extension View {
  func phoneOnlyStackNavigationView() -> some View {
    if UIDevice.current.userInterfaceIdiom == .phone {
      return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
    } else {
      return AnyView(self)
    }
  }
}
