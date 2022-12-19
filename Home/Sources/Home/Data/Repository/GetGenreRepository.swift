//
//  GetGenreRepository.swift
//  
//
//  Created by Enrico Irawan on 18/12/22.
//
import Combine
import Core

public struct GetGenreRepository: Repository {
    public typealias Request = Any
    public typealias Response = [Genre]
    
    private let remoteDataSource: GetGenreRemoteDataSource
    private let mapper: GenreResponseToGenreEntityMapper
    
    public init(
        remoteDataSource: GetGenreRemoteDataSource,
        mapper: GenreResponseToGenreEntityMapper
    ) {
        self.remoteDataSource = remoteDataSource
        self.mapper = mapper
    }
    
    public func execute(request: Request?) -> AnyPublisher<[Genre], Error> {
        return remoteDataSource.execute(request: request)
            .map { mapper.transform(from: $0) }
            .eraseToAnyPublisher()
    }
}
