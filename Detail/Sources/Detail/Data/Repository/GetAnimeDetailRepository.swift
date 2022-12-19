//
//  GetAnimeDetailRepository.swift
//  
//
//  Created by Enrico Irawan on 18/12/22.
//

import Combine
import Core
import Shared

public struct GetAnimeDetailRepository: Repository {
    public typealias Request = Int
    public typealias Response = Anime
    
    private let remoteDataSource: GetAnimeDetailDataSource
    private let mapper: AnimeResponseToEntityMapper
    
    public init(
        remoteDataSource: GetAnimeDetailDataSource,
        mapper: AnimeResponseToEntityMapper
    ) {
        self.remoteDataSource = remoteDataSource
        self.mapper = mapper
    }

    public func execute(request: Int?) -> AnyPublisher<Anime, Error> {
        return remoteDataSource.execute(request: request)
            .map { mapper.transform(from: $0) }
            .eraseToAnyPublisher()
    }
}
