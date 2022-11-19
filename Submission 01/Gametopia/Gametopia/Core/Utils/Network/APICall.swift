//
//  APICall.swift
//  Gametopia
//
//  Created by Patricia Fiona on 19/11/22.
//

import Foundation

struct API {
  static let baseUrl = "https://api.rawg.io/api/"
}

protocol Endpoint {
  var url: String { get }
}

enum Endpoints {
  
  enum Gets: Endpoint {
    case games
    case genres
    case developers
    
    public var url: String {
      switch self {
      case .games: return "\(API.baseUrl)games"
      case .genres: return "\(API.baseUrl)genres"
      case .developers: return "\(API.baseUrl)developers"
      }
    }
  }
  
}
