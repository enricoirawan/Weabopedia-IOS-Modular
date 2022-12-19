//
//  AnimeObject.swift
//  
//
//  Created by Enrico Irawan on 18/12/22.
//

import RealmSwift

public class AnimeObject: Object {
    @Persisted public var id: Int = 0
    @Persisted public var imageUrl: String = ""
    @Persisted public var title: String = ""
    @Persisted public var status: String = ""
    @Persisted public var duration: String = ""
    @Persisted public var score: Double = 0.0
    @Persisted public var scoreBy: Int = 0
    
    public convenience init(
        id: Int,
        imageUrl: String,
        title: String,
        status: String,
        duration: String,
        score: Double,
        scoreBy: Int
    ) {
        self.init()
        self.id = id
        self.title = title
        self.imageUrl = imageUrl
        self.status = status
        self.duration = duration
        self.score = score
        self.scoreBy = scoreBy
    }
}
