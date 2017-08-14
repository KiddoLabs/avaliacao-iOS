//
//  FirstViewController.swift
//  Kiddo Movie Guide
//
//  Created by Rogerio Hirooka on 8/10/17.
//  Copyright © 2017 Kiddo Labs. All rights reserved.
//

import UIKit
import MRProgress

class MovieListViewController:
    UIViewController,
    UICollectionViewDataSource,
    UICollectionViewDelegate {
    
    // MARK: - Private Constants
    let cellID = "MovieItemCell"
    
    // MARK: - Properties
    var isFavorites = false
    var dataset = [Movie]()
    var page = 1
    var inProgress: Bool {
        get {
            return _inProgress
        }
        set(newValue) {
            _inProgress = newValue
            
            if (_inProgress) {
                if (self.progressView != nil) {
                    self.progressView?.dismiss(true)
                    self.progressView = nil
                } else {
                    self.progressView = MRProgressOverlayView.showOverlayAdded(to: self.view, animated: true)
                    self.progressView?.mode = .indeterminateSmall
                    self.progressView?.titleLabelText = NSLocalizedString("UI.Progress", comment: "")
                }
            } else {
                self.progressView?.dismiss(true)
                self.progressView = nil
            }
        }
    }

    // MARK: Variables
    private var _inProgress = false
    private var progressView : MRProgressOverlayView? = nil

    // MARK: Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var labelTitle: UILabel!
    
    // MARK: - Init/Deinit
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setupInterface()
        self.registerCollectionCell()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Methods
    func registerCollectionCell() {
        let cell = UINib(nibName: cellID, bundle: nil)
        self.collectionView?.register(cell, forCellWithReuseIdentifier: cellID)
    }
    
    // MARK: Load Movies
    func loadMovies(completion: (() -> ())? = nil) {
//        TMDBAPI.sharedInstance.performDiscover(page: page) { (DataResponse<Any>) in
//            code
//        }
    }
    
    // MARK: View Configuration
    func setupInterface() {
        self.title = isFavorites ?
            NSLocalizedString("UI.Home",        comment: "") :
            NSLocalizedString("UI.Favorites",   comment: "")
        self.labelTitle.text = self.title
    }
    
    // MARK: UICollectionViewDataSource
    @available(iOS 6.0, *)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataset.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
            as? MovieItemCollectionViewCell else {
                return MovieItemCollectionViewCell()
        }
        
        cell.setViewModel(movie: dataset[indexPath.row])
        
        return cell
    }


    // MARK: UICollectionViewDelegate
}

