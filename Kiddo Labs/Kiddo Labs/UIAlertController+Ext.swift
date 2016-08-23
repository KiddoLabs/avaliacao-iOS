//
//  UIAlertController+Ext.swift
//  Kiddo Labs
//
//  Created by Lucas Domene Firmo on 8/23/16.
//  Copyright © 2016 Domene. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    /**
        Create a new Alert given an ErrorType.
        - parameter errorType: an ErrorType (optional).
        - returns: A UIAlertController.
     */
    class func errorAlert(errorType: ErrorType = ObjectCreationError.Unknown) -> UIAlertController {
        let alert = UIAlertController(title: "Ops", message: messageForErrorType(errorType), preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        return alert
    }
    
    /**
        Identify a correct message to use on a alert.
        - parameter errorType: an ErrorType.
        - returns: a error message
     */
    class func messageForErrorType(errorType: ErrorType) -> String {
        switch errorType {
        case InternetError.NoConnection:
                return "Sem conexão com a internet!"
        case JSONMappingError.KeyNotFound, ObjectCreationError.Unknown:
            return "Houve uma falha. Tente novamente!"
        default:
            return "Houve uma falha. Tente novamente!"
        }
    }
}