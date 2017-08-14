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
                  title: title,
                  overview: overview,
                  posterPath: posterPath!,
                  backdropPath: backdropPath!)
    }
    
}
