//
//  DeleteFavoriteAnimeUseCase.swift
//  
//
//  Created by Enrico Irawan on 19/12/22.
//

import Core
import Combine
import Shared

public struct DeleteFavoriteAnimeUseCase: UseCase {
    public typealias Request = Int
    public typealias Response = Bool
    
    private let repository: DeleteFavoriteAnimeRepository
    
    public init(repository: DeleteFavoriteAnimeRepository) {
        self.repository = repository
    }
    
    public func execute(request: Int?) -> AnyPublisher<Bool, Error> {
        return repository.execute(request: request)
    }
}
