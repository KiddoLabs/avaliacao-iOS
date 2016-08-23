//
//  Format+Ext.swift
//  Kiddo Labs
//
//  Created by Lucas Domene Firmo on 8/23/16.
//  Copyright © 2016 Domene. All rights reserved.
//

import Foundation

extension Format {
    /**
        Create a new Format given a JSON.
        - parameter json: a JSONDictionary with format data.
     */
    convenience init(json: JSONDictionary) throws {
        guard let formatName = json[JSON_KEY_FORMAT_NAME] as? String,
            price = json[JSON_KEY_FORMAT_PRICE] as? String,
            purchaseType = json[JSON_KEY_FORMAT_TYPE] as? String else {
                throw JSONMappingError.KeyNotFound
        }
        
        self.init(formatName: formatName, price: price, purchaseType: purchaseType)
    }
}