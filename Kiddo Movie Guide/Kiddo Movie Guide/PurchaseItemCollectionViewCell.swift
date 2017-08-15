//
//  PurchaseItemCollectionViewCell.swift
//  Kiddo Movie Guide
//
//  Created by Rogerio Hirooka on 8/15/17.
//  Copyright © 2017 Kiddo Labs. All rights reserved.
//

import Foundation

class PurchaseItemCollectionViewCell : UICollectionViewCell {
    
    // MARK: - Outlets

    @IBOutlet weak var labelResolution: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelLicenseKind: UILabel!
    
    // MARK: - Init/Deinit
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    deinit {
    }
    
    // MARK: - Methods
    func setupView() {
        self.layer.cornerRadius = ThemeConstants.purchaseRadius
        self.layer.masksToBounds = true
        self.backgroundColor = ThemeConstants.purchaseBackgroundColor
    }
    
    func clearContent() {
        self.labelLicenseKind.text  = NSLocalizedString("Unknown", comment: "")
        self.labelResolution.text   = NSLocalizedString("Unknown", comment: "")
        self.labelPrice.text        = NSLocalizedString("PriceUnavailable", comment: "")
    }
    
    func setSelected(state: Bool) {
        if state {
            self.labelLicenseKind.textColor = ThemeConstants.mainColor
            self.labelResolution.textColor  = ThemeConstants.mainColor
            self.labelPrice.textColor       = ThemeConstants.mainColor
            self.backgroundColor = ThemeConstants.purchaseHighlightColor
        } else {
            self.labelLicenseKind.textColor = ThemeConstants.purchaseHighlightColor
            self.labelResolution.textColor  = ThemeConstants.purchaseHighlightColor
            self.labelPrice.textColor       = ThemeConstants.purchaseHighlightColor
            self.backgroundColor = ThemeConstants.purchaseBackgroundColor
        }
        self.contentView.backgroundColor = self.backgroundColor
    }
    
    func setViewModel(movieVersion: MovieVersion) {
        self.clearContent()
        self.setupView()
        
        self.labelLicenseKind.text =
            movieVersion.licenseKind == MovieVersion.Licenses.Purchase ?
            NSLocalizedString("Buy", comment: "") : NSLocalizedString("Rent", comment: "")
        self.labelResolution.text = "\(movieVersion.resolution)"
        
        let priceText = String(format: "%0.*f", 2, movieVersion.price)
        self.labelPrice.text = "$ \(priceText)"
    }
    
}
