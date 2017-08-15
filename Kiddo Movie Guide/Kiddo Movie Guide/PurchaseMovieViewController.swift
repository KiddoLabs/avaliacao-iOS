//
//  PurchaseMovieViewController.swift
//  Kiddo Movie Guide
//
//  Created by Rogerio Hirooka on 8/15/17.
//  Copyright © 2017 Kiddo Labs. All rights reserved.
//

import Foundation
import AMSmoothAlert


class PurchaseMovieViewController : UICollectionViewController {

    
    // MARK: - Private Constants
    let cellID = "PurchaseCell"
    
    // MARK: - Properties
    var dataItem : Movie?
    var sourceVersionsA : [MovieVersion]?
    var sourceVersionsB : [MovieVersion]?
    
    // MARK: Variables

    
    // MARK: Outlets

    
    // MARK: - Init/Deinit
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setupInterface()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: NSLocalizedString("UI.Back", comment: ""),
                                                                                      style: UIBarButtonItemStyle.plain,
                                                                                      target: nil,
                                                                                      action: nil)

        self.setViewModel(movie: dataItem!)

    }
    
    // MARK: - Methods
    
    // MARK: Render Movie Data
    func setViewModel(movie: Movie) {
        self.dataItem = movie
        
        let backgroundImageView = UIImageView(frame: self.collectionView!.frame)
        self.collectionView?.backgroundView = backgroundImageView
        backgroundImageView.contentMode = .scaleAspectFill
        
        let imageFullURL = TMDBAPI.sharedInstance.imageBasePath + movie.posterPath
        let _ = backgroundImageView.setCQImage(imageFullURL, placeholder: MovieItemCollectionViewCell.nullImage)
        
        self.sourceVersionsA = self.dataItem?.MOCK_getVersions(sourceApple: true)
        self.sourceVersionsB = self.dataItem?.MOCK_getVersions(sourceApple: false)
    }
    
    // MARK: Events
    
    @IBAction func tapPerformPurchase(_ sender: Any) {
        let alert = AMSmoothAlertView(dropAlertWithTitle: NSLocalizedString("Purchase.Title", comment: ""),
                                      andText: NSLocalizedString("Purchase.Message", comment: ""),
                                      andCancelButton: true,
                                      for: AlertType.success)
        alert?.show()

    }
    
    // MARK: View Configuration
    private func setupInterface() {
        self.navigationController?.isToolbarHidden = false
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ((section == 0) ? self.sourceVersionsA?.count : self.sourceVersionsB?.count)!
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
            as? PurchaseItemCollectionViewCell else {
                return PurchaseItemCollectionViewCell()
        }

        cell.clearContent()
        let currentArray = ((indexPath.section == 0) ? self.sourceVersionsA : self.sourceVersionsB)!
        let model = currentArray[indexPath.row]

        cell.setViewModel(movieVersion: model)
        
        return cell
    }
    
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? PurchaseItemCollectionViewCell
        cell?.setSelected(state: true)
        
        //collectionView.indexPathsForSelectedItems?.count == 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? PurchaseItemCollectionViewCell
        cell?.setSelected(state: false)
    }

    // MARK: Controller Flow


    
}
