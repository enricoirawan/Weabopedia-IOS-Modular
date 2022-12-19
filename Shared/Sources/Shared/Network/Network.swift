//
//  Network.swift
//  
//
//  Created by Enrico Irawan on 18/12/22.
//
public struct API {
  static let baseUrl = "https://api.jikan.moe/v4/"
}

public protocol Endpoint {
  var url: String { get }
}

public enum Endpoints {

  public enum Get: Endpoint {
    case anime
    case genre

    public var url: String {
      switch self {
      case .anime: return "\(API.baseUrl)anime"
      case .genre: return "\(API.baseUrl)genres/anime"
      }
    }
  }
}
