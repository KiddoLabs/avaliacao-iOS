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

    @IBOutlet weak var emptyView: UIView!
    // MARK: - Attributes
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        isFavoriteView = true
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        fetchFavorites()
    }
    
    // MARK: - Data Fetcher
    
    /**
        Fetch all the favorite movies from the database.
     */
    func fetchFavorites() {
        let result = appDelegate.realm.objects(Favorite.self)
        favoritesList = Array(result)
        
        if !(favoritesList.count > 0) {
            emptyView.hidden = false
        } else {
            emptyView.hidden = true
        }
        collectionView?.reloadData()
    }
}
