//
//  Movie+Ext.swift
//  Kiddo Labs
//
//  Created by Lucas Domene Firmo on 8/20/16.
//  Copyright © 2016 Domene. All rights reserved.
//

import Foundation

extension Movie {
    /**
        Create a new Movie given a JSON.
        - parameter json: a JSONDictionary with movie data.
     */
    convenience init(json: JSONDictionary) throws {
        guard let id = json[JSON_KEY_ID] as? Int,
                  title = json[JSON_KEY_TITLE] as? String,
                  year = json[JSON_KEY_RELEASE_YEAR] as? Int else {
            throw JSONMappingError.KeyNotFound
        }
        
        var poster: Poster?
        do {
            poster = try Poster(json: json)
        } catch JSONMappingError.KeyNotFound {
            throw JSONMappingError.KeyNotFound
        } catch ObjectCreationError.Unknown {
            throw ObjectCreationError.Unknown
        }
        
        self.init(id: id, title: title, year: year, poster: poster!)
    }
    
    /**
        Create a list a movies given a JSON.
        - parameter jsonArray: a JSONDictionary with movies.
        - returns: a tuple containing a movie list and a error, if there was any.
     */
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
    
    /**
        Add information for a movie.
        - parameter jsonArray: the JSONDictionary of a movie.
        - returns: a tuple with a movie containing all information and a error, if there was any. 
     */
    func movieInformation(jsonArray: JSONDictionary) -> (Movie?, ErrorType?) {
        guard let description = jsonArray[JSON_KEY_DESCRIPTION] as? String,
                  sourcesJSON = jsonArray[JSON_KEY_SOURCES] as? [JSONDictionary] else {
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