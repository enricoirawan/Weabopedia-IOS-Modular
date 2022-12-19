//
//  DetailModule.swift
//  
//
//  Created by Enrico Irawan on 18/12/22.
//
import Shared
import Swinject
import RealmSwift

public class DetailModule {
    public init() {}
    
    public let container: Container = {
        let container = Container()
        
        // MARK: DataSource
        container.register(GetAnimeDetailDataSource.self) { _ in
            GetAnimeDetailDataSource()
        }
        container.register(InsertFavoriteAnimeDataSource.self) { _ in
            InsertFavoriteAnimeDataSource(realm: try! Realm())
        }
        container.register(DeleteFavoriteAnimeDataSource.self) { _ in
            DeleteFavoriteAnimeDataSource(realm: try! Realm())
        }
        container.register(CheckIsFavoriteDataSource.self) { _ in
            CheckIsFavoriteDataSource(realm: try! Realm())
        }
        
        // MARK: Repository
        container.register(GetAnimeDetailRepository.self) { resolver in
            GetAnimeDetailRepository(
                remoteDataSource: resolver.resolve(GetAnimeDetailDataSource.self)!,
                mapper: SharedModule().container.resolve(AnimeResponseToEntityMapper.self)!
            )
        }
        container.register(InsertFavoriteAnimeRepository.self) { resolver in
            InsertFavoriteAnimeRepository(
                localDataSource: resolver.resolve(InsertFavoriteAnimeDataSource.self)!,
                mapper: SharedModule().container.resolve(AnimeEntityToObjectMapper.self)!
            )
        }
        container.register(DeleteFavoriteAnimeRepository.self) { resolver in
            DeleteFavoriteAnimeRepository(
                localDataSource: resolver.resolve(DeleteFavoriteAnimeDataSource.self)!
            )
        }
        container.register(CheckIsFavoriteAnimeRepository.self) { resolver in
            CheckIsFavoriteAnimeRepository(
                localDataSource: resolver.resolve(CheckIsFavoriteDataSource.self)!
            )
        }
        
        // MARK: UseCase
        container.register(GetAnimeDetailUseCase.self) { resolver in
            GetAnimeDetailUseCase(
                repository: resolver.resolve(GetAnimeDetailRepository.self)!
            )
        }
        container.register(InsertFavoriteAnimeUseCase.self) { resolver in
            InsertFavoriteAnimeUseCase(
                repository: resolver.resolve(InsertFavoriteAnimeRepository.self)!
            )
        }
        container.register(DeleteFavoriteAnimeUseCase.self) { resolver in
            DeleteFavoriteAnimeUseCase(
                repository: resolver.resolve(DeleteFavoriteAnimeRepository.self)!
            )
        }
        container.register(CheckIsFavoriteAnimeUseCase.self) { resolver in
            CheckIsFavoriteAnimeUseCase(
                repository: resolver.resolve(CheckIsFavoriteAnimeRepository.self)!
            )
        }
        
        // MARK: ViewController
        container.register(DetailViewController.self) { resolver in
            let controller = DetailViewController()
            controller.getAnimeDetailUseCase = resolver.resolve(GetAnimeDetailUseCase.self)
            controller.insertAnimeToFavoriteUseCase = resolver.resolve(InsertFavoriteAnimeUseCase.self)
            controller.deleteAnimeFromFavoriteUseCase = resolver.resolve(DeleteFavoriteAnimeUseCase.self)
            controller.checkIsFavoriteUseCase = resolver.resolve(CheckIsFavoriteAnimeUseCase.self)
            return controller
        }
        
        return container
    }()
}
