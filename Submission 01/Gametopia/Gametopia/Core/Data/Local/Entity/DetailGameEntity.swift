//
//  GameEntity.swift
//  Gametopia
//
//  Created by Patricia Fiona on 22/11/22.
//

import RealmSwift
import Foundation

class DetailGameEntity: Object {
  @Persisted(primaryKey: true) var id = 0
  @Persisted var slug = ""
  @Persisted var name = ""
  @Persisted var name_original = ""
  @Persisted var desc = ""
  @Persisted var released = ""
  @Persisted var updated: String = ""
  @Persisted var background_image: String = ""
  @Persisted var background_image_additional: String = ""
  @Persisted var website: String = ""
  @Persisted var rating: Double = 0.0
  @Persisted var added: Int = 0
  @Persisted var playtime: Int = 0
  @Persisted var achievements_count: Int = 0
  @Persisted var ratings_count: Int = 0
  @Persisted var suggestions_count: Int = 0
  @Persisted var reviews_count: Int = 0
  @Persisted var parent_platforms: List<PlatformEntity>
  @Persisted var platforms: List<DetailPlatformEntity>
  @Persisted var stores: List<StoreDetailsEntity>
  @Persisted var developers: List<DeveloperInDetailsEntity>
  @Persisted var genres: List<GenreInDetailsEntity>
  @Persisted var tags: List<TagEntity>
  @Persisted var publishers: List<PublisherEntity>
  @Persisted var description_raw: String = ""
}

class PlatformEntity: Object {
  @Persisted(primaryKey: true) var id = 0
  @Persisted var name: String = ""
  @Persisted var slug: String = ""
}

class DetailPlatformEntity: Object{
  @Persisted(primaryKey: true) var id = UUID()
  @Persisted var platform: PlatformDetailsEntity? = nil
  @Persisted var released_at: String = ""
  @Persisted var requirements: PlatformRequirementEntity? = nil
}

class PlatformDetailsEntity: Object{
  @Persisted(primaryKey: true) var id: Int? = 0
    @Persisted var name: String? = ""
    @Persisted var slug: String? = ""
    @Persisted var games_count: Int? = 0
    @Persisted var image: String? = ""
    @Persisted var year_end: Int? = 0
    @Persisted var year_start: Int? = 0
    @Persisted var image_background: String? = ""
}

class PlatformRequirementEntity: Object{
    @Persisted(primaryKey: true) var id = UUID()
    @Persisted var minimum: String? = ""
}

class StoreDetailsEntity: Object{
  @Persisted(primaryKey: true) var id = 0
  @Persisted var url: String = ""
  @Persisted var store: StoreEntity? = nil
}

class StoreEntity: Object{
  @Persisted(primaryKey: true) var id: Int? = 0
  @Persisted var name: String? = ""
  @Persisted var slug: String? = ""
  @Persisted var games_count: Int? = 0
  @Persisted var domain: String? = ""
  @Persisted var image_background: String? = ""
}

class DeveloperInDetailsEntity: Object{
  @Persisted(primaryKey: true) var id = 0
  @Persisted var name: String = ""
  @Persisted var slug: String = ""
  @Persisted var games_count: Int = 0
  @Persisted var image_background: String = ""
}

class PublisherEntity: Object{
  @Persisted(primaryKey: true) var id = 0
  @Persisted var name: String = ""
  @Persisted var slug: String = ""
  @Persisted var games_count: Int = 0
  @Persisted var image_background: String = ""
}

class GenreInDetailsEntity: Object{
  @Persisted(primaryKey: true) var id = 0
  @Persisted var name: String = ""
  @Persisted var slug: String = ""
  @Persisted var games_count: Int = 0
  @Persisted var image_background: String = ""
}

class TagEntity: Object{
  @Persisted(primaryKey: true) var id = 0
  @Persisted var name: String = ""
  @Persisted var slug: String = ""
  @Persisted var games_count: Int = 0
  @Persisted var image_background: String = ""
}
