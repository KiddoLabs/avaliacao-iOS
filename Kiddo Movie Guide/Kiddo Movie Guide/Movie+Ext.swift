//
//  Movie+Ext.swift
//  Kiddo Movie Guide
//
//  Created by Rogerio Hirooka on 8/14/17.
//  Copyright © 2017 Kiddo Labs. All rights reserved.
//

import Foundation
import SwiftyJSON

extension Movie {
    
    convenience init(json: JSON) throws {
        guard let id = json["id"].int,
              let releaseDateString = json["release_date"].string,
              let originalTitle = json["original_title"].string else {
        
                print("Missing Required Return Attributes")
                throw ExpectedFormatError.JSONKeyMissing
        }
        
        let year = Int(releaseDateString.components(separatedBy: "-")[0])
        
        let title = json["title"].string
        let overview = json["overview"].string
        let posterPath = json["poster_path"].string
        let backdropPath = json["backdrop_path"].string
        
        self.init(id: id,
                  year: year!,
                  originalTitle: originalTitle,
                  title: title!,
                  overview: overview!,
                  posterPath: posterPath!,
                  backdropPath: backdropPath!)
        
        let vote = json["vote_average"].float!
        self.voteAverage = vote
    }
    
    func createClone() -> Movie {
        let clone = Movie()
        
        clone.id                = self.id
        clone.year              = self.year
        clone.originalTitle     = self.originalTitle
        clone.title             = self.title
        clone.overview          = self.overview
        clone.posterPath        = self.posterPath
        clone.backdropPath      = self.backdropPath
        
        return clone
    }
    
    /**
     # MOCK_getVersions
     Creates mock MovieVersion arrays based on the id of the movie.
     */
    func MOCK_getVersions(sourceApple: Bool) -> [MovieVersion] {
        var ret = [MovieVersion]()
        
        var seed = (self.id % 4) + 1    // (resolutions available - at least one)
        seed += (sourceApple ? 2 : 0)   // iTunes would have 2 more formats
        
        if seed > 4 { seed = 4 }        // all supported resolutions
        
        for index in 0...seed {
            // if rnd(true), also provides a 'buy' license for this specific resolution
            // rnd: one in each 3 versions will have a buy option
            let buy = ((Int(arc4random_uniform(20) + 1) % 3) == 1)
            
            var res = MovieVersion.Resolution.SD
            if index == 1 { res = MovieVersion.Resolution.HD }
            if index == 2 { res = MovieVersion.Resolution.FullHD }
            if index >= 3 { res = MovieVersion.Resolution.HD4K }
            
            // calculate simulated price based on the voteAverage
            let considerableRating = Float((self.voteAverage + 0.1) / 10.0)
            let maxPrice: Float = 99.90 // (4K/Purchase)
            
            let purchasePrice = (considerableRating * maxPrice) / Float(4 - res.rawValue)
            
            if buy {
                let versionBuy = MovieVersion(resolution: res,
                                              license: MovieVersion.Licenses.Purchase,
                                              provider: sourceApple ? "iTunes" : "Vudu",
                                              price: purchasePrice)
                ret.append(versionBuy)
            }
            
            // all versions have 'rent'
            let version = MovieVersion(resolution: res,
                                       license: MovieVersion.Licenses.Rental,
                                       provider: sourceApple ? "iTunes" : "Vudu",
                                       price: purchasePrice / 6.0)
            
            ret.append(version)
        }
        
        return ret
    }
    
}
