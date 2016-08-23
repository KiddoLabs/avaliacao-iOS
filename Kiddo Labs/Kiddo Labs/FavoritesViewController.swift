//
//  FavoritesViewController.swift
//  Kiddo Labs
//
//  Created by Lucas Domene Firmo on 8/22/16.
//  Copyright © 2016 Domene. All rights reserved.
//

import UIKit
import RealmSwift

class FavoritesViewController: UICollectionViewController {

    // MARK: - Attributes
    var favoritesList = [Favorite]()
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: MOVIE_CELL, bundle: nil)
        collectionView?.registerNib(nib, forCellWithReuseIdentifier: MOVIE_CELL)
        
        addViewTitle()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.toolbarHidden = true
        fetchFavorites()
    }
    
    // MARK: Instance Methods
    
    func addViewTitle() {
        let logoImageView = UIImageView(image: UIImage(named: FAVORITES_LABEL))
        let imageItem = UIBarButtonItem(customView: logoImageView)
        navigationItem.leftBarButtonItem = imageItem
    }
    
    // MARK: - Data Fetcher
    func fetchFavorites() {
        let result = appDelegate.realm.objects(Favorite.self)
        favoritesList = Array(result)
        collectionView?.reloadData()
    }
    
    // MARK: - Collection Control
    
    private func movie(indexPath: NSIndexPath) -> Movie? {
        let index = indexPath.row
        if favoritesList.count > index && index >= 0 {
            let favorite = favoritesList[index]
            return Movie(id: favorite.id, title: favorite.title, year: favorite.year, poster: Poster(thumbnail: NSURL(string: favorite.thumbnail)!, largePoster: nil))
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
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(MOVIE_CELL, forIndexPath: indexPath) as? MovieCollectionViewCell
        let movie = self.movie(indexPath)
        
        guard cell != nil else {
            return MovieCollectionViewCell()
        }
        
        guard movie != nil else {
            return cell!
        }
        
        cell?.fill(movie!)
        return cell!
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let movie = movie(indexPath) {
            self.performSegueWithIdentifier(MOVIE_DETAILS_SEGUE, sender: movie)
        }
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == MOVIE_DETAILS_SEGUE {
            if  let movieDetailsViewController = segue.destinationViewController as? MovieDetailsTableViewController,
                let movie = sender as? Movie {
                movieDetailsViewController.hidesBottomBarWhenPushed = true
                movieDetailsViewController.movie = movie
            }
        }
    }

}
