//
//  ImageResponseToImageEntityMapper.swift
//  
//
//  Created by Enrico Irawan on 18/12/22.
//
import Core

public struct ImageResponseToImageEntityMapper: Mapper {
    public typealias From = ImageResponse
    public typealias To = Image
    
    public func transform(from this: ImageResponse) -> Image {
        return Image(jpg: JpgResponsetoJpgEntityMapper().transform(from: this.jpg))
    }
}
