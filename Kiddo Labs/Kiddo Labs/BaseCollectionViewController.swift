//
//  BaseCollectionViewController.swift
//  Kiddo Labs
//
//  Created by Lucas Domene Firmo on 8/23/16.
//  Copyright © 2016 Domene. All rights reserved.
//

import UIKit

class BaseCollectionViewController: UICollectionViewController {
    
    var favoritesList = [Favorite]()
    var moviesList = [Movie]()
    var isFavoriteView = false
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: MOVIE_CELL, bundle: nil)
        self.collectionView?.registerNib(nib, forCellWithReuseIdentifier: MOVIE_CELL)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.toolbarHidden = true
    }
    
    // MARK: Instance Methods
    func addViewTitle() {
        let logoImageView = UIImageView(image: UIImage(named: isFavoriteView ? FAVORITES_LABEL : MOVIES_LABEL))
        let imageItem = UIBarButtonItem(customView: logoImageView)
        navigationItem.leftBarButtonItem = imageItem
    }
    
    // MARK: - Collection Control
    
    private func movie(indexPath: NSIndexPath) -> Movie? {
        let index = indexPath.row
        
        if isFavoriteView {
            if favoritesList.count > index && index >= 0 {
                let favorite = favoritesList[index]
                return Movie(id: favorite.id, title: favorite.title, year: favorite.year, poster: Poster(thumbnail: NSURL(string: favorite.thumbnail)!, largePoster: NSURL(string: favorite.largerPoster)!))
            }
        } else {
            if moviesList.count > index && index >= 0 {
                return moviesList[index]
            }
        }
        
        return nil
    }
    
    // MARK: UICollectionView Data Source
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isFavoriteView ? favoritesList.count : moviesList.count
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
            if  let movieDetailsViewController = (segue.destinationViewController as? MovieDetailsTableViewController),
                let movie = sender as? Movie {
                movieDetailsViewController.hidesBottomBarWhenPushed = true
                movieDetailsViewController.movie = movie
            }
        }
    }
}
