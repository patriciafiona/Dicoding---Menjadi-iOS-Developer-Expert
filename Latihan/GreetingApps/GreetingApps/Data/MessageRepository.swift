//
//  MessageRepository.swift
//  GreetingApps
//
//  Created by Patricia Fiona on 13/11/22.
//

import Foundation

class MessageRepository: MessageRepositoryProtocol {
 
  private let messageDataSource: MessageDataSourceProtocol
 
  init(dataSource: MessageDataSourceProtocol) {
    self.messageDataSource = dataSource
  }
 
  func getWelcomeMessage(name: String) -> MessageEntity {
    messageDataSource.getMessageFromSource(name: name)
  }
 
}
