//
//  Movie.swift
//  Kiddo Movie Guide
//
//  Created by Rogerio Hirooka on 8/13/17.
//  Copyright © 2017 Kiddo Labs. All rights reserved.
//

import Foundation

/**

 # Movie Entity
 
 ViewModel for Kiddo Movie Guide, adapted from the return of TMDB.org

 Sample JSON Segment for reference (Full):
 ````
 {
    "vote_count": 3378,
    "id": 283995,
    "video": false,
    "vote_average": 7.6,
    "title": "Guardians of the Galaxy Vol. 2",
    "popularity": 71.298709,
    "poster_path": "/y4MBh0EjBlMuOzv9axM4qJlmhzz.jpg",
    "original_language": "en",
    "original_title": "Guardians of the Galaxy Vol. 2",
    "genre_ids": [
       28,
       12,
       35,
       878
    ],
    "backdrop_path": "/aJn9XeesqsrSLKcHfHP4u5985hn.jpg",
    "adult": false,
    "overview": "The Guardians must fight to keep their newfound family together as they unravel the mysteries of Peter Quill's true parentage.",
    "release_date": "2017-04-19"
 }
 ````
 
 - Poster and Backdrop path are relative to the baseURL returned from the Configuration call
 - Available sources data are NOT AVAILABLE from this service. Mock data will be structured as follows: - ID % 4
 
 */
class Movie {

    // MARK: - Attributes
    var id:             Int
    var year:           Int
    var originalTitle:  String
    var title:          String?
    var overview:       String?
    
    var posterPath:     String
    var backdropPath:   String
    
    // MARK: - Convenience Initializer
    init(id: Int, year: Int,
         originalTitle: String, title: String?, overview: String?,
         posterPath: String, backdropPath: String) {
        
        self.id             = id
        self.year           = year
        self.originalTitle  = originalTitle
        self.title          = title
        self.overview       = overview
        
        self.posterPath     = posterPath
        self.backdropPath   = backdropPath
        
    }
    

}