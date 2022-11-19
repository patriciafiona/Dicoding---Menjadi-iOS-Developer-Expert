//
//  LocaleDataSource.swift
//  Gametopia
//
//  Created by Patricia Fiona on 19/11/22.
//

import Foundation
import RealmSwift
import Combine

final class LocaleDataSource: NSObject {
  private let realm: Realm?

  private init(realm: Realm?) {
    self.realm = realm
  }

  static let sharedInstance: (Realm?) -> LocaleDataSource = { realmDatabase in
    return LocaleDataSource(realm: realmDatabase)
  }
}
