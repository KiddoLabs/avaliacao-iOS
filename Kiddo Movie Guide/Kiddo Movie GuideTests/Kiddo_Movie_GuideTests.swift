//
//  Kiddo_Movie_GuideTests.swift
//  Kiddo Movie GuideTests
//
//  Created by Rogerio Hirooka on 8/10/17.
//  Copyright © 2017 Kiddo Labs. All rights reserved.
//

import XCTest
import Expecta
import SwiftyJSON

@testable import Kiddo_Movie_Guide

class Kiddo_Movie_GuideTests: XCTestCase {
    
    var api = TMDBAPI.sharedInstance
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAPIDiscover() {
        Expecta.setAsynchronousTestTimeout(2)
        
        self.api.performDiscover(page: 1) { (movies, error) in
            let retData = movies
            XCTAssertNotNil(retData, "data from server should not be nil")
            XCTAssertNil(error, "error returned should be nil")
            XCTAssert(movies?.count == 20, "default pagination must be 20")
        }
    }
    
    func testPrimaryEntityParser() {
        let dunkirk = "{ \"vote_count\": 1216, \"id\": 374720, \"video\": false, \"vote_average\": 7.4, \"title\": \"Dunkirk\", \"popularity\": 47.822152, \"poster_path\": \"/cUqEgoP6kj8ykfNjJx3Tl5zHCcN.jpg\", \"original_language\": \"en\", \"original_title\": \"Dunkirk\", \"genre_ids\": [ 28, 18, 36, 53, 10752 ], \"backdrop_path\": \"/fudEG1VUWuOqleXv6NwCExK0VLy.jpg\", \"adult\": false, \"overview\": \"Miraculous evacuation of Allied soldiers from Belgium, Britain, Canada, and France, who were cut off and surrounded by the German army from the beaches and harbor of Dunkirk, France, between May 26 and June 04, 1940, during Battle of France in World War II.\", \"release_date\": \"2017-07-19\" }"
        
        let j = JSON.parse(dunkirk)
        XCTAssertNotNil(j, "SwiftyJSON parsing should not return nil")

        let movie = try! Movie(json: j)
        
        XCTAssertEqual(movie.title, "Dunkirk", "titles must match")
        XCTAssertEqual(movie.year, 2017, "release year is parsed from release_date and should be 2017")

    }
    
    func testCustomExtension4Dictionary() {
        var d1 = ["k": "value1", "x": "value2"]
        let d2 = ["z": "value1", "y": "value2"]
        d1.merge(with: d2)

        XCTAssertEqual(d1.count, 4, "2 pairs should have been incorporated")
    }
    
}
