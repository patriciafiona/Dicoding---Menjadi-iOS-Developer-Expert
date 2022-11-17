//
//  MessageRepositoryProtocol.swift
//  GreetingApps
//
//  Created by Patricia Fiona on 13/11/22.
//

import Foundation

protocol MessageRepositoryProtocol {
  func getWelcomeMessage(name: String) -> MessageEntity
}
