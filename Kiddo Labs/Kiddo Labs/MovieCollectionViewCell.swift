//
//  MovieCollectionViewCell.swift
//  Kiddo Labs
//
//  Created by Lucas Domene Firmo on 8/21/16.
//  Copyright © 2016 Domene. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    // MARK: - Life's Cycle
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // MARK: - Content Managment
    
    func fill(movie: Movie) {
        self.clean()
        self.titleLabel.text = movie.title
        self.yearLabel.text = String(movie.year)
    }
    
    func clean() {
        self.titleLabel.text = "Untitled"
        self.yearLabel.text = "Unknown"
    }
    
}
