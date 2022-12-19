//
//  GetListFavoriteAnimeUseCase.swift
//  
//
//  Created by Enrico Irawan on 19/12/22.
//

import Core
import Combine
import Shared

public struct GetListFavoriteAnimeUseCase: UseCase {
    public typealias Request = Any
    public typealias Response = [AnimeObjectEntity]
    
    private let repository: GetListFavoriteAnimeRepository
    
    public init(repository: GetListFavoriteAnimeRepository) {
        self.repository = repository
    }
    
    public func execute(request: Any?) -> AnyPublisher<[AnimeObjectEntity], Error> {
        return repository.execute(request: request)
    }
}
