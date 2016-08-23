//
//  Source+Ext.swift
//  Kiddo Labs
//
//  Created by Lucas Domene Firmo on 8/23/16.
//  Copyright © 2016 Domene. All rights reserved.
//

import Foundation

extension Source {
    convenience init(json: JSONDictionary) throws {
        guard let displayName = json["display_name"] as? String,
            formatsJSON = json["formats"] as? [JSONDictionary] else {
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