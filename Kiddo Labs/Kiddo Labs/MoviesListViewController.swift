//
//  MoviesListViewController.swift
//  Kiddo Labs
//
//  Created by Lucas Domene Firmo on 8/19/16.
//  Copyright © 2016 Domene. All rights reserved.
//

import UIKit

class MoviesListViewController: UICollectionViewController {

    // MARK: - Attributes
    
    var moviesList = [Movie]()
    var isLastPage = false
    var movieIndex = 0
    
    // MARK: - Class Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchMovies()
        print("WIDTH: \(self.view.bounds.size.width)")
    }
    
    // MARK: - Data Fetcher
    
    func fetchMovies(completion: (() -> ())? = nil) {
        let moviesRequest = MoviesRequest()
        moviesRequest.makeRequest(movieIndex) { movies, error in
            if error != nil {
                completion?()
                // TREAT ERROR
            }
            
            if let moviesList = movies where moviesList.count > 0 {
                self.moviesList.appendContentsOf(moviesList)
                self.collectionView?.reloadData()
            } else {
                print("Error: No movies found")
                self.isLastPage = true
            }
            completion?()
        }
    }
    
    // MARK: - Paging
    
    private func loadNextPage() {
        if !isLastPage {
            movieIndex += 20
            fetchMovies()
        }
    }
    
    // MARK: - Collection Control
    
    private func movie(indexPath: NSIndexPath) -> Movie? {
        let index = indexPath.row
        if moviesList.count > index && index >= 0 {
            return moviesList[index]
        }
        return nil
    }
    
    // MARK: - UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesList.count
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
        cell?.backgroundColor = UIColor.blueColor()
        return cell!
    }
    
    override func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == moviesList.count - 3 {
            loadNextPage()
        }
    }


}

