//
//  Format+Ext.swift
//  Kiddo Labs
//
//  Created by Lucas Domene Firmo on 8/23/16.
//  Copyright © 2016 Domene. All rights reserved.
//

import Foundation

extension Format {
    convenience init(json: JSONDictionary) throws {
        guard let formatName = json["format"] as? String,
            price = json["price"] as? String,
            purchaseType = json["type"] as? String else {
                throw JSONMappingError.KeyNotFound
        }
        
        self.init(formatName: formatName, price: price, purchaseType: purchaseType)
    }
}