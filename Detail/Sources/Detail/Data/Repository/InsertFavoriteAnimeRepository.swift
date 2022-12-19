//
//  InsertFavoriteAnimeRepository.swift
//  
//
//  Created by Enrico Irawan on 19/12/22.
//
import Combine
import Core
import Shared

public struct InsertFavoriteAnimeRepository: Repository {
    public typealias Request = Anime
    public typealias Response = Bool
    
    private let localDataSource: InsertFavoriteAnimeDataSource
    private let mapper: AnimeEntityToObjectMapper
    
    public init(
        localDataSource: InsertFavoriteAnimeDataSource,
        mapper: AnimeEntityToObjectMapper
    ) {
        self.localDataSource = localDataSource
        self.mapper = mapper
    }
    
    public func execute(request: Anime?) -> AnyPublisher<Bool, Error> {
        return localDataSource.execute(request: mapper.transform(from: request!))
            .eraseToAnyPublisher()
    }
}
