//
//  InsertFavoriteAnimeUseCase.swift
//  
//
//  Created by Enrico Irawan on 19/12/22.
//

import Core
import Combine
import Shared

public struct InsertFavoriteAnimeUseCase: UseCase {
    public typealias Request = Anime
    public typealias Response = Bool
    
    private let repository: InsertFavoriteAnimeRepository
    
    public init(repository: InsertFavoriteAnimeRepository) {
        self.repository = repository
    }
    
    public func execute(request: Anime?) -> AnyPublisher<Bool, Error> {
        return repository.execute(request: request)
    }
}
