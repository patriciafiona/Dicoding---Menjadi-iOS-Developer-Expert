//
//  DetailGameResponse.swift
//  Gametopia
//
//  Created by Patricia Fiona on 20/11/22.
//

import Foundation

struct DetailGameModel: Equatable, Identifiable {
  let id: Int?
  let isFavorite: Bool?
  let slug, name, nameOriginal, description: String?
  let released: String?
  let updated: String?
  let backgroundImage: String?
  let backgroundImageAdditional: String?
  let website: String?
  let rating: Double?
  let added: Int?
  let playtime: Int?
  let achievementsCount: Int?
  let ratingsCount, suggestionsCount: Int?
  let reviewsCount: Int?
  let parentPlatforms: [PlatformModel]?
  let platforms: [DetailPlatformModel]?
  let stores: [StoreDetailsModel]?
  let developers: [DeveloperInDetailGameModel]?
  let genres: [GenreInDetailsModel]?
  let tags: [TagModel]?
  let publishers: [PublisherModel]?
  let descriptionRaw: String?
}

struct DetailPlatformModel: Equatable, Identifiable {
    let id: UUID
    let platform: PlatformDetailsModel?
    let releasedAt: String?
    let requirements: PlatformRequirementModel?
}

struct PlatformDetailsModel: Equatable, Identifiable{
    var id: UUID
    let name, slug: String?
    let image: String?
    let yearEnd, yearStart: Int?
    let gamesCount: Int?
    let imageBackground: String?
}

struct PlatformRequirementModel: Equatable, Identifiable{
  let id: UUID
  let minimum: String?
}

struct StoreDetailsModel: Equatable, Identifiable{
    let id: UUID
    let url: String?
    let store: StoreModel?
}

struct StoreModel: Equatable, Identifiable{
    let id: UUID
    let name, slug: String?
    let gamesCount: Int?
    let domain: String?
    let imageBackground: String?
}

struct DeveloperInDetailGameModel: Equatable, Identifiable{
    let id: UUID
    let name, slug: String?
    let gamesCount: Int?
    let imageBackground: String?
}

struct PublisherModel: Equatable, Identifiable{
    let id: UUID
    let name, slug: String?
    let gamesCount: Int?
    let imageBackground: String?
}

struct GenreInDetailsModel: Equatable, Identifiable{
    let id: UUID
    let name, slug: String?
    let gamesCount: Int?
    let imageBackground: String?
}

struct TagModel: Equatable, Identifiable{
    let id: UUID
    let name, slug: String?
    let gamesCount: Int?
    let imageBackground: String?
}
