//
//  CheckIsFavoriteDataSource.swift
//  
//
//  Created by Enrico Irawan on 19/12/22.
//

import Core
import Shared
import Foundation
import Combine
import RealmSwift

public struct CheckIsFavoriteDataSource: LocalDataSource {
    public typealias Request = Int
    public typealias Response = Bool
    
    private let realm: Realm
    public init(realm: Realm) {
        self.realm = realm
    }
    
    public func execute(request: Int?) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            do {
                try self.realm.write {
                let animeObjects = self.realm.objects(AnimeObject.self)
                let results = animeObjects.where {
                    $0.id == request!
                }
                let data = results.toArray(ofType: AnimeObject.self)
                if data.isEmpty {
                    completion(.success(false))
                } else {
                    completion(.success(true))
                }
              }
            } catch {
              completion(.failure(DatabaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }
}
