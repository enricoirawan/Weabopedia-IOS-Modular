//
//  AnimeResponse.swift
//  
//
//  Created by Enrico Irawan on 18/12/22.
//

// MARK: - AnimeResponses
public struct AnimeResponses: Codable {
    public let data: [AnimeResponse]
}

// MARK: - Anime
public struct AnimeResponse: Codable {
    public let id: Int
    public let images: ImageResponse
    public let title: String
    public let titleEnglish: String?
    public let type: String
    public let episodes: Int?
    public let status: String
    public let aired: AiredResponse
    public let duration: String
    public let rating: String?
    public let score: Double?
    public let scoredBy: Int?
    public let rank: Int
    public let synopsis: String?
    public let season: String?
    public let year: Int?
    public let studios, genres: [FlexibleResponse]
    
    enum CodingKeys: String, CodingKey {
        case id = "mal_id"
        case images, title
        case titleEnglish = "title_english"
        case type, episodes, status, aired, duration, rating, score
        case scoredBy = "scored_by"
        case rank, synopsis, season, year, studios, genres
    }
}

// MARK: - Image
public struct ImageResponse: Codable {
    public let jpg: JpgResponse
}

// MARK: - Jpg
public struct JpgResponse: Codable {
    public let imageURL, smallImageURL, largeImageURL: String

    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case smallImageURL = "small_image_url"
        case largeImageURL = "large_image_url"
    }
}

// MARK: - Aired
public struct AiredResponse: Codable {
    public let string: String
}

// MARK: - Demographic
public struct FlexibleResponse: Codable {
    public let id: Int
    public let type: TypeEnum
    public let name: String
    public let url: String

    enum CodingKeys: String, CodingKey {
        case id = "mal_id"
        case type, name, url
    }
}

public enum TypeEnum: String, Codable {
    case anime
}
