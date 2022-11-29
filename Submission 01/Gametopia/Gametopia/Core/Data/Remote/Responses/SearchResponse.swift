//
//  SearchResponse.swift
//  Gametopia
//
//  Created by Patricia Fiona on 28/11/22.
//

import Foundation

struct SearchResponse: Decodable {
    var count: Int?
    var next, previous: String?
    var results: [SearchResult]?
}

struct SearchResult: Decodable{
    var id: Int?
    var name, slug: String?
    var playtime: Int?
    var released: String?
    var rating: Double?
    var score: String?
    var backgroundImage: String?
}
