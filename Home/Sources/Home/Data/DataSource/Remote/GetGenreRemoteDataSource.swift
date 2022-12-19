//
//  GetGenreRemoteDataSource.swift
//  
//
//  Created by Enrico Irawan on 18/12/22.
//

import Foundation
import Alamofire
import Combine
import Shared
import Core

public struct GetGenreRemoteDataSource: RemoteDataSource {
    public typealias Request = Any
    public typealias Response = [GenreResponse]
    
    public func execute(request: Any?) -> AnyPublisher<[GenreResponse], Error> {
        return Future<[GenreResponse], Error> { completion in
            var components = URLComponents(string: Endpoints.Get.genre.url)!
            components.queryItems = [
                URLQueryItem(name: "filter", value: "genres")
            ]
            
            if let url = components.url {
                AF.request(url)
                  .validate()
                  .responseDecodable(of: GenreResponses.self) { response in
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
