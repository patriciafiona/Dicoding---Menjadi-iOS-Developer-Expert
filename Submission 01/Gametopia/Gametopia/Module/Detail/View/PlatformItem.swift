//
//  PlatformItem.swift
//  Gametopia
//
//  Created by Patricia Fiona on 19/11/22.
//

import SwiftUI
import Kingfisher

struct PlatformItem: View {
    var released_at: String?
//    var platform: PlatformDetails?
    @State private var platformImage: String = "gametopia_text_logo"
    
    var body: some View {
      VStack{
        //
      }
//        HStack {
//            Image(platformImage)
//                .resizable()
//                .frame(width: 50, height: 50)
//
//            Divider()
//
//            VStack(alignment: .leading){
//                Text(platform?.name ?? "Unknown Platform")
//                    .font(Font.custom("EvilEmpire", size: 24, relativeTo: .title))
//                    .foregroundColor(.yellow)
//                if(released_at != nil){
//                    VStack(alignment: .leading){
//                        Text("Release on \(dateFormat(dateTxt: released_at!))")
//                            .font(.system(size: 12))
//                            .foregroundColor(.white)
//                        Text("Total game in this platform are \(platform?.gamesCount ?? 0)")
//                            .font(.system(size: 12))
//                            .foregroundColor(.white)
//                    }
//                }else{
//                    Text("Total game in this platform are \(platform?.gamesCount ?? 0)")
//                        .font(.system(size: 12))
//                        .foregroundColor(.white)
//                }
//
//            }
//
//            Spacer()
//        }
//        .background(Color.black)
//        .onAppear(){
//            if let name: String = (platform?.name!) {
//                if(name.lowercased().contains("mac") || name.contains("ios")){
//                    platformImage = "platform_mac"
//                }else if(name.lowercased().contains("pc")){
//                    platformImage = "platform_pc"
//                }else if(name.lowercased().contains("linux")){
//                    platformImage = "platform_linux"
//                }else if(name.lowercased().contains("android")){
//                    platformImage = "platform_android"
//                }else if(name.lowercased().contains("xbox")){
//                    platformImage = "platform_xbox"
//                }else if(name.lowercased().contains("playstation")){
//                    platformImage = "platform_playstation"
//                }else if(name.lowercased().contains("nintendo")){
//                    platformImage = "platform_nintendo"
//                }else{
//                    platformImage = "gametopia_text_logo"
//                }
//            }
//        }
    }
}

struct PlatformItem_Previews: PreviewProvider {
    static var previews: some View {
        PlatformItem()
    }
}
