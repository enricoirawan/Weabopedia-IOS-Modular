//
//  SearchAnimeUseCase.swift
//  
//
//  Created by Enrico Irawan on 19/12/22.
//

import Core
import Combine
import Shared

public struct SearchAnimeUseCase: UseCase {
    public typealias Request = String
    public typealias Response = [Anime]
    
    private let repository: SearchAnimeRepository
    
    public init(repository: SearchAnimeRepository) {
        self.repository = repository
    }
    
    public func execute(request: String?) -> AnyPublisher<[Anime], Error> {
        return repository.execute(request: request)
    }
}
