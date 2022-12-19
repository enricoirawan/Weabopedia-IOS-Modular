//
//  SearchModule.swift
//  
//
//  Created by Enrico Irawan on 19/12/22.
//

import Swinject
import Shared

public class SearchModule {
    public init() {}
    
    public let container: Container = {
        let container = Container()
        
        // MARK: DataSource
        container.register(SearchAnimeRemoteDataSource.self) { _ in
            SearchAnimeRemoteDataSource()
        }
        
        // MARK: Repository
        container.register(SearchAnimeRepository.self) { resolver in
            SearchAnimeRepository(
                remoteDataSource: resolver.resolve(SearchAnimeRemoteDataSource.self)!,
                mapper: SharedModule().container.resolve(AnimeResponsesToEntityMapper.self)!
            )
        }
        
        // MARK: UseCase
        container.register(SearchAnimeUseCase.self) { resolver in
            SearchAnimeUseCase(repository: resolver.resolve(SearchAnimeRepository.self)!)
        }
        
        // MARK: ViewController
        container.register(SearchViewController.self) { resolver in
            let controller = SearchViewController()
            controller.searchAnimeUseCase = resolver.resolve(SearchAnimeUseCase.self)
            return controller
        }
        
        return container
    }()
}
