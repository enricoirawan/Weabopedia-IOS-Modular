//
//  GetAnimeUseCase.swift
//  
//
//  Created by Enrico Irawan on 18/12/22.
//

import Core
import Combine
import Shared

public struct GetAnimeUseCase: UseCase {
    public typealias Request = Int
    public typealias Response = [Anime]
    
    private let repository: GetAnimeRepository
    
    public init(repository: GetAnimeRepository) {
        self.repository = repository
    }
    
    public func execute(request: Int?) -> AnyPublisher<[Anime], Error> {
        return repository.execute(request: request)
    }
}
