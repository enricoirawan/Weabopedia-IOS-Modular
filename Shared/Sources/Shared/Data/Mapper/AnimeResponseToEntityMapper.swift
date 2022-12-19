//
//  AnimeResponseToEntityMapper.swift
//  
//
//  Created by Enrico Irawan on 18/12/22.
//

import Core

public struct AnimeResponseToEntityMapper: Mapper {
    public typealias From = AnimeResponse
    public typealias To = Anime
    
    public init() {}
    
    public func transform(from this: AnimeResponse) -> Anime {
        return Anime(
            id: this.id,
            images: ImageResponseToImageEntityMapper().transform(from: this.images),
            title: this.title,
            titleEnglish: this.titleEnglish ?? "-",
            type: this.type,
            episodes: this.episodes ?? 0,
            status: this.status,
            aired: AiredResponseToAiredEntityMapper().transform(from: this.aired),
            duration: this.duration,
            rating: this.rating ?? "-",
            score: this.score ?? 0.0,
            scoredBy: this.scoredBy ?? 0,
            rank: this.rank,
            synopsis: this.synopsis ?? "-",
            season: this.season ?? "?",
            year: this.year ?? 0,
            studios: FlexibleResponseToFlexibleEntytiMapper().transform(from: this.studios),
            genres: FlexibleResponseToFlexibleEntytiMapper().transform(from: this.genres)
        )
    }
}
