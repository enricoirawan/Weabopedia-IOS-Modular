//
//  GenreResponseToGenreEntityMapper.swift
//  
//
//  Created by Enrico Irawan on 18/12/22.
//

import Core

public struct GenreResponseToGenreEntityMapper: Mapper {
    public typealias From = [GenreResponse]
    public typealias To = [Genre]
    
    public func transform(from this: [GenreResponse]) -> [Genre] {
        return this.map { result in
            return Genre(
                id: result.id,
                name: result.name,
                url: result.url,
                count: result.count
            )
        }
    }
}
