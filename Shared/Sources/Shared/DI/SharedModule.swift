//
//  SharedModule.swift
//  
//
//  Created by Enrico Irawan on 18/12/22.
//

import Swinject

public class SharedModule {
    public init() {}
    
    public let container: Container = {
        let container = Container()
        
        // MARK: Mapper
        container.register(AnimeResponsesToEntityMapper.self) { _ in
            AnimeResponsesToEntityMapper()
        }
        container.register(AnimeResponseToEntityMapper.self) { _ in
            AnimeResponseToEntityMapper()
        }
        container.register(AnimeEntityToObjectMapper.self) { _ in
            AnimeEntityToObjectMapper()
        }
        container.register(AnimeObjectsToAnimeObjectsEntityMapper.self) { _ in
            AnimeObjectsToAnimeObjectsEntityMapper()
        }
        
        return container
    }()
}
