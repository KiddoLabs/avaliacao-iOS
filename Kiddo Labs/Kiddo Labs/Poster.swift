//
//  Poster.swift
//  Kiddo Labs
//
//  Created by Lucas Domene Firmo on 8/23/16.
//  Copyright © 2016 Domene. All rights reserved.
//

import Foundation

class Poster {
    // MARK: - Attributes
    var thumbnail: NSURL
    var largePoster: NSURL

    // MARK: - Initializer
    init(thumbnail: NSURL, largePoster: NSURL) {
        self.thumbnail = thumbnail
        self.largePoster = largePoster
    }
}