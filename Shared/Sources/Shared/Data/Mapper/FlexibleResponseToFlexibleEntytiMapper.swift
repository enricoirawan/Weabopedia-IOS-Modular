//
//  FlexibleResponseToFlexibleEntytiMapper.swift
//  
//
//  Created by Enrico Irawan on 18/12/22.
//

import Core

public struct FlexibleResponseToFlexibleEntytiMapper: Mapper {
    public typealias From = [FlexibleResponse]
    public typealias To = [Flexible]
    
    public func transform(from this: [FlexibleResponse]) -> [Flexible] {
        return this.map { item in
            return Flexible(
                id: item.id,
                type: item.type,
                name: item.name,
                url: item.url
            )
        }
    }
}
