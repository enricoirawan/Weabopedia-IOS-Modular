//
//  CheckIsFavoriteAnimeRepository.swift
//  
//
//  Created by Enrico Irawan on 19/12/22.
//

import Combine
import Core
import Shared

public struct CheckIsFavoriteAnimeRepository: Repository {
    public typealias Request = Int
    public typealias Response = Bool
    
    private let localDataSource: CheckIsFavoriteDataSource
    
    public init(
        localDataSource: CheckIsFavoriteDataSource
    ) {
        self.localDataSource = localDataSource
    }
    
    public func execute(request: Int?) -> AnyPublisher<Bool, Error> {
        return localDataSource.execute(request: request).eraseToAnyPublisher()
    }
}
