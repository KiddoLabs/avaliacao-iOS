//
//  MoviesRequest.swift
//  Kiddo Labs
//
//  Created by Lucas Domene Firmo on 8/20/16.
//  Copyright © 2016 Domene. All rights reserved.
//

import Foundation

class MoviesRequest: BaseRequest {
    
    // MARK: - Attributes
    private var path = MOVIES_PATH
    var movieIndex: Int
    var numberOfMovies: Int
    var source: String
    var plataform: String
    
    // MARK: - Initializer
    init(movieIndex: Int = 0, numberOfMovies: Int = 20, source: String = "all", plataform: String = "ios") {
        self.movieIndex = movieIndex
        self.numberOfMovies = numberOfMovies
        self.source = source
        self.plataform = plataform
    }
    
    // MARK: - Instance Methods
    func makeRequest(movieIndex: Int, completion: ([Movie]?, ErrorType?) -> ()) {
        super.makeRequest(.GET, path: path + parameters(movieIndex), parameters: nil) { response in
            guard let json = response.result.value?[JSON_KEY_RESULTS] as? [JSONDictionary] else {
                completion(nil, JSONMappingError.KeyNotFound)
                return
            }
            
            let data = Movie.massCreation(json)
            return completion(data.0, data.1)
        }
    }
    
    func parameters(movieIndex: Int) -> String {
        return "\(movieIndex)/\(numberOfMovies)/\(source)/\(plataform)"
    }
}