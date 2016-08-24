//
//  Source.swift
//  Kiddo Labs
//
//  Created by Lucas Domene Firmo on 8/23/16.
//  Copyright © 2016 Domene. All rights reserved.
//

import Foundation

class Source {
    // MARK: - Attributes
    var displayName: String
    var formats: [Format]
    
    // MARK: - Initializer
    init(displayName: String, formats: [Format]) {
        self.displayName = displayName
        self.formats = formats
    }
}