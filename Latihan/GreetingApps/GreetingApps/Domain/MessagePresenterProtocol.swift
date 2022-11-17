//
//  MessagePresenterProtocol.swift
//  GreetingApps
//
//  Created by Patricia Fiona on 13/11/22.
//

import Foundation

protocol MessagePresenterProtocol: class {
  func getMessage(name: String) -> MessageEntity
}
