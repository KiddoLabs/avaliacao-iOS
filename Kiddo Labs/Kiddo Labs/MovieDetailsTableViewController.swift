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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        movieFormatsSegmentedControl.removeAllSegments()
        configureNavigationController()
        
        if let movie = self.movie {
            self.fetchMovieInformation(movie, completion: {
                self.fill(self.movie!)
            })
        }
        configureShareButton()
    }
    
    // MARK: - Instance Methods
    func configureNavigationController() {
        navigationController?.toolbarHidden = false
        navigationController?.navigationBar.tintColor = UIColor(red: 201.0/255.0, green: 0, blue: 0, alpha: 1.0)
        navigationController?.navigationBar.translucent = false
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
    
    func configureSegmentedControl() {
        let formats = availableQualityFormats()
        for (index, format) in formats.enumerate() {
            movieFormatsSegmentedControl.insertSegmentWithTitle(format, atIndex: index, animated: false)
        }
    gs
        
        if movieFormatsSegmentedControl.numberOfSegments == 0 {
            movieFormatsSegmentedControl.insertSegmentWithTitle("Indisponível", atIndex: 0, animated: false)
        }
    }
    
    func configureShareButton() {
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "share"), style: .Plain, target: self, action: #selector(MovieDetailsTableViewController.shareButtonPressed))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func shareButtonPressed() {
        let textToShare = "Estou assistindo \(movie!.title)!"
        let activityViewController = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
        self.presentViewController(activityViewController, animated: true, completion: nil)
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
    
    func configureView() {
        titleLabel.backgroundColor = UIColor.whiteColor()
        yearLabel.backgroundColor = UIColor.whiteColor()
        formatsLabel.backgroundColor = UIColor.whiteColor()
        favoriteButton.backgroundColor = UIColor.whiteColor()
    }
    
    func configureFavorites() {
        if isFavorite {
            favoriteButton.setTitle("Remover dos favoritos", forState: .Normal)
            favoriteImageView.image = UIImage(named: "star_highlighted")
        } else {
            favoriteButton.setTitle("Adicionar aos favoritos", forState: .Normal)
            favoriteImageView.image = UIImage(named: "star")
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
        self.performSegueWithIdentifier("purchaseOptions", sender: movie)
    }
    
    func addToFavorites() {
        try! appDelegate.realm.write {
            let favorite = Favorite()
            favorite.id = movie!.id
            favorite.title = movie!.title
            favorite.thumbnail = (movie?.poster.thumbnail.absoluteString)!
            favorite.year = movie!.year
            appDelegate.realm.add(favorite)
        }
    }
    
    func deleteFromFavorites() {
        try! appDelegate.realm.write {
            let persistedMovie = appDelegate.realm.objects(Favorite.self).filter("id == \(movie!.id)").first
            appDelegate.realm.delete(persistedMovie!)
        }
    }

    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "purchaseOptions" {
            if  let purchaseViewController = (segue.destinationViewController as? PurchaseViewController),
                let movie = sender as? Movie {
                purchaseViewController.movie = movie
                navigationItem.backBarButtonItem = UIBarButtonItem(title: "Voltar", style: .Plain, target: nil, action: nil)
            }
        }
    }

}
