//
//  Favorite.swift
//  Kiddo Labs
//
//  Created by Lucas Domene Firmo on 8/22/16.
//  Copyright © 2016 Domene. All rights reserved.
//

import Foundation
import RealmSwift

class Favorite: Object {
    dynamic var id = 0
    dynamic var title = ""
    dynamic var posterURL = ""
    dynamic var year = 0
}