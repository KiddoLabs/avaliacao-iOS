//
//  MovieInformationRequest.swift
//  Kiddo Labs
//
//  Created by Lucas Domene Firmo on 8/22/16.
//  Copyright © 2016 Domene. All rights reserved.
//

import Foundation

class MovieInformationRequest: BaseRequest {
    
    // MARK: - Instance Methods
    
    /**
     Make a request to retrive movie information
     - parameter movie: the movie which will be used to retrive more information of.
     - parameter completion: a closure which receives a tuple containing a movie and an error, if there was any.
     */
    func makeRequest(movie: Movie, completion: (Movie?, ErrorType?) -> ()) {
        super.makeRequest(.GET, path: MOVIE_DETAILS_PATH + String(movie.id), parameters: nil) { response in
            guard let json = response.result.value as? JSONDictionary else {
                // -1009 stands for no internet connection error
                if response.result.error?.code == -1009 {
                    completion(nil, InternetError.NoConnection)
                } else {
                    completion(nil, JSONMappingError.KeyNotFound)
                }
                return
            }
            
            let data = movie.movieInformation(json)
            return completion(data.0, data.1)
        }
    }
}