//
//  CheckIsFavoriteAnimeUseCase.swift
//  
//
//  Created by Enrico Irawan on 19/12/22.
//

import Core
import Combine
import Shared

public struct CheckIsFavoriteAnimeUseCase: UseCase {
    public typealias Request = Int
    public typealias Response = Bool
    
    private let repository: CheckIsFavoriteAnimeRepository
    
    public init(repository: CheckIsFavoriteAnimeRepository) {
        self.repository = repository
    }
    
    public func execute(request: Int?) -> AnyPublisher<Bool, Error> {
        return repository.execute(request: request)
    }
}
