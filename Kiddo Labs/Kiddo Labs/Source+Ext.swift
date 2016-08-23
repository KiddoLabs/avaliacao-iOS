//
//  Source+Ext.swift
//  Kiddo Labs
//
//  Created by Lucas Domene Firmo on 8/23/16.
//  Copyright © 2016 Domene. All rights reserved.
//

import Foundation

extension Source {
    /**
        Create a new Source given a JSON.
        - parameter json: a JSONDictionary with Source data.
     */
    convenience init(json: JSONDictionary) throws {
        guard let displayName = json[JSON_KEY_SOURCE_DISPLAY_NAME] as? String,
            formatsJSON = json[JSON_KEY_FORMATS] as? [JSONDictionary] else {
                throw JSONMappingError.KeyNotFound
        }
        
        var formats = [Format]()
        for format in formatsJSON {
            do {
                try formats.append(Format(json: format))
            } catch JSONMappingError.KeyNotFound {
                throw JSONMappingError.KeyNotFound
            }
        }
        
        self.init(displayName: displayName, formats: formats)
    }
}