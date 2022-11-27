//
//  ContentView.swift
//  Gametopia
//
//  Created by Patricia Fiona on 19/11/22.
//

import SwiftUI

struct HomeView: View {
  @ObservedObject var presenter: HomePresenter
  @State var tabSelection: Tabs = .tabHome
  
  enum Tabs{
      case tabHome, tabSearch, tabFavorite, tabProfile
  }
    var body: some View {
        NavigationView{
            TabView(selection: $tabSelection) {
               HomeTab(presenter: presenter)
                 .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                 }
                 .tag(Tabs.tabHome)
               SearchTab(presenter: presenter)
                 .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                 }
                 .tag(Tabs.tabSearch)
                FavoriteTab(presenter: presenter)
                  .tabItem {
                     Image(systemName: "heart.circle.fill")
                     Text("Favorites")
                  }
                  .tag(Tabs.tabFavorite)
                ProfileTab()
                  .tabItem {
                     Image(systemName: "person.circle")
                     Text("Profile")
                  }
                  .tag(Tabs.tabProfile)
            }
            .accentColor(.yellow)
        }
        .navigationBarBackButtonHidden(true)
    }
}
