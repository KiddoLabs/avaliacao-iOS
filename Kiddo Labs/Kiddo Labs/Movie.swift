//
//  Movie.swift
//  Kiddo Labs
//
//  Created by Lucas Domene Firmo on 8/20/16.
//  Copyright © 2016 Domene. All rights reserved.
//

import Foundation
import RealmSwift

class Movie: Object {
    
    // MARK: - Attributes
    
    dynamic var id = 0
    dynamic var title = ""
    dynamic var year = 0
    dynamic var posterURL = ""
    dynamic var movieDescription = ""
    var sources = List<Source>()
    
    // MARK: - Initializer
    
    convenience required init(id: Int, title: String, year: Int, posterURL: String) {
        self.init()
        self.id = id
        self.title = title
        self.year = year
        self.posterURL = posterURL
    }
}