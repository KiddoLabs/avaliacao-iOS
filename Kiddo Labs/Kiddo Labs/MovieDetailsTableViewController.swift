//
//  MovieDetailsTableViewController.swift
//  Kiddo Labs
//
//  Created by Lucas Domene Firmo on 8/22/16.
//  Copyright © 2016 Domene. All rights reserved.
//

import UIKit
import RealmSwift

class MovieDetailsTableViewController: UITableViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var movieFormatsSegmentedControl: UISegmentedControl!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var formatsLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    // MARK: - Attributes
    
    var movie: Movie?
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var isFavorite = false
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        movieFormatsSegmentedControl.removeAllSegments()
        
        if let movie = self.movie {
            self.fetchMovieInformation(movie, completion: {
                self.fill(self.movie!)
            })
        }
        
        configureShareButton()
        configureNavigationController()
    }
    
    // MARK: - Instance Methods
    
    func availableQualityFormats() -> [String] {
        var allFormats = [String]()
        if let availableSources = movie?.availableSources {
            for source in availableSources {
                for format in source.formats {
                    if !allFormats.contains(format.formatName) {
                        allFormats.append(format.formatName)
                    }
                }
            }
        }
        return allFormats
    }
    
    func fill(movie: Movie) {
        configureView()
        
        isFavorite = !appDelegate.realm.objects(Favorite.self).filter("id == \(movie.id)").isEmpty
        configureFavorites()
        
        posterImageView.hnk_setImageFromURL(movie.poster.thumbnail)
        titleLabel.text = movie.title
        yearLabel.text = String(movie.year)
        movieDescription.text = movie.description
        configureSegmentedControl()
    }
    
    // MARK: - Configuration Methods
    
    func configureNavigationController() {
        navigationController?.toolbarHidden = false
        navigationController?.navigationBar.tintColor = CUSTOM_RED_COLOR
        navigationController?.navigationBar.translucent = false
    }
    
    func configureView() {
        titleLabel.backgroundColor = UIColor.whiteColor()
        yearLabel.backgroundColor = UIColor.whiteColor()
        formatsLabel.backgroundColor = UIColor.whiteColor()
        favoriteButton.backgroundColor = UIColor.whiteColor()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(MovieDetailsTableViewController.favoriteButtonPressed(_:)))
        favoriteImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func configureSegmentedControl() {
        let formats = availableQualityFormats()
        for (index, format) in formats.enumerate() {
            movieFormatsSegmentedControl.insertSegmentWithTitle(format, atIndex: index, animated: false)
        }
        
        if movieFormatsSegmentedControl.numberOfSegments == 0 {
            movieFormatsSegmentedControl.insertSegmentWithTitle(LABELS_UNAVAILABLE, atIndex: 0, animated: false)
        }
    }
    
    func configureShareButton() {
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(named: SHARE_IMAGE), style: .Plain, target: self, action: #selector(MovieDetailsTableViewController.shareButtonPressed))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    // MARK: - Data Fetcher
    
    func fetchMovieInformation(movie: Movie, completion: () -> ()) {
        MovieInformationRequest().makeRequest(movie) { movie, error in
            if error != nil {
                self.presentViewController(UIAlertController.errorAlert(error!), animated: true, completion: nil)
                completion()
            }
            
            if movie != nil {
                self.movie = movie!
            }
    
            completion()
        }
    }
    
    // MARK: - Favorites
    
    func configureFavorites() {
        if isFavorite {
            favoriteButton.setTitle(LABELS_REMOVE_FROM_FAVORITES, forState: .Normal)
            favoriteImageView.image = UIImage(named: STAR_HIGHLIGHTED)
        } else {
            favoriteButton.setTitle(LABELS_ADD_TO_FAVORITES, forState: .Normal)
            favoriteImageView.image = UIImage(named: STAR)
        }
    }
    
    func addToFavorites() {
        try! appDelegate.realm.write {
            if let movie = self.movie {
                let favorite = Favorite()
                favorite.id = movie.id
                favorite.title = movie.title
                favorite.thumbnail = movie.poster.thumbnail.absoluteString
                favorite.largerPoster = movie.poster.largePoster.absoluteString
                favorite.year = movie.year
                appDelegate.realm.add(favorite)
            } else {
                self.presentViewController(UIAlertController.errorAlert(), animated: true, completion: nil)
            }
        }
    }
    
    func deleteFromFavorites() {
        try! appDelegate.realm.write {
            if let persistedMovie = appDelegate.realm.objects(Favorite.self).filter("id == \(movie!.id)").first {
                appDelegate.realm.delete(persistedMovie)
            } else {
                self.presentViewController(UIAlertController.errorAlert(), animated: true, completion: nil)
            }
        }
    }
    
    // MARK: - Actions
    
    func shareButtonPressed() {
        if let movie = self.movie {
            let textToShare = "Estou assistindo \(movie.title)!"
            let activityViewController = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
            self.presentViewController(activityViewController, animated: true, completion: nil)
        } else {
            self.presentViewController(UIAlertController.errorAlert(), animated: true, completion: nil)
        }
    }
    
    @IBAction func favoriteButtonPressed(sender: AnyObject) {
        if !isFavorite {
            addToFavorites()
            isFavorite = true
        } else {
            deleteFromFavorites()
            isFavorite = false
        }
        configureFavorites()
    }
    
    @IBAction func purchaseButtonPressed(sender: AnyObject) {
        self.performSegueWithIdentifier(PURCHASE_SEGUE, sender: movie)
    }

    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == PURCHASE_SEGUE {
            if  let purchaseViewController = (segue.destinationViewController as? PurchaseViewController),
                let movie = sender as? Movie {
                purchaseViewController.movie = movie
                navigationItem.backBarButtonItem = UIBarButtonItem(title: LABELS_BACK, style: .Plain, target: nil, action: nil)
            }
        }
    }

}
