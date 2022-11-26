//
//  DetailGameResponse.swift
//  Gametopia
//
//  Created by Patricia Fiona on 20/11/22.
//

import Foundation

struct DetailGameResponse: Decodable {
  let id: Int?
  let slug, name, name_original, description: String?
  let released: String?
  let updated: String?
  let background_image: String?
  let background_image_additional: String?
  let website: String?
  let rating: Double?
  let added: Int?
  let playtime: Int?
  let achievements_count: Int?
  let ratings_count, suggestions_count: Int?
  let reviews_count: Int?
  let parent_platforms: [PlatformInDetail]?
  let platforms: [DetailPlatform]?
  let stores: [StoreDetails]?
  let developers: [Developer]?
  let genres: [GenreInDetails]?
  let tags: [Tag]?
  let publishers: [Publisher]?
  let description_raw: String?
}

struct PlatformInDetail: Decodable {
  let platform: PlatformDetail
}

struct PlatformDetail: Decodable {
    let id: Int?
    let name, slug: String?
}

struct DetailPlatform: Decodable{
    let platform: PlatformDetails?
    let released_at: String?
    let requirements: PlatformRequirement?
}

struct PlatformDetails: Decodable{
    let id: Int?
    let name, slug: String?
    let image: String?
    let year_end, year_start: Int?
    let games_count: Int?
    let image_background: String?
}

struct PlatformRequirement: Decodable{
    let minimum: String?
}

struct StoreDetails: Decodable{
    let id: Int?
    let url: String?
    let store: Store?
}

struct Store: Decodable{
    let id: Int?
    let name, slug: String?
    let games_count: Int?
    let domain: String?
    let image_background: String?
}

struct Developer: Decodable{
    let id: Int?
    let name, slug: String?
    let games_count: Int?
    let image_background: String?
}

struct Publisher: Decodable{
    let id: Int?
    let name, slug: String?
    let games_count: Int?
    let image_background: String?
}

struct GenreInDetails: Decodable{
    let id: Int?
    let name, slug: String?
    let games_count: Int?
    let image_background: String?
}

struct Tag: Decodable{
    let id: Int?
    let name, slug: String?
    let games_count: Int?
    let image_background: String?
}
