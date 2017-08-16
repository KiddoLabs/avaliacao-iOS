//
//  FirstViewController.swift
//  Kiddo Movie Guide
//
//  Created by Rogerio Hirooka on 8/10/17.
//  Copyright © 2017 Kiddo Labs. All rights reserved.
//

import UIKit
import MRProgress
import AMSmoothAlert

class MovieListViewController:
    UIViewController,
    UICollectionViewDataSource,
    UICollectionViewDelegate {
    
    // MARK: - Private Constants
    let cellID = "MovieItemCell"
    let segueDetail = "segueDetail"
    
    // MARK: - Properties
    var isFavorites = false
    var isReachedEnd = false
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
    
    @IBOutlet weak var viewNoFavoritesSaved: UIView!
    
    
    // MARK: - Init/Deinit
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        (UIApplication.shared.delegate as! AppDelegate).setStatusBarColor(backgroundColor: ThemeConstants.mainColor)

        self.setupInterface()
        self.registerCollectionCell()
        self.reloadAll(sender: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Methods
    private func registerCollectionCell() {
        let cell = UINib(nibName: cellID, bundle: nil)
        self.collectionView?.register(cell, forCellWithReuseIdentifier: cellID)
    }
    
    // MARK: Events
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.isToolbarHidden = true
        
        if (self.isFavorites) {
            self.reloadAll(sender: nil)
        } else {
            self.viewNoFavoritesSaved.isHidden = true
        }
    }
    
    // MARK: Load Movies
    func loadMovies(completionHandler: (() -> ())? = nil) {
        if self.isFavorites {
            let result = Storage.realmInstance().objects(Movie.self)
            self.dataset = Array(result)
            self.collectionView.reloadData()
            
            self.viewNoFavoritesSaved.isHidden = (self.dataset.count > 0)
        } else {
            TMDBAPI.sharedInstance.performDiscover(page: page) { (movies, error) in
                if error == nil && movies != nil {
                    if (movies?.count)! > 0 {
                        
                        self.dataset.append(contentsOf: movies!)
                        self.collectionView.reloadData()
                    } else {
                        self.isReachedEnd = true
                    }
                } else {
//                    let err = error
                    let alert = AMSmoothAlertView(dropAlertWithTitle: NSLocalizedString("Exception.GenericTitle", comment: ""),
                                                  andText: NSLocalizedString("Exception.Loading", comment: ""),
                                                  andCancelButton: true,
                                                  for: AlertType.failure)
                    alert?.show()
                }
                completionHandler?()
            }
        }
    }
    
    func reloadAll(sender: UIRefreshControl?) {
        dataset = [Movie]()
        isReachedEnd = false
        page = 1
        
        loadMovies {
            sender?.endRefreshing()
            self.viewNoFavoritesSaved.isHidden = (self.dataset.count > 0)
        }
        
    }
    
    // MARK: View Configuration
    private func setupInterface() {
        self.title = isFavorites ?
            NSLocalizedString("UI.Favorites",   comment: "") :
            NSLocalizedString("UI.Home",        comment: "")
        self.labelTitle.text = self.title
        self.viewNoFavoritesSaved.isHidden = false

    }
    
    // MARK: UIRefreshControl
    private func setupUIRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(MovieListViewController.reloadAll(sender:)), for: .valueChanged)
        self.collectionView?.addSubview(refreshControl)
    }

    
    // MARK: UICollectionViewDataSource
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
        
        cell.clearContent()
        cell.setViewModel(movie: dataset[indexPath.row])
        
        return cell
    }


    // MARK: UICollectionViewDelegate
    /**
        Whenever attempting to render the last line of cells, try to prefetch a new page from the server
    */
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !self.isFavorites && indexPath.row == dataset.count - 3 {
            if (!self.isReachedEnd) {
                page += 1
                loadMovies()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let movie = dataset[indexPath.row]
        self.performSegue(withIdentifier: segueDetail , sender: movie)
        
    }
    
    // MARK: Controller Flow
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == segueDetail {
            guard let movieDetailVC = segue.destination as? MovieDetailViewController else {
                print("View Inconsistency")
                return
            }
            
            guard let movieItem = sender as? Movie else {
                return
            }
            
            movieDetailVC.dataItem = movieItem
        }
        
    }

}

