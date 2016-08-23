//
//  Movie.swift
//  Kiddo Labs
//
//  Created by Lucas Domene Firmo on 8/20/16.
//  Copyright © 2016 Domene. All rights reserved.
//

import Foundation

class Movie {
    // MARK: - Attributes
    var id: Int
    var title: String
    var year: Int
    var poster: Poster
    var description: String?
    var availableSources: [Source]?
    
    // MARK: - Initializer
    init(id: Int, title: String, year: Int, poster: Poster) {
        self.id = id
        self.title = title
        self.year = year
        self.poster = poster
    }
}