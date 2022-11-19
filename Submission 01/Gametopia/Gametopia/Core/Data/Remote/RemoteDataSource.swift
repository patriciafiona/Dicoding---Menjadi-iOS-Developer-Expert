//
//  RemoteDataSource.swift
//  Gametopia
//
//  Created by Patricia Fiona on 19/11/22.
//

import Foundation
import Alamofire
import Combine

let apiKey = Bundle.main.infoDictionary?["API_KEY"] as! String
let orderByRatingAsc = "rating"
let orderByRatingDesc = "-rating"
let page = "1"

protocol RemoteDataSourceProtocol: AnyObject {
  func getAllDiscoveryGame(sortFromBest: Bool) -> AnyPublisher<[GameResult], Error>
  func getFewDiscoveryGame() -> AnyPublisher<[GameResult], Error>
//  func getListGenres() -> AnyPublisher<[GenreResponse], Error>
//  func getListDevelopers() -> AnyPublisher<[DeveloperResponse], Error>
//  func getSearchResults(keyword: String) -> AnyPublisher<[SearchResponse], Error>
//  func getGameDetails(id: Int) -> AnyPublisher<[DetailGameResponse], Error>
//  func getGenreDetails(id: Int) -> AnyPublisher<[GenreDetailResponse], Error>
}

final class RemoteDataSource: NSObject {
  private override init() { }
  static let sharedInstance: RemoteDataSource =  RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
  func getAllDiscoveryGame(sortFromBest: Bool) -> AnyPublisher<[GameResult], Error> {
    let param = ["key": apiKey, "ordering": sortFromBest == true ? orderByRatingDesc: orderByRatingAsc]
    return Future<[GameResult], Error> { completion in
      if let url = URL(string: Endpoints.Gets.games.url) {
        AF.request(
          url,
          method: .get,
          parameters: param
        )
          .validate()
          .responseDecodable(of: GameResponse.self) { response in
            switch response.result {
              case .success(let value):
                completion(.success(value.results!))
              case .failure:
                completion(.failure(URLError.invalidResponse))
            }
          }
      }
    }.eraseToAnyPublisher()
  }
  
  func getFewDiscoveryGame() -> AnyPublisher<[GameResult], Error> {
    return Future<[GameResult], Error> { completion in
      if let url = URL(string: Endpoints.Gets.games.url) {
        AF.request(
          url,
          method: .get,
          parameters: ["key": apiKey, "ordering": orderByRatingDesc, "page_size": "10"]
        )
          .validate()
          .responseDecodable(of: GameResponse.self) { response in
            switch response.result {
              case .success(let value):
                completion(.success(value.results!))
              case .failure:
                completion(.failure(URLError.invalidResponse))
            }
          }
      }
    }.eraseToAnyPublisher()
  }
}

extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}
