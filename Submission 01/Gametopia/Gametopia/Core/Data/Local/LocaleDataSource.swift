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
  func addGenres(from categories: [GenreEntity]) -> AnyPublisher<Bool, Error>
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
              temp.id = String(genre.id)
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
