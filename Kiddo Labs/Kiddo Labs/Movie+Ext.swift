//
//  Movie+Ext.swift
//  Kiddo Labs
//
//  Created by Lucas Domene Firmo on 8/20/16.
//  Copyright © 2016 Domene. All rights reserved.
//

import Foundation

extension Movie {
    convenience init(json: JSONDictionary) throws {
        guard let id = json["id"] as? Int,
                  title = json["title"] as? String,
                  year = json["release_year"] as? Int else {
            throw JSONMappingError.KeyNotFound
        }
        
        var poster: Poster?
        do {
            poster = try Poster(json: json)
        } catch JSONMappingError.KeyNotFound {
            throw JSONMappingError.KeyNotFound
        }
        
        self.init(id: id, title: title, year: year, poster: poster!)
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
        guard let description = jsonArray["overview"] as? String,
                  sourcesJSON = jsonArray["purchase_ios_sources"] as? [JSONDictionary] else {
            return (nil, JSONMappingError.KeyNotFound)
        }
        
        var sources = [Source]()
        for source in sourcesJSON {
            do {
                try sources.append(Source(json: source))
            } catch JSONMappingError.KeyNotFound {
                return (nil, JSONMappingError.KeyNotFound)
            } catch {
                return (nil, ObjectCreationError.Unknown)
            }
        }
        
        self.availableSources = sources
        self.description = description
        return (self, nil)
    }
}