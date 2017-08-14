//
//  BaseTabBarViewController.swift
//  Kiddo Movie Guide
//
//  Created by Rogerio Hirooka on 8/13/17.
//  Copyright © 2017 Kiddo Labs. All rights reserved.
//

import UIKit
import ESTabBarController

class CustomTabBarViewController : UITabBarController {

    // MARK: - Init/Deinit
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let first       = self.tabBar.items?.first
        let last        = self.tabBar.items?.last

        first?.title    = NSLocalizedString("UI.Home", comment: "")
        last?.title     = NSLocalizedString("UI.Favorites", comment: "")
        
        first?.setFAIcon(icon: .FAHome,
                         size: CGSize(width: 35, height: 35),
                         textColor: ThemeConstants.secondaryColor,
                         backgroundColor: .clear,
                         selectedTextColor: ThemeConstants.mainColor,
                         selectedBackgroundColor: .clear)
        
        last?.setFAIcon(icon: .FAStar,
                        size: CGSize(width: 35, height: 35),
                        textColor: ThemeConstants.secondaryColor,
                        backgroundColor: .clear,
                        selectedTextColor: ThemeConstants.mainColor,
                        selectedBackgroundColor: .clear)
        
    }
    
}
