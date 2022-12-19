//
//  FavoriteModule.swift
//  
//
//  Created by Enrico Irawan on 19/12/22.
//

import Shared
import Swinject
import RealmSwift

public class FavoriteModule {
    public init() {}
    
    public let container: Container = {
        let container = Container()
        // MARK: DataSource
        container.register(GetListFavoriteAnimeDataSource.self) { _ in
            GetListFavoriteAnimeDataSource(realm: try! Realm())
        }
        
        // MARK: Repository
        container.register(GetListFavoriteAnimeRepository.self) { resolver in
            GetListFavoriteAnimeRepository(
                localDataSource: resolver.resolve(GetListFavoriteAnimeDataSource.self)!,
                mapper: SharedModule().container.resolve(
                    AnimeObjectsToAnimeObjectsEntityMapper.self
                )!
            )
        }
        
        // MARK: UseCase
        container.register(GetListFavoriteAnimeUseCase.self) { resolver in
            GetListFavoriteAnimeUseCase(
                repository: resolver.resolve(GetListFavoriteAnimeRepository.self)!
            )
        }
        
        // MARK: ViewController
        container.register(FavoriteViewController.self) { resolver in
            let controller = FavoriteViewController()
            controller.getFavoriteListUseCase = resolver.resolve(GetListFavoriteAnimeUseCase.self)
            return controller
        }
        
        return container
    }()
}
