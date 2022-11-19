//
//  DetailView.swift
//  Gametopia
//
//  Created by Patricia Fiona on 19/11/22.
//

import SwiftUI
import Kingfisher
import SkeletonUI
import RealmSwift

struct DetailView: View {
    @ObservedObject var presenter: DetailPresenter
  
//    @State private var id: Int
//    @State private var game: DetailGameResponse?
//
//    init(id: Int) {
//        self.id = id
//
//        let navBarAppearance = UINavigationBar.appearance()
//        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//        navBarAppearance.barTintColor = .black
//    }
    
    var body: some View {
//        RootContent(id: id, game: game)
      VStack{
        //
      }
    }
}

//struct RootContent: View{
//    @Environment(\.presentationMode) var presentationMode
//    @State var id: Int
//    @State var game: DetailGameResponse?
//
//    @State var isFavorite: Bool = false
//
//    private let realm = try! Realm()
//
//    var body: some View{
//        NavigationView {
//            ScrollView{
//                VStack(alignment: .leading) {
//                    ZStack{
//                        GeometryReader { geometry in
//                            KFImage.url(URL(string: (game?.backgroundImage) ?? ""))
//                                .placeholder {
//                                    Image("gametopia_icon")
//                                        .resizable()
//                                        .scaledToFit()
//                                }
//                                .cacheMemoryOnly()
//                                .fade(duration: 0.25)
//                                .resizable()
//                                .aspectRatio(contentMode: .fill)
//                                .edgesIgnoringSafeArea(.all)
//                                .frame(maxWidth: geometry.size.width,
//                                       maxHeight: geometry.size.height)
//                                .mask(
//                                    LinearGradient(gradient: Gradient(colors: [Color.black, Color.black, Color.black, Color.black.opacity(0)]), startPoint: .top, endPoint: .bottom)
//                                )
//                                .overlay{
//                                    HeaderOverlay(game: game)
//                                        .skeleton(with: game == nil)
//                                        .shape(type: .rectangle)
//                                        .appearance(type: .solid(color: .yellow, background: .black))
//                                }
//                        }
//
//                    }
//                    .frame(height: 450.0)
//
//                    Divider()
//
//                    VStack(alignment: .leading){
//                        Text("Genres")
//                            .font(Font.custom("EvilEmpire", size: 24, relativeTo: .title))
//                            .foregroundColor(.yellow)
//                            .skeleton(with: game == nil)
//                            .shape(type: .rectangle)
//                            .appearance(type: .solid(color: .yellow, background: .black))
//                        ScrollView{
//                            HStack{
//                                if(game?.genres! != nil){
//                                    ForEach((game?.genres)!, id: \.self.id){genreData in
//                                        VStack{
//                                            Text(genreData.name)
//                                                .font(Font.custom("EvilEmpire", size: 14, relativeTo: .title))
//                                                .fontWeight(.bold)
//                                        }
//                                        .padding(.vertical, 10)
//                                        .padding(.horizontal, 15)
//                                        .foregroundColor(.yellow)
//                                        .background(Color.indigo)
//                                        .cornerRadius(.infinity)
//                                        .lineLimit(1)
//                                    }
//                                }
//                            }
//                        }
//
//                        Text("About")
//                            .font(Font.custom("EvilEmpire", size: 24, relativeTo: .title))
//                            .foregroundColor(.yellow)
//                            .skeleton(with: game == nil)
//                            .shape(type: .rectangle)
//                            .appearance(type: .solid(color: .yellow, background: .black))
//
//                        HTMLStringView(htmlContent: game?.description ?? "No description")
//                            .frame(minHeight: 200, maxHeight: 400)
//                            .padding(.bottom, 20)
//                            .skeleton(with: game == nil)
//                            .shape(type: .rectangle)
//                            .appearance(type: .solid(color: .yellow, background: .black))
//                                            .multiline(lines: 20, scales: [1: 0.5])
//
//                        Text("Platform")
//                            .font(Font.custom("EvilEmpire", size: 24, relativeTo: .title))
//                            .foregroundColor(.yellow)
//                            .skeleton(with: game == nil)
//                            .shape(type: .rectangle)
//                            .appearance(type: .solid(color: .yellow, background: .black))
//
//                        if(game?.platforms! != nil){
//                            LazyVStack{
//                                ForEach((game?.platforms)!, id: \.self.platform?.id){platformData in
//                                    PlatformItem(released_at: game?.released, platform: platformData.platform)
//                                        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
//                                }
//                            }
//                            .padding(.bottom, 20)
//                            .skeleton(with: game == nil)
//                            .shape(type: .rectangle)
//                            .appearance(type: .solid(color: .yellow, background: .black))
//                        }
//
//                        HStack{
//                            VStack(alignment: .leading){
//                                Text("Developer")
//                                    .font(Font.custom("EvilEmpire", size: 24, relativeTo: .title))
//                                    .foregroundColor(.yellow)
//                                    .skeleton(with: game == nil)
//                                    .shape(type: .rectangle)
//                                    .appearance(type: .solid(color: .yellow, background: .black))
//                                if(game?.developers! != nil){
//                                    LazyVStack(alignment: .leading){
//                                        ForEach((game?.developers)!, id: \.self.id){developer in
//                                            Text(developer.name)
//                                                .foregroundColor(.white)
//                                                .font(.system(size: 14))
//                                                .underline()
//                                        }
//                                    }
//                                    .skeleton(with: game == nil)
//                                    .shape(type: .rectangle)
//                                    .appearance(type: .solid(color: .yellow, background: .black))
//                                }
//                            }
//                            .frame(minWidth: 0, maxWidth: .infinity)
//
//                            VStack(alignment: .leading){
//                                Text("Publisher")
//                                    .font(Font.custom("EvilEmpire", size: 24, relativeTo: .title))
//                                    .foregroundColor(.yellow)
//                                    .skeleton(with: game == nil)
//                                    .shape(type: .rectangle)
//                                    .appearance(type: .solid(color: .yellow, background: .black))
//
//                                if(game?.publishers! != nil){
//                                    LazyVStack(alignment: .leading){
//                                        ForEach((game?.publishers)!, id: \.self.id){publisher in
//                                            Text(publisher.name)
//                                                .foregroundColor(.white)
//                                                .font(.system(size: 14))
//                                                .underline()
//                                        }
//                                    }
//                                    .skeleton(with: game == nil)
//                                    .shape(type: .rectangle)
//                                    .appearance(type: .solid(color: .yellow, background: .black))
//                                }
//                            }
//                            .frame(minWidth: 0, maxWidth: .infinity)
//                        }
//                        .padding(.bottom, 20)
//
//                        Text("Website")
//                            .font(Font.custom("EvilEmpire", size: 24, relativeTo: .title))
//                            .foregroundColor(.yellow)
//                            .skeleton(with: game == nil)
//                            .shape(type: .rectangle)
//                            .appearance(type: .solid(color: .yellow, background: .black))
//
//                        if let websiteLink = (game?.website!){
//                            Button(action: {
//                                if let url = URL(string: websiteLink) {
//                                    UIApplication.shared.open(url)
//                                }
//                            }) {
//                                Text(websiteLink)
//                                    .foregroundColor(.white)
//                                    .font(.system(size: 14))
//                                    .underline()
//                            }
//                        }
//
//                    }
//                    .padding(10)
//                }
//                .navigationBarTitle("Details")
//                .padding(.bottom, 50)
//            }
//            .background(Color.black)
//            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
//            .navigationBarItems(leading:
//                Button(action: {
//                    self.presentationMode.wrappedValue.dismiss()
//                }) {
//                    HStack {
//                        Image(systemName: "arrow.left.circle")
//                            .foregroundColor(.yellow)
//                        Text("Go Back")
//                            .foregroundColor(.yellow)
//                    }
//                })
//            .navigationBarItems(trailing:
//                Button(action: {
////                    //Add or remove from database
////                    let fav = Favorites()
////                    fav._id = String(game?.id ?? 0)
////                    fav.name = (game?.name)!
////
////                    if realm.object(ofType: Favorites.self, forPrimaryKey: String((game?.id)!)) != nil{
////                        //remove
////                        try! realm.write {
////                            let item = realm.objects(Favorites.self).where {
////                                $0._id == String(game?.id ?? 0)
////                            }
////                            realm.delete(item)
////
////                            isFavorite = false
////                        }
////                    }else{
////                        //add
////                        try! realm.write {
////                            realm.add(fav)
////                            isFavorite = true
////                        }
////                    }
//                }) {
//                    Image(systemName: isFavorite == true ? "heart.circle.fill" : "heart.circle")
//                        .foregroundColor(isFavorite == true ?.red : .gray)
//                }
//                .skeleton(with: game == nil)
//                .shape(type: .circle)
//                .appearance(type: .solid(color: .yellow, background: .black))
//            )
//        }
//        .navigationBarBackButtonHidden(true)
//        .phoneOnlyStackNavigationView()
//        .statusBar(hidden: true)
//        .onAppear() {
////            let network = NetworkService()
////            network.getGameDetails(id: id){ [] (result) in
////                let res = result
////                if let gameDetail = res{
////                    game = gameDetail
////
////                    isFavorite = realm.object(ofType: Favorites.self, forPrimaryKey: String((game?.id)!)) != nil
////                }
////            }
//        }
//    }
//}
//
//struct HeaderOverlay: View{
//    var game: DetailGameResponse?
//
//    var gradient: LinearGradient {
//        .linearGradient(
//            Gradient(colors: [.black.opacity(0.6), .black.opacity(0)]),
//            startPoint: .bottom,
//            endPoint: .center)
//    }
//
//    var body: some View {
//        ZStack(alignment: .bottomLeading) {
//            gradient
//            VStack(alignment: .leading) {
//                HStack{
//                    Text(game?.name ?? "Unknown Name")
//                        .font(Font.custom("EvilEmpire", size: 32, relativeTo: .title))
//                        .foregroundColor(.white)
//                        .shadow(color: .black, radius: 5)
//
//                    Spacer()
//
//                    Label("", systemImage: "star.fill")
//                        .labelStyle(.iconOnly)
//                        .foregroundColor(.yellow)
//
//                    Text("\(game?.rating ?? 0.0, specifier: "%.2f")")
//                        .foregroundColor(.white)
//                        .font(Font.custom("EvilEmpire", size: 22, relativeTo: .title))
//                        .fontWeight(.bold)
//                        .shadow(color: .black, radius: 5)
//                }
//
//                HStack{
//                    VStack(alignment: .leading){
//                        Text("Added to")
//                            .foregroundColor(Color(red: 241 / 255, green: 242 / 255, blue: 246 / 255))
//                            .font(.caption)
//                        HStack{
//                            Text("Wishlist")
//                                .foregroundColor(.white)
//                                .fontWeight(.bold)
//                                .font(.system(size: 14))
//                                .lineLimit(1)
//
//                            Text("\(game?.added ?? 0)")
//                                .foregroundColor(Color(red: 241 / 255, green: 242 / 255, blue: 246 / 255))
//                                .fontWeight(.bold)
//                                .font(.system(size: 12))
//                        }
//
//                    }
//                    .padding(.horizontal, 10)
//                    .padding(.vertical, 10)
//                    .overlay(RoundedRectangle(cornerRadius: 15)
//                        .stroke(.white, lineWidth: 3))
//                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
//
//                    VStack(alignment: .leading){
//                        Text("Achievements")
//                            .foregroundColor(Color(red: 241 / 255, green: 242 / 255, blue: 246 / 255))
//                            .font(.caption)
//                        HStack{
//                            Text("\(game?.achievementsCount ?? 0)")
//                                .foregroundColor(Color(red: 241 / 255, green: 242 / 255, blue: 246 / 255))
//                                .fontWeight(.bold)
//                                .font(.system(size: 12))
//
//                            Text("Achievements")
//                                .foregroundColor(.white)
//                                .fontWeight(.bold)
//                                .font(.system(size: 14))
//                                .lineLimit(1)
//                        }
//
//                    }
//                    .padding(.horizontal, 10)
//                    .padding(.vertical, 10)
//                    .overlay(RoundedRectangle(cornerRadius: 15)
//                        .stroke(.white, lineWidth: 3))
//                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
//
//                    VStack(alignment: .leading){
//                        Text("Rating")
//                            .foregroundColor(Color(red: 241 / 255, green: 242 / 255, blue: 246 / 255))
//                            .font(.caption)
//                        HStack{
//                            Text("\(game?.ratingsCount ?? 0)")
//                                .foregroundColor(Color(red: 241 / 255, green: 242 / 255, blue: 246 / 255))
//                                .fontWeight(.bold)
//                                .font(.system(size: 12))
//
//                            Text("Rating")
//                                .foregroundColor(.white)
//                                .fontWeight(.bold)
//                                .font(.system(size: 14))
//                                .lineLimit(1)
//                        }
//
//                    }
//                    .padding(.horizontal, 10)
//                    .padding(.vertical, 10)
//                    .overlay(RoundedRectangle(cornerRadius: 15)
//                        .stroke(.white, lineWidth: 3))
//                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
//
//                    Spacer()
//                }
//
//            }
//            .padding()
//        }
//    }
//}
//
//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(id: 43050)
//    }
//}
//
//extension String {
//    func markdownToAttributed() -> AttributedString {
//        do {
//            return try AttributedString(markdown: self)
//        } catch {
//            return AttributedString("Error parsing markdown: \(error)")
//        }
//    }
//}
//
//extension View {
//    func phoneOnlyStackNavigationView() -> some View {
//        if UIDevice.current.userInterfaceIdiom == .phone {
//            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
//        } else {
//            return AnyView(self)
//        }
//    }
//}
