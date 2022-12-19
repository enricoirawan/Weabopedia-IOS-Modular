//
//  GetListFavoriteAnimeRepository.swift
//  
//
//  Created by Enrico Irawan on 19/12/22.
//

import Combine
import Core
import Shared

public struct GetListFavoriteAnimeRepository: Repository {
    public typealias Request = Any
    public typealias Response = [AnimeObjectEntity]
    
    private let localDataSource: GetListFavoriteAnimeDataSource
    private let mapper: AnimeObjectsToAnimeObjectsEntityMapper
    
    public init(
        localDataSource: GetListFavoriteAnimeDataSource,
        mapper: AnimeObjectsToAnimeObjectsEntityMapper
    ) {
        self.localDataSource = localDataSource
        self.mapper = mapper
    }
    
    public func execute(request: Any?) -> AnyPublisher<[AnimeObjectEntity], Error> {
        return localDataSource.execute(request: request)
            .map { mapper.transform(from: $0) }
            .eraseToAnyPublisher()
    }
}
