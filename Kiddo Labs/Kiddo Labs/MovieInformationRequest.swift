//
//  MovieInformationRequest.swift
//  Kiddo Labs
//
//  Created by Lucas Domene Firmo on 8/22/16.
//  Copyright © 2016 Domene. All rights reserved.
//

import Foundation

class MovieInformationRequest: BaseRequest {
    
    // MARK: - Attributes
    private var path = "movie/"
    var movie: Movie
    
    // MARK: - Initializer
    init(movie: Movie) {
        self.movie = movie
    }
    
    // MARK: - Instance Methods
    func makeRequest(movieID: Int, completion: (Movie?, ErrorType?) -> ()) {
        super.makeRequest(.GET, path: path + String(movieID), parameters: nil) { response in
            guard let json = response.result.value as? JSONDictionary else {
                completion(nil, JSONMappingError.KeyNotFound)
                return
            }
            
            let data = self.movie.movieInformation(json)
            self.movie.description = data.0?.description
            self.movie.availableFormats = data.0?.availableFormats
            return completion(self.movie, data.1)
        }
    }
}