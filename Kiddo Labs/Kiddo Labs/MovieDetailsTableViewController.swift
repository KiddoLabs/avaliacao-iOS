//
//  MovieDetailsTableViewController.swift
//  Kiddo Labs
//
//  Created by Lucas Domene Firmo on 8/22/16.
//  Copyright © 2016 Domene. All rights reserved.
//

import UIKit

class MovieDetailsTableViewController: UITableViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var movieFormatsSegmentedControl: UISegmentedControl!
    @IBOutlet weak var movieDescription: UILabel!
    
    // MARK: - Attributes
    var movie: Movie?
    
    // MARK: - Life Cycle
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let movie = self.movie {
            fill(movie)
        }
    }
    
    // MARK: - Instance Methods
    func fill(movie: Movie) {
        posterImageView.hnk_setImageFromURL(movie.posterURL)
        titleLabel.text = movie.title
        yearLabel.text = String(movie.year)
        
        let movieInformationRequest = MovieInformationRequest(movie: movie)
        movieInformationRequest.makeRequest(movie.id) { movie, error in
            if error != nil {
                //TREAT ERROR
            }
            
            self.movieDescription.text = movie?.description
        }
    }
}
