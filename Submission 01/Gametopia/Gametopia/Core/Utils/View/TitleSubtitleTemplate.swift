//
//  TitleSubtitleTemplate.swift
//  Gametopia
//
//  Created by Patricia Fiona on 19/11/22.
//

import Foundation
import SwiftUI

struct TitleSubtitle: View {
  var title: String
  var subtitle: String
  
  var body: some View {
    VStack(alignment: .leading){
      Text(title)
        .font(
          Font.custom("EvilEmpire", size: 24, relativeTo: .title)
        )
        .foregroundColor(.yellow)
      Text(subtitle)
        .foregroundColor(.gray)
        .font(.system(size: 14))
    }
  }
}
