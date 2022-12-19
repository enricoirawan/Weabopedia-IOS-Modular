//
//  AnimeEntityToObjectMapper.swift
//  
//
//  Created by Enrico Irawan on 19/12/22.
//

import Core

public struct AnimeEntityToObjectMapper: Mapper {
    public typealias From = Anime
    public typealias To = AnimeObject
    
    public init() {}
    
    public func transform(from this: Anime) -> AnimeObject {
        return AnimeObject(
            id: this.id,
            imageUrl: this.images.jpg.imageURL,
            title: this.title,
            status: this.status,
            duration: this.duration,
            score: this.score,
            scoreBy: this.scoredBy
        )
    }
}
