//
//  GenreEntity.swift
//  Gametopia
//
//  Created by Patricia Fiona on 20/11/22.
//

import Foundation
import RealmSwift

class GenreEntity: Object {
  @Persisted(primaryKey: true) var id = 0
  @Persisted var name: String = ""
  @Persisted var slug: String = ""
  @Persisted var game_count: Int = 0
  @Persisted var image_background: String = ""
  @Persisted var games: List<GameInGenreEntity>
  
  //Additional that get fron detail genre
  @Persisted dynamic var desc: String = "Unknown Description"
}

class GameInGenreEntity: Object {
  @Persisted(primaryKey: true) var id = ""
  @Persisted dynamic var name: String = ""
  @Persisted dynamic var slug: String = ""
  @Persisted dynamic var added: Int = 0
}
