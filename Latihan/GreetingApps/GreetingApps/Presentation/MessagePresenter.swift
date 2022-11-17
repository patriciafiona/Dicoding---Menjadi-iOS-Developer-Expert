//
//  MessagePresenter.swift
//  GreetingApps
//
//  Created by Patricia Fiona on 13/11/22.
//

import Foundation

class MessagePresenter: MessagePresenterProtocol {
 
  private let messageUseCase: MessageUseCase
 
  init(useCase: MessageUseCase) {
    self.messageUseCase = useCase
  }
 
  func getMessage(name: String) -> MessageEntity {
    return messageUseCase.getMessage(name: name)
  }
 
}
