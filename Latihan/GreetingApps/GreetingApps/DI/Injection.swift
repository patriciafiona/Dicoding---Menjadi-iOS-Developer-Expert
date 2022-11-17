//
//  Injection.swift
//  GreetingApps
//
//  Created by Patricia Fiona on 13/11/22.
//

import Foundation

final class Injection: NSObject {
 
  private func provideDataSource() -> MessageDataSourceProtocol {
    return MessageDataSource()
  }
 
  private func provideRepository() -> MessageRepositoryProtocol {
    let messageDataSource = provideDataSource()
    return MessageRepository(dataSource: messageDataSource)
  }
 
  func provideUseCase() -> MessageUseCase {
    let messageRepository = provideRepository()
    return MessageInteractor(repository: messageRepository)
  }
 
}
