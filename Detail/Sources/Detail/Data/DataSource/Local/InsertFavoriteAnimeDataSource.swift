//
//  InsertFavoriteAnimeDataSource.swift
//  
//
//  Created by Enrico Irawan on 19/12/22.
//

import Core
import Shared
import Foundation
import Combine
import RealmSwift

public struct InsertFavoriteAnimeDataSource: LocalDataSource {
    public typealias Request = AnimeObject
    public typealias Response = Bool
    
    private let realm: Realm
    public init(realm: Realm) {
        self.realm = realm
    }
    
    public func execute(request: AnimeObject?) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            do {
                try self.realm.write {
                let animeObject = AnimeObject(
                    id: request!.id,
                    imageUrl: request!.imageUrl,
                    title: request!.title,
                    status: request!.status,
                    duration: request!.duration,
                    score: request!.score,
                    scoreBy: request!.scoreBy
                )
                self.realm.add(animeObject)
                completion(.success(true))
              }
            } catch {
              completion(.failure(DatabaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }
}
