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
  
  func getGames() -> AnyPublisher<[DetailGameEntity], Error>
//  func addGames(from detailGames: [DetailGameEntity]) -> AnyPublisher<Bool, Error>
  func addGames(from game: DetailGameEntity) -> AnyPublisher<Bool, Error>
  func getDetailGame(id: Int) -> AnyPublisher<DetailGameEntity, Error>
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
    print("Desc: \(desc)")
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        do {
          let currentData = realm.objects(GenreEntity.self).where {
            $0.id == id
        }.first!
          //Update the nil description
          try realm.write {
//            currentData.desc = desc
            currentData.setValue(desc, forKey: "desc")
          }
          completion(.success(true))
          print("SUCCESS UPDATED GENRE ENTITY")
        } catch {
          print("REQUEST FAILED")
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        print("INVALID INSTANCE")
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
  
  func getGames() -> AnyPublisher<[DetailGameEntity], Error> {
    return Future<[DetailGameEntity], Error> { completion in
      if let realm = self.realm {
        let detailGames: Results<DetailGameEntity> = {
          realm.objects(DetailGameEntity.self)
            .sorted(byKeyPath: "name", ascending: true)
        }()
        completion(.success(detailGames.toArray(ofType: DetailGameEntity.self)))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func addGames(
    from game: DetailGameEntity
  ) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        do {
          try realm.write {
            //Should be manual because need to change from game array to game list
            let temp = DetailGameEntity()
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
  
//  func addGames(
//    from detailGames: [DetailGameEntity]
//  ) -> AnyPublisher<Bool, Error> {
//    return Future<Bool, Error> { completion in
//      if let realm = self.realm {
//        do {
//          try realm.write {
//            for game in detailGames {
//              //Should be manual because need to change from game array to game list
//              let temp = DetailGameEntity()
//              temp.id = String(game.id)
//              temp.name = game.name
//              temp.name_original = game.name_original
//              temp.slug = game.slug
//              temp.desc = game.desc
//              temp.released = game.released
//              temp.updated = game.updated
//              temp.background_image = game.background_image
//              temp.background_image_additional = game.background_image_additional
//              temp.website = game.website
//              temp.rating = game.rating
//              temp.added = game.added
//              temp.playtime = game.playtime
//              temp.achievements_count = game.achievements_count
//              temp.ratings_count = game.ratings_count
//              temp.suggestions_count = game.suggestions_count
//              temp.reviews_count = game.reviews_count
//              temp.description_raw = game.description_raw
//
//              temp.parent_platforms.append(objectsIn: game.parent_platforms)
//              temp.platforms.append(objectsIn: game.platforms)
//              temp.stores.append(objectsIn: game.stores)
//              temp.developers.append(objectsIn: game.developers)
//              temp.genres.append(objectsIn: game.genres)
//              temp.tags.append(objectsIn: game.tags)
//              temp.publishers.append(objectsIn: game.publishers)
//              temp.parent_platforms.append(objectsIn: game.parent_platforms)
//
//              realm.add(temp, update: .all)
//            }
//            completion(.success(true))
//          }
//        } catch {
//          completion(.failure(DatabaseError.requestFailed))
//        }
//      } else {
//        completion(.failure(DatabaseError.invalidInstance))
//      }
//    }.eraseToAnyPublisher()
//  }
  
  func getDetailGame(id: Int) -> AnyPublisher<DetailGameEntity, Error> {
    return Future<DetailGameEntity, Error> { completion in
      if let realm = self.realm {
        let detail: DetailGameEntity = {
          realm.object(ofType: DetailGameEntity.self, forPrimaryKey: id)
        }() ?? DetailGameEntity()
        completion(.success(detail))
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
}
