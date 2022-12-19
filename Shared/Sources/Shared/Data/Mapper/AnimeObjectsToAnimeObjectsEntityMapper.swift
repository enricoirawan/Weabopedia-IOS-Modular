//
//  AnimeObjectsToAnimeObjectsEntityMapper.swift
//  
//
//  Created by Enrico Irawan on 19/12/22.
//

import Core

public struct AnimeObjectsToAnimeObjectsEntityMapper: Mapper {
    public typealias From = [AnimeObject]
    public typealias To = [AnimeObjectEntity]
    
    public init() {}
    
    public func transform(from this: [AnimeObject]) -> [AnimeObjectEntity] {
        return this.map { animeObject in
            return AnimeObjectEntity(
                id: animeObject.id,
                imageUrl: animeObject.imageUrl,
                title: animeObject.title,
                status: animeObject.status,
                duration: animeObject.duration,
                score: animeObject.score,
                scoredBy: animeObject.scoreBy
            )
        }
    }
}
