//
//  Exceptions.swift
//  Kiddo Movie Guide
//
//  Created by Rogerio Hirooka on 8/14/17.
//  Copyright © 2017 Kiddo Labs. All rights reserved.
//

import Foundation

enum ConnectivityError: Error {
    case NoConnection
}

enum ExpectedFormatError: Error {
    case JSONKeyMissing
}

enum UnexpectedError: Error {
    case UnknownException
}
