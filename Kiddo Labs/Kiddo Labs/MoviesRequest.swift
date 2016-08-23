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
    
    /**
     Make a request to GuideBox.
     - parameter movieIndex: represents the index from where it will start retrieving more movies.
     - parameter completion: The completion closure containing a tuple with movies and a error, if there was any.
     */
    func makeRequest(movieIndex: Int, completion: ([Movie]?, ErrorType?) -> ()) {
        super.makeRequest(.GET, path: path + parameters(movieIndex), parameters: nil) { response in
            guard let json = response.result.value?[JSON_KEY_RESULTS] as? [JSONDictionary] else {
                if response.result.error?.code == -1009 {
                    completion(nil, InternetError.NoConnection)
                } else {
                    completion(nil, JSONMappingError.KeyNotFound)
                }
                return
            }
            
            let data = Movie.massCreation(json)
            return completion(data.0, data.1)
        }
    }
    
    /**
    Concatenate all parameters to create a path.
     - parameter movieIndex: represents the index from where it will start retrieving more movies.
     - returns: a path to use in the request.
     */
    func parameters(movieIndex: Int) -> String {
        return "\(movieIndex)/\(numberOfMovies)/\(source)/\(plataform)"
    }
}