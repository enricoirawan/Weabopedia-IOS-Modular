//
//  GetAnimeDetailDataSource.swift
//  
//
//  Created by Enrico Irawan on 18/12/22.
import Alamofire
import Combine
import Shared
import Core
import Foundation

public struct GetAnimeDetailDataSource: RemoteDataSource {
    public typealias Request = Int
    public typealias Response = AnimeResponse
    
    public func execute(request: Int?) -> AnyPublisher<AnimeResponse, Error> {
        return Future<AnimeResponse, Error> { completion in
            if let url = URL(string: "\(Endpoints.Get.anime.url)/\(request!)") {
                AF.request(url)
                  .validate()
                  .responseDecodable(of: AnimeDetailResponse.self) { response in
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
