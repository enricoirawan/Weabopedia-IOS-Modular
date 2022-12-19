//
//  SearchAnimeRemoteDataSource.swift
//  
//
//  Created by Enrico Irawan on 19/12/22.
//

import Foundation
import Alamofire
import Combine
import Shared
import Core

public struct SearchAnimeRemoteDataSource: RemoteDataSource {
    public typealias Request = String
    public typealias Response = [AnimeResponse]
    
    public func execute(request: String?) -> AnyPublisher<[AnimeResponse], Error> {
        return Future<[AnimeResponse], Error> { completion in
            var components = URLComponents(string: Endpoints.Get.anime.url)!
            components.queryItems = [
                URLQueryItem(name: "q", value: request),
                URLQueryItem(name: "page", value: "1"),
                URLQueryItem(name: "limit", value: "10"),
                URLQueryItem(name: "sort", value: "asc"),
                URLQueryItem(name: "order_by", value: "popularity")
            ]
            
            if let url = components.url {
                AF.request(url)
                  .validate()
                  .responseDecodable(of: AnimeResponses.self) { response in
                    switch response.result {
                    case .success(let value):
                        completion(.success(value.data))
                    case .failure:
                      completion(.failure(URLError.invalidResponse))
                    }
                  }
            }
        }.eraseToAnyPublisher()
    }
}
