//
//  MovieItemCollectionViewCell.swift
//  Kiddo Movie Guide
//
//  Created by Rogerio Hirooka on 8/13/17.
//  Copyright © 2017 Kiddo Labs. All rights reserved.
//

import Foundation
import UIKit
import Font_Awesome_Swift
import CQImageDownloader

class MovieItemCollectionViewCell : UICollectionViewCell {

    // MARK: - Variables
    var downloader : CQImageDownloader? = nil
    // MARK: - Outlets
    @IBOutlet weak var labelMovieTitle: UILabel!
    @IBOutlet weak var labelYear: UILabel!
    @IBOutlet weak var imageViewPoster: UIImageView!
    
    // MARK: - Init/Deinit
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    deinit {
        self.imageViewPoster.image = nil
    }
    
    func setupView() {
        self.layer.masksToBounds = true
        
        self.layer.cornerRadius = ThemeConstants.defaultRadius
        self.layer.borderColor  = ThemeConstants.cellShadesColor.cgColor
        self.layer.shadowColor  = ThemeConstants.cellShadesColor.cgColor
        
        self.layer.shadowOffset = CGSize(width: 0, height: ThemeConstants.defaultRadius)
        self.layer.shadowRadius = ThemeConstants.defaultRadius
        self.layer.borderWidth  = ThemeConstants.defaultBorder
        
        self.imageViewPoster.layer.borderColor = ThemeConstants.cellShadesColor.cgColor
        self.imageViewPoster.layer.borderWidth = ThemeConstants.defaultBorder
        
    }
    
    // MARK: - Methods
    private static var _nullImage: UIImage? = nil
    static var nullImage: UIImage? {
        get {
            if (MovieItemCollectionViewCell._nullImage == nil) {
                MovieItemCollectionViewCell._nullImage =  UIImage.init(bgIcon: .FASquare,
                                                                       bgTextColor: .black,
                                                                       topIcon: .FAFilm,
                                                                       topTextColor: .white,
                                                                       bgLarge: true,
                                                                       size: CGSize(width: 100, height: 144))
            }
            return MovieItemCollectionViewCell._nullImage
        }
    }
    
    func clearContent() {
        self.labelMovieTitle?.text   = NSLocalizedString("Movies.Item.NullTitle", comment: "")
        self.labelYear?.text         = NSLocalizedString("Movies.Item.NullYear", comment: "")
        self.imageViewPoster?.image  = MovieItemCollectionViewCell.nullImage
    }
    
    /**
     Assigns the movie entity and render it's content.
     Image poster is prefetched and cached - null image is the FA "Film"
     */
    func setViewModel(movie: Movie) {
        if self.downloader != nil {
            self.downloader?.cancelDownload()
            self.downloader = nil
        }
        
        self.setupView()
        self.clearContent()
        
        if (movie.year > 0) { self.labelYear.text = String(movie.year) }
        self.labelMovieTitle?.text = (movie.title == nil || movie.title == "") ? movie.originalTitle : movie.title
        
        let imageFullURL = TMDBAPI.sharedInstance.imageBasePath + movie.posterPath
        
        self.downloader = self.imageViewPoster.setCQImage(imageFullURL, placeholder: MovieItemCollectionViewCell.nullImage)
    }
    
}
