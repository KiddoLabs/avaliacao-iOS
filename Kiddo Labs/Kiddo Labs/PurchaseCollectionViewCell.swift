//
//  PurchaseCollectionViewCell.swift
//  Kiddo Labs
//
//  Created by Lucas Domene Firmo on 8/23/16.
//  Copyright © 2016 Domene. All rights reserved.
//

import UIKit

class PurchaseCollectionViewCell: UICollectionViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var formatLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var purchaseType: UILabel!
    
    // MARK: - Life Cycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // MARK: - Content Managment
    func fill(format: Format) {
        clean()
        configure()
        formatLabel.text = format.formatName
        priceLabel.text = "$" + format.price
        purchaseType.text = format.purchaseType.capitalizedString
    }
    
    func clean() {
        formatLabel.text = LABELS_UNKNOWN
        priceLabel.text = LABELS_NO_PRICE
        purchaseType.text = LABELS_UNKNOWN
    }
    
    func configure() {
        layer.cornerRadius = 5.0
        layer.masksToBounds = true
        self.backgroundColor = CUSTOM_GREY_COLOR
    }
}
