//
//  MovieDetailViewController.swift
//  Kiddo Movie Guide
//
//  Created by Rogerio Hirooka on 8/14/17.
//  Copyright © 2017 Kiddo Labs. All rights reserved.
//

import Foundation
import RealmSwift
import AMSmoothAlert
import Font_Awesome_Swift

class MovieDetailViewController : UITableViewController {
    
    // MARK: - Private Constants
    let seguePurchase = "seguePurchase"

    // MARK: - Properties
    var dataItem : Movie?
    
    // MARK: Variables
    var isFavorite = false
    
    // MARK: Outlets
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelYear: UILabel!
    @IBOutlet weak var labelResolutions: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelFavorites: UILabel!
    
    @IBOutlet weak var segmentedResolutions: UISegmentedControl!
    
    @IBOutlet weak var buttonFavorite: UIButton!
    
    @IBOutlet weak var imagePoster: UIImageView!
    
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
        
        (UIApplication.shared.delegate as! AppDelegate).setStatusBarColor(backgroundColor: ThemeConstants.mainColor)
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.isToolbarHidden = false
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = ThemeConstants.mainColor
        self.setViewModel(movie: dataItem!)
        
        self.setupShare()
    }

    // MARK: - Methods
    
    // MARK: Render Movie Data
    func setViewModel(movie: Movie) {
        self.labelTitle.text = movie.title
        self.labelYear.text = String(describing: movie.year)
        self.labelDescription.text = movie.overview
        let imageFullURL = TMDBAPI.sharedInstance.imageBasePath + movie.posterPath
        let _ = self.imagePoster.setCQImage(imageFullURL, placeholder: MovieItemCollectionViewCell.nullImage)
        self.isFavorite = !Storage.realmInstance().objects(Movie.self).filter("id == \(movie.id)").isEmpty
        self.updatedFavorite()
        // Resolutions from the Available Versions
        let maxResVersion = movie.MOCK_getVersions(sourceApple: true).max{ a, b in a.resolution.rawValue < b.resolution.rawValue }
        let maxRes = maxResVersion?.resolution.rawValue
        
        self.segmentedResolutions.removeAllSegments()
        for index in 0...Int(maxRes!) {
            let resolutionLabel = NSLocalizedString("Resolution.\(index)", comment: "")
            self.segmentedResolutions.insertSegment(withTitle: resolutionLabel,
                                                    at: self.segmentedResolutions.numberOfSegments,
                                                    animated: false)
        }
    }
    

    
    // MARK: View Configuration
    private func setupInterface() {
        self.title = ""
        self.labelTitle.text = self.title
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self,
                                                          action:#selector(MovieDetailViewController.tapFavorite(_:)))
        labelFavorites.addGestureRecognizer(tapGestureRecognizer)

//        self.navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: NSLocalizedString("UI.Back", comment: ""),
//                                                                style: UIBarButtonItemStyle.plain,
//                                                                target: nil,
//                                                                action: nil)
    }
    
    private func setupShare() {
        let shareButton = UIBarButtonItem(title: "Share",
                                          style: .plain,
                                          target: self,
                                          action: #selector(MovieDetailViewController.tapShare))
        shareButton.setFAText(prefixText: "",
                              icon: FAType.FAShareAlt,
                              postfixText: " Share",
                              size: 18)
        self.navigationItem.rightBarButtonItem = shareButton
    }
    
    private func updatedFavorite() {
        self.labelFavorites.text = self.isFavorite ? "" : ""
    }
    
    private func setFavoriteEnabledState(state: Bool) {
        self.labelFavorites.isUserInteractionEnabled = state
        self.buttonFavorite.isEnabled = state
    }
    
    // MARK: Events
    func tapShare() {
        let activityViewController = UIActivityViewController(activityItems: ["Kiddo Movie Guide\nI'm watching \(String(describing: dataItem!.title))!"],
                                                              applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func tapFavorite(_ sender: Any) {
        self.setFavoriteEnabledState(state: false)
        try! Storage.realmInstance().write {
            if self.isFavorite {
                if let record = Storage.realmInstance().objects(Movie.self).filter("id == \(dataItem!.id)").first {
                    dataItem = dataItem?.createClone()
                    Storage.realmInstance().delete(record)
                    self.isFavorite = false
                } else {
                    let alert = AMSmoothAlertView(dropAlertWithTitle: NSLocalizedString("Exception.GenericTitle", comment: ""),
                                                  andText: NSLocalizedString("Exception.Favorite", comment: ""),
                                                  andCancelButton: true,
                                                  for: AlertType.success)
                    alert?.show()
                }
            } else {
                if (dataItem!.isInvalidated) {
                    dataItem = dataItem?.createClone()
                }
                Storage.realmInstance().add(dataItem!)
                self.isFavorite = true
            }
            self.updatedFavorite()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.setFavoriteEnabledState(state: true)
        }
    }
    
    @IBAction func tapPurchase(_ sender: Any) {
        self.performSegue(withIdentifier: "seguePurchase", sender: self.dataItem)
    }

    // MARK: Controller Flow
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == seguePurchase {
            guard let purchaseMovieVC = segue.destination as? PurchaseMovieViewController else {
                print("View Inconsistency")
                return
            }
            
            guard let movieItem = sender as? Movie else {
                return
            }
            
            purchaseMovieVC.dataItem = movieItem
        }
        
    }
    
    
}
