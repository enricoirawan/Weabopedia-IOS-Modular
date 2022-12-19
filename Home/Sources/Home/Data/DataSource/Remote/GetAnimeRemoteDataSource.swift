//
//  GetAnimeRemoteDataSource.swift
//  
//
//  Created by Enrico Irawan on 18/12/22.
//
import Foundation
import Alamofire
import Combine
import Shared
import Core

public struct GetAnimeRemoteDataSource: RemoteDataSource {
    public typealias Request = Int
    public typealias Response = [AnimeResponse]
    
    public func execute(request: Int?) -> AnyPublisher<[AnimeResponse], Error> {
        return Future<[AnimeResponse], Error> { completion in
            var components = URLComponents(string: Endpoints.Get.anime.url)!
            components.queryItems = [
                URLQueryItem(name: "genres", value: "\(request!)"),
                URLQueryItem(name: "page", value: "1"),
                URLQueryItem(name: "limit", value: "10"),
                URLQueryItem(name: "sort", value: "asc"),
                URLQueryItem(name: "order_by", value: "popularity"),
                URLQueryItem(name: "min_score", value: "7")
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
