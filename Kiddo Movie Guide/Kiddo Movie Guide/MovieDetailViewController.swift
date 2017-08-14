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

class MovieDetailViewController : UITableViewController {
    
    // MARK: - Private Constants
    
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
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.isToolbarHidden = false

        self.setViewModel(movie: dataItem!)
    }

    // MARK: - Methods
    
    // MARK: Render Movie Data
    func setViewModel(movie: Movie) {
        self.labelTitle.text = movie.title
        self.labelYear.text = String(describing: movie.year)
        let imageFullURL = TMDBAPI.sharedInstance.imageBasePath + movie.posterPath
        let _ = self.imagePoster.setCQImage(imageFullURL, placeholder: MovieItemCollectionViewCell.nullImage)

    }
    

    
    // MARK: View Configuration
    private func setupInterface() {
        self.title = ""
        self.labelTitle.text = self.title
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(MovieDetailViewController.tapFavorite(_:)))
        labelFavorites.addGestureRecognizer(tapGestureRecognizer)

        self.navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: NSLocalizedString("UI.Back", comment: ""),
                                                                style: UIBarButtonItemStyle.plain,
                                                                target: nil,
                                                                action: nil)
    }
    
    private func updatedFavorite() {
        self.labelFavorites.text = self.isFavorite ? "" : ""
    }
    
    // MARK: Events
    @IBAction func tapFavorite(_ sender: Any) {
        try! Storage.realmInstance().write {
            if self.isFavorite {
                if let record = Storage.realmInstance().objects(Movie.self).filter("id == \(dataItem!.id)").first {
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
                Storage.realmInstance().add(dataItem!)
                self.isFavorite = true
            }
            
            self.updatedFavorite()
        }

    }
    
    @IBAction func tapPurchase(_ sender: Any) {
    }

}
