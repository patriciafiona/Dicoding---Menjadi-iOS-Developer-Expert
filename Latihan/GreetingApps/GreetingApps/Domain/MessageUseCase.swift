//
//  MessageUseCase.swift
//  GreetingApps
//
//  Created by Patricia Fiona on 13/11/22.
//

import Foundation

protocol MessageUseCase {
  func getMessage(name: String) -> MessageEntity
}
