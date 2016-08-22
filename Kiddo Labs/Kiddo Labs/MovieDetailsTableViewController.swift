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
    @IBOutlet weak var formatsLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // MARK: - Attributes
    var movie: Movie?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        movieFormatsSegmentedControl.removeAllSegments()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let movie = self.movie {
            self.fetchMovieInformation(movie, completion: { 
                self.fill(self.movie!)
            })
        }
    }
    
    // MARK: - Instance Methods
    func fill(movie: Movie) {
        configureView()
        
        if let url = NSURL(string: movie.posterURL) {
            posterImageView.hnk_setImageFromURL(url)
        }
        
        titleLabel.text = movie.title
        yearLabel.text = String(movie.year)
        movieDescription.text = movie.movieDescription
        configureSegmentedControl()
    }
    
    func configureSegmentedControl() {
        let formats = availableQualityFormats()
        for (index, format) in formats.enumerate() {
            movieFormatsSegmentedControl.insertSegmentWithTitle(format, atIndex: index, animated: false)
        }
    }
    
    func fetchMovieInformation(movie: Movie, completion: () -> ()) {
        MovieInformationRequest().makeRequest(movie) { movie, error in
            if error != nil {
                //TREAT ERROR
                completion()
            }
            
            self.movie = movie
            completion()
        }
    }
    
    func availableQualityFormats() -> [String] {
        var allFormats = [String]()
        for sources in (movie?.sources)! {
            for format in sources.formats {
                if !allFormats.contains(format.format) {
                    allFormats.append(format.format)
                }
            }
        }
        return allFormats
    }
    
    func configureView() {
        titleLabel.backgroundColor = UIColor.whiteColor()
        yearLabel.backgroundColor = UIColor.whiteColor()
        formatsLabel.backgroundColor = UIColor.whiteColor()
        favoriteButton.backgroundColor = UIColor.whiteColor()
    }
}
