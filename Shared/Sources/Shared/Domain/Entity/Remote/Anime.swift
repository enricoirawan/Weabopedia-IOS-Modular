//
//  Anime.swift
//  
//
//  Created by Enrico Irawan on 18/12/22.
//

public struct Anime: Equatable, Identifiable {
    public let id: Int
    public let images: Image
    public let title, titleEnglish: String
    public let type: String
    public let episodes: Int
    public let status: String
    public let aired: Aired
    public let duration, rating: String
    public let score: Double
    public let scoredBy, rank: Int
    public let synopsis, season: String
    public let year: Int
    public let studios, genres: [Flexible]
    
    public init(id: Int, images: Image, title: String, titleEnglish: String, type: String, episodes: Int, status: String, aired: Aired, duration: String, rating: String, score: Double, scoredBy: Int, rank: Int, synopsis: String, season: String, year: Int, studios: [Flexible], genres: [Flexible]) {
        self.id = id
        self.images = images
        self.title = title
        self.titleEnglish = titleEnglish
        self.type = type
        self.episodes = episodes
        self.status = status
        self.aired = aired
        self.duration = duration
        self.rating = rating
        self.score = score
        self.scoredBy = scoredBy
        self.rank = rank
        self.synopsis = synopsis
        self.season = season
        self.year = year
        self.studios = studios
        self.genres = genres
    }
}

// MARK: - Image
public struct Image: Equatable {
    public let jpg: Jpg
    
    public init(jpg: Jpg) {
        self.jpg = jpg
    }
}

// MARK: - Jpg
public struct Jpg: Equatable {
    public let imageURL, smallImageURL, largeImageURL: String
    
    public init(imageURL: String, smallImageURL: String, largeImageURL: String) {
        self.imageURL = imageURL
        self.smallImageURL = smallImageURL
        self.largeImageURL = largeImageURL
    }
}

// MARK: - Aired
public struct Aired: Equatable {
    public let string: String
    
    public init(string: String) {
        self.string = string
    }
}

// MARK: - Demographic
public struct Flexible: Equatable {
    public let id: Int
    public let type: TypeEnum
    public let name: String
    public let url: String
    
    public init(id: Int, type: TypeEnum, name: String, url: String) {
        self.id = id
        self.type = type
        self.name = name
        self.url = url
    }
}
