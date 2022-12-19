//
//  AiredResponseToAiredEntityMapper.swift
//  
//
//  Created by Enrico Irawan on 18/12/22.
//

import Core

public struct AiredResponseToAiredEntityMapper: Mapper {
    public typealias From = AiredResponse
    public typealias To = Aired
    
    public func transform(from this: AiredResponse) -> Aired {
        return Aired(
            string: this.string
        )
    }
}
