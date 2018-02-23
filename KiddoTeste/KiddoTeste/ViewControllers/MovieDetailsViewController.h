//
//  MovieDetailsViewController.h
//  KiddoTeste
//
//  Created by Aloisio Mello on 21/02/18.
//  Copyright © 2018 Aloisio Mello. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PINRemoteImage/PINImageView+PINRemoteImage.h>
#import "BuyMovieViewController.h"
#import "FavoritesDatabase.h"
#import "MovieData.h"

@protocol MovieDetailsViewControllerDelegate <NSObject>
@optional

-(void)reloadData;

@end

@interface MovieDetailsViewController : UIViewController

@property(nonatomic, weak) IBOutlet UIImageView * posterImage;
@property(nonatomic, weak) IBOutlet UILabel     * movieTitleLabel;
@property(nonatomic, weak) IBOutlet UILabel     * yearLabel;
@property(nonatomic, weak) IBOutlet UILabel     * movieQualityLabel;
@property(nonatomic, weak) IBOutlet UIButton    * favoriteButton;
@property(nonatomic, weak) IBOutlet UILabel     * fullHDLabel;
@property(nonatomic, weak) IBOutlet UILabel     * HDLabel;
@property(nonatomic, weak) IBOutlet UILabel     * SDLabel;
@property(nonatomic, weak) IBOutlet UILabel     * movieDescriptionLabel;
@property(nonatomic, weak) IBOutlet UIButton    * buyButton;

@property(nonatomic) id<MovieDetailsViewControllerDelegate> delegate;

@property(nonatomic, strong) MovieData * movieData;

-(IBAction)buyMovie:(id)sender;
-(IBAction)addToFavorites:(id)sender;
@end
