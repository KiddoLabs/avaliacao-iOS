//
//  PurchaseViewController.swift
//  Kiddo Labs
//
//  Created by Lucas Domene Firmo on 8/23/16.
//  Copyright © 2016 Domene. All rights reserved.
//

import UIKit
import Haneke

class PurchaseViewController: UICollectionViewController {
    // MARK: - Attributes
    var movie: Movie?
    var isEmpty = false
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationController()
        setBackgroundImage()
    }
    
    // MARK: - Instance Methods
    
    func configureNavigationController() {
        navigationController?.toolbarHidden = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.translucent = true
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    func setBackgroundImage() {
        Shared.imageCache.fetch(URL: movie!.poster.largePoster!).onSuccess { image in
            let bgImage = UIImageView();
            bgImage.image = image
            bgImage.contentMode = .ScaleToFill
            self.collectionView?.backgroundView = bgImage
        }
    }
    
    // MARK: - Collection View Data Source
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        guard let count = movie?.availableSources?.count where count > 0 else {
            isEmpty = true
            return 1
        }
        return count
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let sources = movie?.availableSources {
            return sources[section].formats.count
        }
        return 0
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "sectionHeader", forIndexPath: indexPath) as? PurchaseHeader
        
        var title: String?
        if isEmpty {
            title = "Indisponível :("
        } else {
            title = movie?.availableSources![indexPath.section].displayName
        }
        
        guard header != nil else {
            return PurchaseHeader()
        }
        
        guard title != nil else {
            return header!
        }
        
        header!.headerTitle.text = title
        return header!
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
