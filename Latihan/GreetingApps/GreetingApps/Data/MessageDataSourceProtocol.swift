//
//  MessageDataSourceProtocol.swift
//  GreetingApps
//
//  Created by Patricia Fiona on 13/11/22.
//

import Foundation

protocol MessageDataSourceProtocol {
  func getMessageFromSource(name: String) -> MessageEntity
}
