//
//  TMDBAPI.swift
//  Kiddo Movie Guide
//
//  Created by Rogerio Hirooka on 8/12/17.
//  Copyright © 2017 Kiddo Labs. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

/**
 # TMDBAPI
 
 Consumes API services from *TheMovieDatabase.org*
 */
public class TMDBAPI {

    // MARK: - Init/Deinit
    static let sharedInstance = TMDBAPI()
    
    // Prevents default initialization, forcing usage of the singleton above
    private init() {}
    

    // MARK: - Base Values
    let defaultParameters: Parameters = [
        "include_video": "false",
        "include_adult": "false",
        "language"     : "en-US",
        "sort_by"      : "popularity.desc"
    ]

    let baseURL = "https://api.themoviedb.org/3"
    
    
    // MARK: - Properties
    var isConfigured = false
    var apiKey = "e8734dc662e1392255ca437921a64879"
    var imageBasePath = "https://image.tmdb.org/t/p/w500/"
    
    
    // MARK: - Base Request
    /**
     Performs the base request
     
     All consumed methods will be HTTP.Get for now.
     
     - Parameter compoundPath:      Service method path.
     - Parameter parameters:        Dictionary of parameters. Will append to defaultParameters.
     - Parameter completionHandler: Completion Handler block.
     */
    private func makeRequest(compoundPath: String,
                             parameters: Parameters?,
                             completionHandler: @escaping (DataResponse<Any>) -> ()) {
        let request = Alamofire.request(self.baseURL + compoundPath,
                                        parameters: parameters,
                                        encoding: URLEncoding.default)

        request.responseJSON { response in
            print(response.request  as Any) // original URL request
            print(response.response as Any) // HTTP URL response
            print(response.data     as Any) // server data
            print(response.result   as Any) // result of response serialization
            
            completionHandler(response)
        }
    }
    
    func performDiscover(page: Int,
                         completionHandler: @escaping ([Movie]?, Error?) -> ()) {
        
        var parameters: Parameters = [
            "page"    : page,
            "api_key" : apiKey
        ]
        
        parameters.merge(with: defaultParameters)

        self.makeRequest(compoundPath: "/discover/movie",
                         parameters: parameters,
                         completionHandler: { response in
                            
                            if response.data != nil {
                                var ret = [Movie]()
                                let json = JSON(data: response.data!)
                                guard let results = json["results"] as JSON? else {
                                    print("performDiscover failed to fetch results: \(json)")
                                }
                                for u: JSON in results.array! {
                                    do {
                                        let movie = try Movie(json: u)
                                        ret.append(movie)
                                    } catch ExpectedFormatError.JSONKeyMissing {
                                        completionHandler (nil, ExpectedFormatError.JSONKeyMissing)
                                    } catch {
                                        completionHandler (nil, UnexpectedError.UnknownException)
                                    }
                                }
                                
                                completionHandler(ret, nil)
                            }
                            
        })
    }

}
