//
//  SourceTests.swift
//  Kiddo Labs
//
//  Created by Lucas Domene Firmo on 8/23/16.
//  Copyright © 2016 Domene. All rights reserved.
//

import XCTest
@testable import Kiddo_Labs

class SourceTests: XCTestCase {

    func testSourceCreation() {
        let HDFormat = Format(formatName: "HD", price: "10", purchaseType: "Rent")
        let SDFormat = Format(formatName: "SD", price: "5", purchaseType: "Rent")
        let source = Source(displayName: "iTunes", formats: [HDFormat, SDFormat])
        
        XCTAssertEqual(source.displayName, "iTunes")
        
        XCTAssertEqual(source.formats.first!.formatName, HDFormat.formatName)
        XCTAssertEqual(source.formats.first!.price, HDFormat.price)
        XCTAssertEqual(source.formats.first!.purchaseType, HDFormat.purchaseType)
        
        XCTAssertEqual(source.formats.last!.formatName, SDFormat.formatName)
        XCTAssertEqual(source.formats.last!.price, SDFormat.price)
        XCTAssertEqual(source.formats.last!.purchaseType, SDFormat.purchaseType)
    }
}
