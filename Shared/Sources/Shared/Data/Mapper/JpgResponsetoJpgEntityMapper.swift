//
//  JpgResponsetoJpgEntityMapper.swift
//  
//
//  Created by Enrico Irawan on 18/12/22.
//
import Core

public struct JpgResponsetoJpgEntityMapper: Mapper {
    public typealias From = JpgResponse
    public typealias To = Jpg
    
    public func transform(from this: JpgResponse) -> Jpg {
        return Jpg(
            imageURL: this.imageURL,
            smallImageURL: this.smallImageURL,
            largeImageURL: this.largeImageURL
        )
    }
}
