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
    
    // MARK: - Attributes
    private let basePath = BASE_PATH
    
    // MARK: - Instance Methods
    func makeRequest(httpMethod: Alamofire.Method, path: String, parameters: JSONDictionary?, completion: (Response<AnyObject, NSError>) -> ()) {
        let request = Alamofire.request(httpMethod, basePath + path, parameters: parameters, encoding: .URL, headers: nil)
        request.responseJSON { response in
            completion(response)
        }
    }
}