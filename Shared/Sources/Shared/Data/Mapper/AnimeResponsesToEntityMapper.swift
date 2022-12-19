//
//  AnimeResponsesToEntityMapper.swift
//  
//
//  Created by Enrico Irawan on 18/12/22.
//
import Core

public struct AnimeResponsesToEntityMapper: Mapper {
    public typealias From = [AnimeResponse]
    public typealias To = [Anime]
    
    public init() {}
    
    public func transform(from this: [AnimeResponse]) -> [Anime] {
        return this.map { result in
            return Anime(
                id: result.id,
                images: ImageResponseToImageEntityMapper().transform(from: result.images),
                title: result.title,
                titleEnglish: result.titleEnglish ?? "-",
                type: result.type,
                episodes: result.episodes ?? 0,
                status: result.status,
                aired: AiredResponseToAiredEntityMapper().transform(from: result.aired),
                duration: result.duration,
                rating: result.rating ?? "-",
                score: result.score ?? 0.0,
                scoredBy: result.scoredBy ?? 0,
                rank: result.rank,
                synopsis: result.synopsis ?? "-",
                season: result.season ?? "?",
                year: result.year ?? 0,
                studios: FlexibleResponseToFlexibleEntytiMapper().transform(from: result.studios),
                genres: FlexibleResponseToFlexibleEntytiMapper().transform(from: result.genres)
            )
        }
    }
}
