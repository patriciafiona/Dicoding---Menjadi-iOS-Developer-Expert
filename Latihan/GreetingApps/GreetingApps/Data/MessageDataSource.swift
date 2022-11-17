//
//  MessageDataSource.swift
//  GreetingApps
//
//  Created by Patricia Fiona on 13/11/22.
//

import Foundation

class MessageDataSource: MessageDataSourceProtocol {
  func getMessageFromSource(name: String) -> MessageEntity {
    return MessageEntity(
      welcomeMessage: "Hello \(name) Welcome to Clean Architecture"
    )
  }
}
