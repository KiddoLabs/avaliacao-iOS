//
//  Source.swift
//  Kiddo Movie Guide
//
//  Created by Rogerio Hirooka on 8/13/17.
//  Copyright © 2017 Kiddo Labs. All rights reserved.
//

import Foundation
/**
 
 # MovieVersion
 
 ViewModel for MovieVersion on Kiddo Movie Guide - adapted for the provided Prototype Sketch
 
 Each title (Movie) has a number of versions with various providers (AppleStore/Vudu in this case), resolution/license type (eg:
   FullHD/Rental, HD4K/Purchase, etc)
 
 */
class MovieVersion {
    
    // MARK: - Entity Enumerations
    enum Resolution: Int {
        case SD
        case HD
        case FullHD
        case HD4K
    }
    
    enum Licenses: Int {
        case Purchase
        case Rental
    }

    // MARK: - Attributes
    var resolution:  Resolution = .SD
    var licenseKind: Licenses   = .Purchase
    
    var provider:    String
    var price:       Float
    
    var selected:    Bool

    // MARK: - Convenience Initializer
    init(resolution: Resolution, license: Licenses, provider: String, price: Float) {
        self.resolution     = resolution
        self.licenseKind    = license
        self.price          = price
        self.provider       = provider
        self.selected       = false
    }

}
