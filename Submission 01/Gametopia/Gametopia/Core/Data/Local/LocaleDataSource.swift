//
//  LocaleDataSource.swift
//  Gametopia
//
//  Created by Patricia Fiona on 19/11/22.
//

import Foundation
import RealmSwift
import Combine

protocol LocaleDataSourceProtocol: AnyObject {
  func getGenres() -> AnyPublisher<[GenreEntity], Error>
  func addGenres(from genres: [GenreEntity]) -> AnyPublisher<Bool, Error>
  func updateGenre(id: Int, desc: String) -> AnyPublisher<Bool, Error>
  func getDetailGenre(id: Int) -> AnyPublisher<GenreEntity, Error>
  
  func getDevelopers() -> AnyPublisher<[DeveloperEntity], Error>
  func addDevelopers(from developers: [DeveloperEntity]) -> AnyPublisher<Bool, Error>
  
  func getGames() -> AnyPublisher<[GameEntity], Error>
  func getSortedGames(sortedFromBest: Bool) -> AnyPublisher<[GameEntity], Error>
  func getBestRatingGames() -> AnyPublisher<[GameEntity], Error>
  func addGames(from game: [GameEntity]) -> AnyPublisher<Bool, Error>
  func addGame(from game: GameEntity) -> AnyPublisher<Bool, Error>
  func updateGames(gameEntity: GameEntity) -> AnyPublisher<Bool, Error>
  func getDetailGame(id: Int) -> AnyPublisher<GameEntity, Error>
  
  func updateFavoriteGames(id: Int, isFavorite: Bool) -> AnyPublisher<Bool, Error>
  func getAllFavoriteGames() -> AnyPublisher<[GameEntity], Error>
}

final class LocaleDataSource: NSObject {
  private let realm: Realm?

  private init(realm: Realm?) {
    self.realm = realm
  }

  static let sharedInstance: (Realm?) -> LocaleDataSource = { realmDatabase in
    return LocaleDataSource(realm: realmDatabase)
  }
}

