//
//  FormatTests.swift
//  Kiddo Labs
//
//  Created by Lucas Domene Firmo on 8/23/16.
//  Copyright © 2016 Domene. All rights reserved.
//

import XCTest
@testable import Kiddo_Labs

class FormatTests: XCTestCase {

    func testFormatCreation() {
        let HDFormat = Format(formatName: "HD", price: "10", purchaseType: "Rent")
        
        XCTAssertEqual("HD", HDFormat.formatName)
        XCTAssertEqual("10", HDFormat.price)
        XCTAssertEqual("Rent", HDFormat.purchaseType)
    }
}
