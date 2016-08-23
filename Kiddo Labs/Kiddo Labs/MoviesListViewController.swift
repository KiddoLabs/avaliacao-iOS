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
    
    var isLastPage = false
    var movieIndex = 0
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isFavoriteView = false
        addViewTitle()
        fetchMovies()
    }
    
    // MARK: - Data Fetcher
    
    func fetchMovies(completion: (() -> ())? = nil) {
        MoviesRequest().makeRequest(movieIndex) { movies, error in
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
    
    override func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == moviesList.count - 3 {
            loadNextPage()
        }
    }
}

