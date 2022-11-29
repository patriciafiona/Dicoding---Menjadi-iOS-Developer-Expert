//
//  SearchModel.swift
//  Gametopia
//
//  Created by Patricia Fiona on 28/11/22.
//

import Foundation

struct SearchModel: Equatable, Identifiable{
    var id: Int?
    var name, slug: String?
    var playtime: Int?
    var released: String?
    var rating: Double?
    var score: String?
    var backgroundImage: String?
}
