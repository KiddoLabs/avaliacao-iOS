//
//  Format.swift
//  Kiddo Labs
//
//  Created by Lucas Domene Firmo on 8/23/16.
//  Copyright © 2016 Domene. All rights reserved.
//

import Foundation

class Format {
    // MARK: - Attributes
    var formatName: String
    var price: String
    var purchaseType: String

    // MARK: - Initializer
    init(formatName: String, price: String, purchaseType: String) {
        self.formatName = formatName
        self.price = price
        self.purchaseType = purchaseType
    }
}