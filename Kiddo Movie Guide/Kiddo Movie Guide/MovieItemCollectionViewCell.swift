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
    
    // MARK: - Content Handlers
    private static var _nullImage: UIImage? = nil
    static var nullImage: UIImage? {
        get {
            if (MovieItemCollectionViewCell._nullImage == nil) {
                MovieItemCollectionViewCell._nullImage =  UIImage.init(bgIcon: .FASquare,
                                                                       bgTextColor: .black,
                                                                       topIcon: .FAFilm,
                                                                       topTextColor: .white,
                                                                       bgLarge: true,
                                                                       size: CGSize(width: 100, height: 100))
            }
            return MovieItemCollectionViewCell._nullImage
        }
    }
    
    func clearContent() {
        self.labelMovieTitle.text   = NSLocalizedString("Movies.Item.NullTitle", comment: "")
        self.labelYear.text         = NSLocalizedString("Movies.Item.NullYear", comment: "")
        self.imageViewPoster.image  = MovieItemCollectionViewCell.nullImage

    }
    
    func setViewModel(movie: Movie) {
        self.clearContent()
        
        if (movie.year > 0) { self.labelYear.text = String(movie.year) }
        self.labelMovieTitle.text = (movie.title == nil || movie.title == "") ? movie.originalTitle : movie.title
        
        let imageFullURL = TMDBAPI.sharedInstance.imageBasePath + movie.posterPath
        
        let _ = self.imageViewPoster.setCQImage(imageFullURL, placeholder: MovieItemCollectionViewCell.nullImage)
    }
    
}
