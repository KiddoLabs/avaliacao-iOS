//
//  PosterTests.swift
//  Kiddo Labs
//
//  Created by Lucas Domene Firmo on 8/23/16.
//  Copyright © 2016 Domene. All rights reserved.
//

import XCTest
@testable import Kiddo_Labs

class PosterTests: XCTestCase {

    func testPosterCreation() {
        let thumbnailURL = NSURL(string: "http://thumbnail.com")
        let largePosterURL = NSURL(string: "http://largeposter.com")
        let poster = Poster(thumbnail: thumbnailURL!, largePoster: largePosterURL!)
        
        XCTAssertEqual(poster.thumbnail, thumbnailURL)
        XCTAssertEqual(poster.largePoster, largePosterURL)
    }

}
