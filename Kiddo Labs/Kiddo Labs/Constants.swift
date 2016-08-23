//
//  Constants.swift
//  Kiddo Labs
//
//  Created by Lucas Domene Firmo on 8/20/16.
//  Copyright © 2016 Domene. All rights reserved.
//

import Foundation
import UIKit

// MARK: - App Keys
let GUIDEBOX_KEY = "rKnHeM9R3Z39O3FWRsyCx2DfuqeaDp3m"

// MARK: - Typealias
public typealias JSONDictionary = [String : AnyObject]

// MARK: - JSON Keys
let JSON_KEY_ID = "id"
let JSON_KEY_TITLE = "title"
let JSON_KEY_RELEASE_YEAR = "release_year"
let JSON_KEY_DESCRIPTION = "overview"
let JSON_KEY_SOURCES = "purchase_ios_sources"
let JSON_KEY_SOURCE_DISPLAY_NAME = "display_name"
let JSON_KEY_FORMATS = "formats"
let JSON_KEY_FORMAT_NAME = "format"
let JSON_KEY_FORMAT_PRICE = "price"
let JSON_KEY_FORMAT_TYPE = "type"
let JSON_KEY_THUMBNAIL = "poster_120x171"
let JSON_KEY_LARGE_IMAGE = "poster_400x570"
let JSON_KEY_RESULTS = "results"

// MARK: - Labels

let LABELS_UNTITLED = "Untitled"
let LABELS_UNKNOWN = "Unknown"
let LABELS_NO_PRICE = "No price"
let LABELS_UNAVAILABLE = "Indisponível"
let LABELS_REMOVE_FROM_FAVORITES = "Remover dos favoritos"
let LABELS_ADD_TO_FAVORITES = "Adicionar ao favoritos"
let LABELS_BACK = "Voltar"

// MARK: - Custom Colors
let CUSTOM_RED_COLOR = UIColor(red: 201.0/255.0, green: 0, blue: 0, alpha: 1)
let CUSTOM_GREY_COLOR = UIColor(red: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 0.5)

// MARK: - Cells
let MOVIE_CELL = "MovieCell"
let PURCHASE_CELL = "PurchaseCell"

// MARK: - Segues Identifiers
let MOVIE_DETAILS_SEGUE = "MovieDetails"
let PURCHASE_SEGUE = "PurchaseOptions"

// MARK: - Resources
let MOVIES_LABEL = "moviesLabel"
let FAVORITES_LABEL = "favoritesLabel"
let SHARE_IMAGE = "share"
let STAR_HIGHLIGHTED = "star_highlighted"
let STAR = "star"

// MARK: - Requests
let BASE_PATH = "https://api-public.guidebox.com/v1.43/US/\(GUIDEBOX_KEY)/"
let MOVIES_PATH = "movies/all/"
let MOVIE_DETAILS_PATH = "movie/"