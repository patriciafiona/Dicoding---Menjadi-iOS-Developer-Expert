//
//  ContentView.swift
//  Gametopia
//
//  Created by Patricia Fiona on 19/11/22.
//

import SwiftUI

struct HomeView: View {
  @ObservedObject var presenter: HomePresenter
  
    var body: some View {
        NavigationView{
            TabView {
               HomeTab(presenter: presenter)
                 .tabItem {
                    Image(systemName: "house")
                     .tint(Color.indigo)
                    Text("Home")
               }
               SearchTab(presenter: presenter)
                 .tabItem {
                    Image(systemName: "magnifyingglass")
                     .tint(Color.indigo)
                    Text("Search")
                     
                 }
                FavoriteTab(presenter: presenter)
                  .tabItem {
                     Image(systemName: "heart.circle.fill")
                      .tint(Color.indigo)
                     Text("Favorites")
               }
                ProfileTab()
                  .tabItem {
                     Image(systemName: "person.circle")
                      .tint(Color.indigo)
                     Text("Profile")
               }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
