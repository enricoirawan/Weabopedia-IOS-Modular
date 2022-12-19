//
//  HomeModule.swift
//  
//
//  Created by Enrico Irawan on 18/12/22.
//

import Swinject
import Shared

public class HomeModule {
    public init() {}
    
    public let container: Container = {
        let container = Container()
        
        // MARK: Mapper
        container.register(GenreResponseToGenreEntityMapper.self) { _ in
            GenreResponseToGenreEntityMapper()
        }
        
        // MARK: DataSource
        container.register(GetAnimeRemoteDataSource.self) { _ in
            GetAnimeRemoteDataSource()
        }
        container.register(GetGenreRemoteDataSource.self) { _ in
            GetGenreRemoteDataSource()
        }
        
        // MARK: Repository
        container.register(GetAnimeRepository.self) { resolver in
            GetAnimeRepository(
                remoteDataSource: resolver.resolve(GetAnimeRemoteDataSource.self)!,
                mapper: SharedModule().container.resolve(AnimeResponsesToEntityMapper.self)!
            )
        }
        container.register(GetGenreRepository.self) { resolver in
            GetGenreRepository(
                remoteDataSource: resolver.resolve(GetGenreRemoteDataSource.self)!,
                mapper: resolver.resolve(GenreResponseToGenreEntityMapper.self)!
            )
        }
        
        // MARK: UseCase
        container.register(GetAnimeUseCase.self) { resolver in
            GetAnimeUseCase(repository: resolver.resolve(GetAnimeRepository.self)!)
        }
        container.register(GetGenreUseCase.self) { resolver in
            GetGenreUseCase(repository: resolver.resolve(GetGenreRepository.self)!)
        }
        
        // MARK: ViewController
        container.register(HomeViewController.self) { resolver in
            let controller = HomeViewController()
            controller.getAnimeUseCase = resolver.resolve(GetAnimeUseCase.self)
            controller.getGenreUseCase = resolver.resolve(GetGenreUseCase.self)
            return controller
        }
        
        return container
    }()
}
