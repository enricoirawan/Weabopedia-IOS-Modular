//
//  SearchAnimeRepository.swift
//  
//
//  Created by Enrico Irawan on 19/12/22.
//

import Combine
import Core
import Shared

public struct SearchAnimeRepository: Repository {
    public typealias Request = String
    public typealias Response = [Anime]
    
    private let remoteDataSource: SearchAnimeRemoteDataSource
    private let mapper: AnimeResponsesToEntityMapper
    
    public init(
        remoteDataSource: SearchAnimeRemoteDataSource,
        mapper: AnimeResponsesToEntityMapper
    ) {
        self.remoteDataSource = remoteDataSource
        self.mapper = mapper
    }

    public func execute(request: String?) -> AnyPublisher<[Anime], Error> {
        return remoteDataSource.execute(request: request)
            .map { mapper.transform(from: $0) }
            .eraseToAnyPublisher()
    }
}
