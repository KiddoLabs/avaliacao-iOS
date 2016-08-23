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
        
        isFavorite = !appDelegate.realm.objects(Favorite.self).filter("id == \(movie.id)").isEmpty
        configureFavorites()
        
        posterImageView.hnk_setImageFromURL(movie.posterURL)
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
        if let availableFormats = movie?.availableFormats {
            for formatsDictionary in availableFormats {
                if let formats = formatsDictionary["formats"] as? [[String: AnyObject]] {
                    for format in formats {
                        if !allFormats.contains(format["format"] as! String) {
                            allFormats.append(format["format"] as! String)
                        }
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
    
    func addToFavorites() {
        try! appDelegate.realm.write {
            let favorite = Favorite()
            favorite.id = movie!.id
            favorite.title = movie!.title
            favorite.posterURL = (movie?.posterURL.absoluteString)!
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
}
