//
//  FavoritesViewController.swift
//  Kiddo Labs
//
//  Created by Lucas Domene Firmo on 8/22/16.
//  Copyright © 2016 Domene. All rights reserved.
//

import UIKit

class FavoritesViewController: UICollectionViewController {

    var favoritesList = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "MovieCell", bundle: nil)
        collectionView?.registerNib(nib, forCellWithReuseIdentifier: "MovieCell")
        
        addViewTitle()
    }
    
    // MARK: Instance Methods
    
    func addViewTitle() {
        let logoImageView = UIImageView(image: UIImage(named: "favoritesLabel"))
        let imageItem = UIBarButtonItem(customView: logoImageView)
        navigationItem.leftBarButtonItem = imageItem
    }
    
    // MARK: - Data Fetcher
    func fetchFavorites() {
        
    }
    
    // MARK: - Collection Control
    
    private func movie(indexPath: NSIndexPath) -> Movie? {
        let index = indexPath.row
        if favoritesList.count > index && index >= 0 {
            return favoritesList[index]
        }
        return nil
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoritesList.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MovieCell", forIndexPath: indexPath) as? MovieCollectionViewCell
        let movie = self.movie(indexPath)
        
        guard cell != nil else {
            print("\nMovieCollectionViewCell couldn't be created. Setting an empty cell instead the non created cell.\n")
            return MovieCollectionViewCell()
        }
        
        guard movie != nil else {
            print("\nMovie couldn't be load. Setting an empty cell.\n")
            return cell!
        }
        
        cell?.fill(movie!)
        return cell!
    }

}
