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
        self.activityIndicator.startAnimating()
        fetchMovies { 
            self.activityIndicator.stopAnimating()
        }
    }
    
    // MARK: - Data Fetcher
    
    func fetchMovies(completion: (() -> ())? = nil) {
        MoviesRequest().makeRequest(movieIndex) { movies, error in
            if error != nil {
                self.presentViewController(UIAlertController.errorAlert(error!), animated: true, completion: nil)
                completion?()
            }
            
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
    
    private func createPullToRefresh() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(MoviesListViewController.refreshMovies(_:)), forControlEvents: .ValueChanged)
        self.collectionView?.addSubview(refreshControl)
    }
    
    func refreshMovies(sender: UIRefreshControl) {
        moviesList = [Movie]()
        isLastPage = false
        movieIndex = 0
        fetchMovies {
            sender.endRefreshing()
        }
    }
    
    // MARK: - Paging
    
    private func loadNextPage() {
        if !isLastPage {
            movieIndex += 20
            fetchMovies()
        }
    }
    
    override func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == moviesList.count - 3 {
            loadNextPage()
        }
    }
}

