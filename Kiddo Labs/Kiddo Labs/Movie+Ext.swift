//
//  Movie+Ext.swift
//  Kiddo Labs
//
//  Created by Lucas Domene Firmo on 8/20/16.
//  Copyright © 2016 Domene. All rights reserved.
//

import Foundation
import RealmSwift

extension Movie {
    convenience init(json: JSONDictionary) throws {
        guard let id = json["id"] as? Int,
                  title = json["title"] as? String,
                  year = json["release_year"] as? Int,
                  posterURL = json["poster_120x171"] as? String else {
            throw JSONMappingError.KeyNotFound
        }
        
        self.init(id: id, title: title, year: year, posterURL: posterURL)
    }
    
    class func massCreation(jsonArray: [JSONDictionary]) -> ([Movie]?, ErrorType?) {
        var movies = [Movie]()
        for jsonDict in jsonArray {
            var movie: Movie? = nil
            do {
                movie = try Movie(json: jsonDict)
            } catch JSONMappingError.KeyNotFound {
                return (nil, JSONMappingError.KeyNotFound)
            } catch {
                return (nil, ObjectCreationError.Unknown)
            }
            movies.append(movie!)
        }
        
        return (movies, nil)
    }
    
    func movieInformation(jsonArray: JSONDictionary) -> (Movie?, ErrorType?) {
        guard let movieDescription = jsonArray["overview"] as? String,
                  sources = jsonArray["purchase_ios_sources"] as? [[String: AnyObject]] else {
            return (nil, JSONMappingError.KeyNotFound)
        }
        
        let sourceList = List<Source>()
        for source in sources {
            let newSource = Source()
            if let formats = source["formats"] as? [[String: AnyObject]] {
                let formatList = List<Format>()
                for format in formats {
                    let newFormat = Format()
                    newFormat.format = format["format"] as! String
                    newFormat.price = format["price"] as! String
                    newFormat.type = format["type"] as! String
                    formatList.append(newFormat)
                }
                newSource.formats = formatList
                newSource.sourceName = source["display_name"] as! String
            }
            sourceList.append(newSource)
        }
        
        self.sources = sourceList
        self.movieDescription = movieDescription
        return (self, nil)
    }
}