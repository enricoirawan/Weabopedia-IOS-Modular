//
//  DeleteFavoriteAnimeRepository.swift
//  
//
//  Created by Enrico Irawan on 19/12/22.
//

import Combine
import Core
import Shared

public struct DeleteFavoriteAnimeRepository: Repository {
    public typealias Request = Int
    public typealias Response = Bool
    
    private let localDataSource: DeleteFavoriteAnimeDataSource
    
    public init(
        localDataSource: DeleteFavoriteAnimeDataSource
    ) {
        self.localDataSource = localDataSource
    }
    
    public func execute(request: Int?) -> AnyPublisher<Bool, Error> {
        return localDataSource.execute(request: request).eraseToAnyPublisher()
    }
}
