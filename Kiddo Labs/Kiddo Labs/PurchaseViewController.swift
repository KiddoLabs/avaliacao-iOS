//
//  PurchaseViewController.swift
//  Kiddo Labs
//
//  Created by Lucas Domene Firmo on 8/23/16.
//  Copyright © 2016 Domene. All rights reserved.
//

import UIKit

class PurchaseViewController: UICollectionViewController {
    // MARK: - Attributes
    var movie: Movie?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Instance Methods
    
    // MARK: - Collection View Data Source
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        guard let count = movie?.availableSources?.count else {
            return 0
        }
        return count
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let sources = movie?.availableSources {
            return sources[section].formats.count
        }
        return 0
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PurchaseCell", forIndexPath: indexPath) as? PurchaseCollectionViewCell
        let format = movie?.availableSources![indexPath.section].formats[indexPath.row]
        
        guard cell != nil else {
            return PurchaseCollectionViewCell()
        }
        
        guard format != nil else {
            return cell!
        }
        
        cell?.fill(format!)
        return cell!
    }
    
    // MARK: - Collection View Delegate
}
