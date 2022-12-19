//
//  Genre.swift
//  
//
//  Created by Enrico Irawan on 18/12/22.
//
public struct Genre: Equatable, Identifiable {
    public let id: Int
    public let name: String
    public let url: String
    public let count: Int
    
    public init(id: Int, name: String, url: String, count: Int) {
        self.id = id
        self.name = name
        self.url = url
        self.count = count
    }
}
