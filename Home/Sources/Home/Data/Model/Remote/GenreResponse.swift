//
//  GenreResponse.swift
//  
//
//  Created by Enrico Irawan on 18/12/22.
//

// MARK: - GenreResponses
public struct GenreResponses: Codable {
    let data: [GenreResponse]
}

// MARK: - GenreResponse
public struct GenreResponse: Codable {
    let id: Int
    let name: String
    let url: String
    let count: Int

    enum CodingKeys: String, CodingKey {
        case id = "mal_id"
        case name, url, count
    }
}
