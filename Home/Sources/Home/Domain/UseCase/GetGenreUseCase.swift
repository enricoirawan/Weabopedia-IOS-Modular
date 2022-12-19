//
//  GetGenreUseCase.swift
//  
//
//  Created by Enrico Irawan on 18/12/22.
//

import Core
import Combine

public struct GetGenreUseCase: UseCase {
    public typealias Request = Any
    public typealias Response = [Genre]
    
    private let repository: GetGenreRepository
    
    public init(repository: GetGenreRepository) {
        self.repository = repository
    }
    
    public func execute(request: Request?) -> AnyPublisher<[Genre], Error> {
        return repository.execute(request: request)
    }
}
