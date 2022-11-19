//
//  Injection.swift
//  Gametopia
//
//  Created by Patricia Fiona on 19/11/22.
//

import Foundation
import RealmSwift

final class Injection: NSObject {
  
  private func provideRepository() -> GametopiaRepositoryProtocol {
    let realm = try? Realm()

    let locale: LocaleDataSource = LocaleDataSource.sharedInstance(realm)
    let remote: RemoteDataSource = RemoteDataSource.sharedInstance

    return GametopiaRepository.sharedInstance(locale, remote)
  }

  func provideHome() -> HomeUseCase {
    let repository = provideRepository()
    return HomeInteractor(repository: repository)
  }

  func provideDetail(game: GameModel) -> DetailUseCase {
    let repository = provideRepository()
    return DetailInteractor(repository: repository, game: game)
  }

}
