//
//  MessageInteractor.swift
//  GreetingApps
//
//  Created by Patricia Fiona on 13/11/22.
//

import Foundation

class MessageInteractor: MessageUseCase {
 
  private let messageRepository: MessageRepositoryProtocol
  init(repository: MessageRepositoryProtocol) {
    self.messageRepository = repository
  }
 
  func getMessage(name: String) -> MessageEntity {
    return messageRepository.getWelcomeMessage(name: name)
  }
 
}
