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
    
    /**
        Fill the cell outlets.
        - parameter format: the format instance.
     */
    func fill(format: Format) {
        clean()
        configure()
        formatLabel.text = format.formatName
        priceLabel.text = "$" + format.price
        purchaseType.text = format.purchaseType.capitalizedString
    }
    
    /**
        Configure the initial values of the cell outlets.
     */
    func clean() {
        formatLabel.text = LABELS_UNKNOWN
        priceLabel.text = LABELS_NO_PRICE
        purchaseType.text = LABELS_UNKNOWN
    }
    
    /**
        Configure the cell layout.
     */
    func configure() {
        layer.cornerRadius = 5.0
        layer.masksToBounds = true
        self.backgroundColor = CUSTOM_GREY_COLOR
    }
}
