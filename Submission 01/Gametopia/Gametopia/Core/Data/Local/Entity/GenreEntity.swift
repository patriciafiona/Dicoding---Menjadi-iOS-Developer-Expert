//
//  GenreEntity.swift
//  Gametopia
//
//  Created by Patricia Fiona on 20/11/22.
//

import Foundation
import RealmSwift

class GenreEntity: Object {

  @objc dynamic var id: String = ""
  @objc dynamic var name: String = ""
  @objc dynamic var slug: String = ""
  @objc dynamic var game_count: Int = 0
  @objc dynamic var image_background: String = ""
  dynamic var games: List<GameInGenreEntity> = List<GameInGenreEntity>()

  override static func primaryKey() -> String? {
    return "id"
  }
}

class GameInGenreEntity: Object {
  @objc dynamic var id: String = ""
  @objc dynamic var name: String = ""
  @objc dynamic var slug: String = ""
  @objc dynamic var added: Int = 0
  
  override static func primaryKey() -> String? {
    return "id"
  }
}
