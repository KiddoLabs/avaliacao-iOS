//
//  FavoritesViewController.swift
//  Kiddo Labs
//
//  Created by Lucas Domene Firmo on 8/22/16.
//  Copyright © 2016 Domene. All rights reserved.
//

import UIKit
import RealmSwift

class FavoritesViewController: BaseCollectionViewController {

    // MARK: - Attributes
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isFavoriteView = true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        fetchFavorites()
    }
    
    // MARK: - Data Fetcher
    
    func fetchFavorites() {
        let result = appDelegate.realm.objects(Favorite.self)
        favoritesList = Array(result)
        collectionView?.reloadData()
    }
}
