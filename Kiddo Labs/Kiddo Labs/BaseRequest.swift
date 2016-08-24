//
//  BaseRequest.swift
//  Kiddo Labs
//
//  Created by Lucas Domene Firmo on 8/20/16.
//  Copyright © 2016 Domene. All rights reserved.
//

import Foundation
import Alamofire

class BaseRequest {
    
    // MARK: - Instance Methods
    
    /**
        Make a request to GuideBox.
        - parameter httpMethod: The HTTP method.
        - parameter parameters: The request parameters.
        - parameter completion: The completion closure with a response from server.
     */
    func makeRequest(httpMethod: Alamofire.Method, path: String, parameters: JSONDictionary?, completion: (Response<AnyObject, NSError>) -> ()) {
        let request = Alamofire.request(httpMethod, BASE_PATH + path, parameters: parameters, encoding: .URL, headers: nil)
        request.responseJSON { response in
            completion(response)
        }
    }
}