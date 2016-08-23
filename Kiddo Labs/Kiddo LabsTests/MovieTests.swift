//
//  MovieTests.swift
//  Kiddo Labs
//
//  Created by Lucas Domene Firmo on 8/23/16.
//  Copyright © 2016 Domene. All rights reserved.
//

import XCTest
@testable import Kiddo_Labs

class MovieTests: XCTestCase {
    
    let movieMock = "{\"id\": 138841,\"title\": \"Andy and Zach\",\"release_year\": 2010,\"poster_120x171\": \"http://static-api.guidebox.com/misc/default_movie_120x171.jpg\",\"poster_240x342\": \"http://static-api.guidebox.com/misc/default_movie_240x342.jpg\",\"poster_400x570\": \"http://static-api.guidebox.com/misc/default_movie_400x570.jpg\"}"
    
    func testMovieCreation() {
        let poster = Poster(thumbnail: NSURL(string: "http://thumbnail.com")!, largePoster: NSURL(string: "http://largeposter.com")!)
        let movie = Movie(id: 10, title: "Superman", year: 2000, poster: poster)
        
        XCTAssertEqual(movie.id, 10)
        XCTAssertEqual(movie.title, "Superman")
        XCTAssertEqual(movie.year, 2000)
        XCTAssertEqual(movie.poster.thumbnail, NSURL(string: "http://thumbnail.com"))
        XCTAssertEqual(movie.poster.largePoster, NSURL(string: "http://largeposter.com"))
    }
    
    func testMovieCreationWithJSON() {
        let data = movieMock.dataUsingEncoding(NSUTF8StringEncoding)
        let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
        let movie = try! Movie(json: json as! JSONDictionary)
        
        XCTAssertEqual(movie.title, "Andy and Zach")
        XCTAssertEqual(movie.id, 138841)
        XCTAssertEqual(movie.year, 2010)
    }
}
