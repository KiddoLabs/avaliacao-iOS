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
    
    func fill(movie: Movie) {
        clean()
        configure()
        titleLabel.text = movie.title
        yearLabel.text = String(movie.year)
        posterImageView.hnk_setImageFromURL(movie.posterURL)
    }
    
    func clean() {
        titleLabel.text = "Untitled"
        yearLabel.text = "Unknown"
        posterImageView.image = nil
    }
    
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
