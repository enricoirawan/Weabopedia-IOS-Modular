//
//  GetAnimeRepository.swift
//  
//
//  Created by Enrico Irawan on 18/12/22.
//
import Combine
import Core
import Shared

public struct GetAnimeRepository: Repository {
    public typealias Request = Int
    public typealias Response = [Anime]
    
    private let remoteDataSource: GetAnimeRemoteDataSource
    private let mapper: AnimeResponsesToEntityMapper
    
    public init(
        remoteDataSource: GetAnimeRemoteDataSource,
        mapper: AnimeResponsesToEntityMapper
    ) {
        self.remoteDataSource = remoteDataSource
        self.mapper = mapper
    }

    public func execute(request: Int?) -> AnyPublisher<[Anime], Error> {
        return remoteDataSource.execute(request: request)
            .map { mapper.transform(from: $0) }
            .eraseToAnyPublisher()
    }
}
