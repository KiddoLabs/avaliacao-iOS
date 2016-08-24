//
//  MoviesListViewController.swift
//  Kiddo Labs
//
//  Created by Lucas Domene Firmo on 8/19/16.
//  Copyright © 2016 Domene. All rights reserved.
//

import UIKit

class MoviesListViewController: BaseCollectionViewController {

    // MARK: - Attributes
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var isLastPage = false
    var movieIndex = 0
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        isFavoriteView = false
        super.viewDidLoad()
        createPullToRefresh()
        
        // Fetch movies
        self.activityIndicator.startAnimating()
        fetchMovies { 
            self.activityIndicator.stopAnimating()
        }
    }
    
    // MARK: - Data Fetcher
    
    
    /**
        Fetch movies from GuideBox.
        - parameter completion: A completion closure to be used after fetching movies.
     */
    func fetchMovies(completion: (() -> ())? = nil) {
        MoviesRequest().makeRequest(movieIndex) { movies, error in
            if error != nil {
                // Present an error
                self.presentViewController(UIAlertController.errorAlert(error!), animated: true, completion: nil)
                completion?()
            }
            
            // Check if received more movies
            if let moviesList = movies where moviesList.count > 0 {
                self.moviesList.appendContentsOf(moviesList)
                self.collectionView?.reloadData()
            } else {
                self.presentViewController(UIAlertController.errorAlert(error!), animated: true, completion: nil)
                self.isLastPage = true
            }
            completion?()
        }
    }
    
    // MARK: - Pull to refresh
    
    /**
        Create a UIRefreshControl and add to collectionView.
     */
    private func createPullToRefresh() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(MoviesListViewController.refreshMovies(_:)), forControlEvents: .ValueChanged)
        self.collectionView?.addSubview(refreshControl)
    }
    
    /**
        Set back the initial values and fetch the movies again
        - parameter sender: the UIRefreshControl
     */
    func refreshMovies(sender: UIRefreshControl) {
        moviesList = [Movie]()
        isLastPage = false
        movieIndex = 0
        fetchMovies {
            sender.endRefreshing()
        }
    }
    
    // MARK: - Paging
    
    /**
        Load the next page of movies.
     */
    private func loadNextPage() {
        if !isLastPage {
            movieIndex += 20
            fetchMovies()
        }
    }
    
    override func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        // When it's almost the end of the current movie list, fetch more 20 movies.
        if indexPath.row == moviesList.count - 3 {
            loadNextPage()
        }
    }
}