extension LocaleDataSource: LocaleDataSourceProtocol {
  func getAllFavoriteGames() -> AnyPublisher<[GameEntity], Error> {
    return Future<[GameEntity], Error> { completion in
      if let realm = self.realm {
        let detailGames: Results<GameEntity> = {
          realm.objects(GameEntity.self)
            .filter("isFavorite == true")
        }()
        completion(.success(detailGames.toArray(ofType: GameEntity.self)))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func updateFavoriteGames(id: Int, isFavorite: Bool) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        do {
          let currentData = realm.objects(GameEntity.self).where {
            $0.id == id
        }.first!
          //Update the nil description
          try realm.write {
            currentData.setValue(isFavorite, forKey: "isFavorite")
          }
          completion(.success(true))
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func getSortedGames(sortedFromBest: Bool) -> AnyPublisher<[GameEntity], Error> {
    return Future<[GameEntity], Error> { completion in
      if let realm = self.realm {
        let detailGames: Results<GameEntity> = {
          realm.objects(GameEntity.self)
            .sorted(byKeyPath: "rating", ascending: !sortedFromBest)
        }()
        completion(.success(detailGames.toArray(ofType: GameEntity.self, limit: 10)))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func getDetailGenre(id: Int) -> AnyPublisher<GenreEntity, Error> {
    return Future<GenreEntity, Error> { completion in
      if let realm = self.realm {
        let genre: GenreEntity = {
          realm.object(ofType: GenreEntity.self, forPrimaryKey: id)
        }() ?? GenreEntity()
        completion(.success(genre))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func updateGenre(id: Int, desc: String) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        do {
          let currentData = realm.objects(GenreEntity.self).where {
            $0.id == id
        }.first!
          //Update the nil description
          try realm.write {
            currentData.setValue(desc, forKey: "desc")
          }
          completion(.success(true))
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func getGenres() -> AnyPublisher<[GenreEntity], Error> {
    return Future<[GenreEntity], Error> { completion in
      if let realm = self.realm {
        let genres: Results<GenreEntity> = {
          realm.objects(GenreEntity.self)
            .sorted(byKeyPath: "name", ascending: true)
        }()
        completion(.success(genres.toArray(ofType: GenreEntity.self)))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
 
  func addGenres(
    from genres: [GenreEntity]
  ) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        do {
          try realm.write {
            for genre in genres {
              //Should be manual because need to change from game array to game list
              let temp = GenreEntity()
              temp.id = genre.id
              temp.name = genre.name
              temp.slug = genre.slug
              temp.game_count = genre.game_count
              temp.image_background = genre.image_background
              temp.games.append(objectsIn: genre.games)
              realm.add(temp, update: .all)
            }
            completion(.success(true))
          }
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func getDevelopers() -> AnyPublisher<[DeveloperEntity], Error> {
    return Future<[DeveloperEntity], Error> { completion in
      if let realm = self.realm {
        let developers: Results<DeveloperEntity> = {
          realm.objects(DeveloperEntity.self)
            .sorted(byKeyPath: "name", ascending: true)
        }()
        completion(.success(developers.toArray(ofType: DeveloperEntity.self)))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
 
  func addDevelopers(
    from developers: [DeveloperEntity]
  ) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        do {
          try realm.write {
            for developer in developers {
              //Should be manual because need to change from game array to game list
              let temp = DeveloperEntity()
              temp.id = String(developer.id)
              temp.name = developer.name
              temp.slug = developer.slug
              temp.game_count = developer.game_count
              temp.image_background = developer.image_background
              temp.games.append(objectsIn: developer.games)
              
              realm.add(temp, update: .all)
            }
            completion(.success(true))
          }
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func getGames() -> AnyPublisher<[GameEntity], Error> {
    return Future<[GameEntity], Error> { completion in
      if let realm = self.realm {
        let detailGames: Results<GameEntity> = {
          realm.objects(GameEntity.self)
            .sorted(byKeyPath: "name", ascending: true)
        }()
        completion(.success(detailGames.toArray(ofType: GameEntity.self)))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func getBestRatingGames() -> AnyPublisher<[GameEntity], Error> {
    return Future<[GameEntity], Error> { completion in
      if let realm = self.realm {
        let detailGames: Results<GameEntity> = {
          realm.objects(GameEntity.self)
            .sorted(byKeyPath: "rating", ascending: false)
        }()
        completion(.success(detailGames.toArray(ofType: GameEntity.self, limit: 10)))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func addGames(
    from detailGames: [GameEntity]
  ) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        do {
          try realm.write {
            for game in detailGames {
              //Should be manual because need to change from game array to game list
              let temp = GameEntity()
              temp.id = game.id
              temp.name = game.name
              temp.name_original = game.name_original
              temp.slug = game.slug
              temp.desc = game.desc
              temp.released = game.released
              temp.updated = game.updated
              temp.background_image = game.background_image
              temp.background_image_additional = game.background_image_additional
              temp.website = game.website
              temp.rating = game.rating
              temp.added = game.added
              temp.playtime = game.playtime
              temp.achievements_count = game.achievements_count
              temp.ratings_count = game.ratings_count
              temp.suggestions_count = game.suggestions_count
              temp.reviews_count = game.reviews_count
              temp.description_raw = game.description_raw

              temp.parent_platforms.append(objectsIn: game.parent_platforms)
              temp.platforms.append(objectsIn: game.platforms)
              temp.stores.append(objectsIn: game.stores)
              temp.developers.append(objectsIn: game.developers)
              temp.genres.append(objectsIn: game.genres)
              temp.tags.append(objectsIn: game.tags)
              temp.publishers.append(objectsIn: game.publishers)
              temp.parent_platforms.append(objectsIn: game.parent_platforms)

              realm.add(temp, update: .all)
            }
            completion(.success(true))
          }
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func addGame(
    from game: GameEntity
  ) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        do {
          try realm.write {
            //Should be manual because need to change from game array to game list
            let temp = GameEntity()
            temp.id = game.id
            temp.name = game.name
            temp.name_original = game.name_original
            temp.slug = game.slug
            temp.desc = game.desc
            temp.released = game.released
            temp.updated = game.updated
            temp.background_image = game.background_image
            temp.background_image_additional = game.background_image_additional
            temp.website = game.website
            temp.rating = game.rating
            temp.added = game.added
            temp.playtime = game.playtime
            temp.achievements_count = game.achievements_count
            temp.ratings_count = game.ratings_count
            temp.suggestions_count = game.suggestions_count
            temp.reviews_count = game.reviews_count
            temp.description_raw = game.description_raw

            temp.parent_platforms.append(objectsIn: game.parent_platforms)
            temp.platforms.append(objectsIn: game.platforms)
            temp.stores.append(objectsIn: game.stores)
            temp.developers.append(objectsIn: game.developers)
            temp.genres.append(objectsIn: game.genres)
            temp.tags.append(objectsIn: game.tags)
            temp.publishers.append(objectsIn: game.publishers)
            temp.parent_platforms.append(objectsIn: game.parent_platforms)

            realm.add(temp, update: .all)
            completion(.success(true))
          }
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func getDetailGame(id: Int) -> AnyPublisher<GameEntity, Error> {
    return Future<GameEntity, Error> { completion in
      if let realm = self.realm {
        let detail: GameEntity = {
          realm.object(ofType: GameEntity.self, forPrimaryKey: id)
        }() ?? GameEntity()
        completion(.success(detail))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func updateGames(gameEntity: GameEntity) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        do {
          let currentData = realm.objects(GameEntity.self).where {
            $0.id == gameEntity.id
        }.first!
          //Update the all data that not added before
          
          try realm.write {
            currentData.setValue(gameEntity.slug, forKey: "slug")
            currentData.setValue(gameEntity.name_original, forKey: "name_original")
            currentData.setValue(gameEntity.desc, forKey: "desc")
            currentData.setValue(gameEntity.background_image_additional, forKey: "background_image_additional")
            currentData.setValue(gameEntity.website, forKey: "website")
            currentData.setValue(gameEntity.added, forKey: "added")
            currentData.setValue(gameEntity.playtime, forKey: "playtime")
            currentData.setValue(gameEntity.achievements_count, forKey: "achievements_count")
            currentData.setValue(gameEntity.ratings_count, forKey: "ratings_count")
            currentData.setValue(gameEntity.parent_platforms, forKey: "parent_platforms")
            currentData.setValue(gameEntity.platforms, forKey: "platforms")
            currentData.setValue(gameEntity.stores, forKey: "stores")
            currentData.setValue(gameEntity.developers, forKey: "developers")
            currentData.setValue(gameEntity.genres, forKey: "genres")
            currentData.setValue(gameEntity.tags, forKey: "tags")
            currentData.setValue(gameEntity.publishers, forKey: "publishers")
            currentData.setValue(gameEntity.description_raw, forKey: "description_raw")
          }
          completion(.success(true))
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
}

extension Results {
  func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }
  
  func toArray<T>(ofType: T.Type, limit: Int) -> [T] {
    var array = [T]()
    if(count != 0){
      for index in 0 ..< limit {
        if let result = self[index] as? T {
          array.append(result)
        }
      }
    }
    return array
  }
}
