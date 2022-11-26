//
//  DetailGenreResponse.swift
//  Gametopia
//
//  Created by Patricia Fiona on 25/11/22.
//

import Foundation

class DetailGenreResponse: Decodable {
    var id: Int?
    var name, slug: String?
    var games_count: Int?
    var image_background: String?
    var description: String?
}
