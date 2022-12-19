//
//  GetListFavoriteAnimeDataSource.swift
//  
//
//  Created by Enrico Irawan on 19/12/22.
//
import Core
import Shared
import Foundation
import Combine
import RealmSwift

public struct GetListFavoriteAnimeDataSource: LocalDataSource {
    public typealias Request = Any
    public typealias Response = [AnimeObject]
    
    private let realm: Realm
    public init(realm: Realm) {
        self.realm = realm
    }
    
    public func execute(request: Any?) -> AnyPublisher<[AnimeObject], Error> {
        return Future<[AnimeObject], Error> { completion in
            do {
                try self.realm.write({
                let animeList: Results<AnimeObject> = {
                    self.realm.objects(AnimeObject.self)
                    .sorted(byKeyPath: "title", ascending: true)
                }()
                completion(.success(animeList.toArray(ofType: AnimeObject.self)))
                })
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }
}
