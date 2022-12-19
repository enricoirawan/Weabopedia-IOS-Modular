//
//  AnimeObjectEntity.swift
//  
//
//  Created by Enrico Irawan on 19/12/22.
//
public struct AnimeObjectEntity: Equatable, Identifiable {
    public let id: Int
    public let imageUrl: String
    public let title: String
    public let status: String
    public let duration: String
    public let score: Double
    public let scoredBy: Int
    
    public init(id: Int, imageUrl: String, title: String, status: String, duration: String, score: Double, scoredBy: Int) {
        self.id = id
        self.imageUrl = imageUrl
        self.title = title
        self.status = status
        self.duration = duration
        self.score = score
        self.scoredBy = scoredBy
    }
}
