//
//  BaseTabBarViewController.swift
//  Kiddo Movie Guide
//
//  Created by Rogerio Hirooka on 8/13/17.
//  Copyright © 2017 Kiddo Labs. All rights reserved.
//

import UIKit
import ESTabBarController

class CustomTabBarViewController : UITabBarController, UITabBarControllerDelegate {

    // MARK: - Init/Deinit
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
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
        
        let navigationController = self.viewControllers?.last as! UINavigationController
        let favorites = navigationController.viewControllers.first as! MovieListViewController
        favorites.isFavorites = true
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let tabViewControllers = tabBarController.viewControllers!
        guard let toIndex = tabViewControllers.index(of: viewController) else {
            return false
        }
        
        animateToTab(toIndex: toIndex)
        return true
    }
    
    func animateToTab(toIndex: Int) {
        let tabViewControllers = viewControllers!
        let fromView = selectedViewController!.view
        let toView = tabViewControllers[toIndex].view
        let fromIndex = tabViewControllers.index(of: selectedViewController!)
        
        guard fromIndex != toIndex else {return}
        
        fromView?.superview!.addSubview(toView!)
        
        // Position toView off screen (to the left/right of fromView)
        let screenWidth = UIScreen.main.bounds.size.width;
        let scrollRight = toIndex > fromIndex!;
        let offset = (scrollRight ? screenWidth : -screenWidth)
        toView?.center = CGPoint(x: (fromView?.center.x)! + offset, y: (toView?.center.y)!)
        
        // Disable interaction during animation
        view.isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 0,
                       options: UIViewAnimationOptions.curveEaseOut,
                       animations: {
            
            // Slide the views by -offset
            fromView?.center = CGPoint(x: (fromView?.center.x)! - offset, y: (fromView?.center.y)!);
            toView?.center   = CGPoint(x: (toView?.center.x)! - offset, y: (toView?.center.y)!);
            
        }, completion: { finished in
            
            // Remove the old view from the tabbar view.
            fromView?.removeFromSuperview()
            self.selectedIndex = toIndex
            // Restore interaction
            self.view.isUserInteractionEnabled = true
        })
    }

}
