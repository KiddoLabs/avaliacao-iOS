//
//  MovieCollectionViewCell.swift
//  Kiddo Labs
//
//  Created by Lucas Domene Firmo on 8/21/16.
//  Copyright © 2016 Domene. All rights reserved.
//

import UIKit
import Haneke

class MovieCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    // MARK: - Life Cycle
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // MARK: - Content Managment
    
    /**
        Fill the movie cell outlets.
        - parameter movie: a movie instance.
     */
    func fill(movie: Movie) {
        clean()
        configure()
        titleLabel.text = movie.title
        yearLabel.text = String(movie.year)
        posterImageView.hnk_setImageFromURL(movie.poster.thumbnail)
    }
    
    /**
        Configure the initial values of the cell outlets.
     */
    func clean() {
        titleLabel.text = LABELS_UNTITLED
        yearLabel.text = LABELS_UNKNOWN
        posterImageView.image = nil
    }
    
    /**
        Configure the cell layout.
     */
    func configure() {
        // Configuring cell
        layer.cornerRadius = 2.0
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.lightGrayColor().CGColor
        layer.masksToBounds = true
        layer.shadowColor = UIColor.lightGrayColor().CGColor
        layer.shadowOffset = CGSizeMake(0, 2.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 1.0
        
        // Configuring image view
        posterImageView.layer.borderColor = UIColor.lightGrayColor().CGColor
        posterImageView.layer.borderWidth = 1.0
    }
    
}
