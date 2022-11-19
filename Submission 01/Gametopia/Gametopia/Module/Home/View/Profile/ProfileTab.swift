//
//  ProfileTab.swift
//  Gametopia
//
//  Created by Patricia Fiona on 19/11/22.
//

import SwiftUI

struct ProfileTab: View {
  
  let _user_name = "Patricia Fiona"
  let _user_email = "patriciafiona3@gmail.com"
  let _user_desc = "iOS & Android Enthusiasm"
  let _user_location = "Jakarta, Indonesia"
  
    var body: some View {
      ScrollView{
        VStack(alignment: .leading){
          Image("user")
            .resizable()
            .scaledToFill()
            .frame(width: 150, height: 150)
            .clipShape(Circle())
          Text(_user_name)
            .font(
              Font.custom("EvilEmpire", size: 24, relativeTo: .title)
            )
            .foregroundColor(.yellow)
          Text(_user_email)
            .foregroundColor(.gray)
            .font(Font.system(size: 12))
          Spacer().frame(height: 10)
          Text(_user_desc)
            .fontWeight(Font.Weight.bold)
            .font(Font.system(size: 14))
            .foregroundColor(.white)
          Text(_user_location)
            .font(Font.system(size: 12))
            .foregroundColor(.white)
        }
        .frame(
          minWidth: 0,
          maxWidth: .infinity,
          minHeight: 0,
          maxHeight: .infinity,
          alignment: .topLeading
        )
        .padding(EdgeInsets.init(top: 16, leading: 20, bottom: 50, trailing: 20))
      }
    }
}

struct ProfileTab_Previews: PreviewProvider {
    static var previews: some View {
        ProfileTab()
    }
}
