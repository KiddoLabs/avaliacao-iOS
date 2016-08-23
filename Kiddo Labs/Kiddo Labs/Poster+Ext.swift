//
//  Poster+Ext.swift
//  Kiddo Labs
//
//  Created by Lucas Domene Firmo on 8/23/16.
//  Copyright © 2016 Domene. All rights reserved.
//

import Foundation

extension Poster {
    convenience init(json: JSONDictionary) throws {
        guard let thumbnail = json["poster_120x171"] as? String,
            largePoster = json["poster_400x570"] as? String else {
                throw JSONMappingError.KeyNotFound
        }
        
        guard let thumbnailURL = NSURL(string: thumbnail), largePosterURL = NSURL(string: largePoster) else {
            throw ObjectCreationError.Unknown
        }
        
        self.init(thumbnail: thumbnailURL, largePoster: largePosterURL)
    }
}