//
//  DeveloperEntity.swift
//  Gametopia
//
//  Created by Patricia Fiona on 20/11/22.
//

import Foundation
import RealmSwift

class DeveloperEntity: Object {
  @Persisted(primaryKey: true) var id = ""
  @Persisted dynamic var name: String = ""
  @Persisted dynamic var slug: String = ""
  @Persisted dynamic var game_count: Int = 0
  @Persisted dynamic var image_background: String = ""
  @Persisted var games: List<GameInDeveloperEntity> = List<GameInDeveloperEntity>()
}

class GameInDeveloperEntity: Object {
  @Persisted(primaryKey: true) var id = ""
  @Persisted dynamic var name: String = ""
  @Persisted dynamic var slug: String = ""
  @Persisted dynamic var added: Int = 0
  
  @Persisted(originProperty: "games") var assignee: LinkingObjects<DeveloperEntity>
}
