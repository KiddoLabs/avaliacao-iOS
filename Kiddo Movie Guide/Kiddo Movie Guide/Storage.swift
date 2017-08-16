//
//  Storage.swift
//  Kiddo Movie Guide
//
//  Created by Rogerio Hirooka on 8/14/17.
//  Copyright © 2017 Kiddo Labs. All rights reserved.
//

import Foundation
import RealmSwift

class Storage {
    
    static func realmInstance() -> Realm {
        return (UIApplication.shared.delegate as! AppDelegate).storage
    }
    
}

