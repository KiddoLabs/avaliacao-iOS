//
//  AppDelegate.swift
//  Kiddo Labs
//
//  Created by Lucas Domene Firmo on 8/19/16.
//  Copyright © 2016 Domene. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let realm = try! Realm()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        self.setStatusBarBackgroundColor(UIColor(red: 201.0/255.0, green: 0, blue: 0, alpha: 1.0))
        return true
    }
    
    func setStatusBarBackgroundColor(color: UIColor) {
        guard let statusBar = UIApplication.sharedApplication().valueForKey("statusBarWindow")?.valueForKey("statusBar") as? UIView else {
            return
        }
        statusBar.backgroundColor = color
    }
}

