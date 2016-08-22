//
//  Source.swift
//  Kiddo Labs
//
//  Created by Lucas Domene Firmo on 8/22/16.
//  Copyright © 2016 Domene. All rights reserved.
//

import Foundation
import RealmSwift

class Source: Object {
    dynamic var sourceName = ""
    var formats = List<Format>()
}