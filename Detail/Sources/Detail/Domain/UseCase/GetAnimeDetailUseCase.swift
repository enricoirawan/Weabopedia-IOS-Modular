//
//  GetAnimeDetailUseCase.swift
//  
//
//  Created by Enrico Irawan on 18/12/22.
//

import Core
import Combine
import Shared

public struct GetAnimeDetailUseCase: UseCase {
    public typealias Request = Int
    public typealias Response = Anime
    
    private let repository: GetAnimeDetailRepository
    
    public init(repository: GetAnimeDetailRepository) {
        self.repository = repository
    }
    
    public func execute(request: Int?) -> AnyPublisher<Anime, Error> {
        return repository.execute(request: request)
    }
}
