//
//  MovieDetailsViewController.m
//  KiddoTeste
//
//  Created by Aloisio Mello on 21/02/18.
//  Copyright © 2018 Aloisio Mello. All rights reserved.
//

#import "MovieDetailsViewController.h"

@interface MovieDetailsViewController ()

@end

@implementation MovieDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureNavigationBar];
    [self configureViewItems];
}

#pragma mark view controller apearance configuration
-(void)configureNavigationBar{
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 80, 32);
    backButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [backButton setImage:[UIImage imageNamed:@"btn-back"] forState:UIControlStateNormal];
    [backButton setTitle:@"Voltar" forState:UIControlStateNormal];
    [backButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Regular" size:18]];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [backButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft]; //Align button content to horizontal left
    [backButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)]; // Set space between label and image
    
    [backButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * barBackButton = [[UIBarButtonItem alloc] init];
    barBackButton.customView = backButton;
    self.navigationItem.leftBarButtonItem = barBackButton;
    //////
    UIButton * shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(0, 0, 80, 32);
    shareButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [shareButton setImage:[UIImage imageNamed:@"btn-share"] forState:UIControlStateNormal];
    [shareButton setTitle:@"Share" forState:UIControlStateNormal];
    [shareButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Regular" size:18]];
    [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [shareButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft]; //Align button content to horizontal left
    [shareButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)]; // Set space between label and image
    
    [shareButton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * barShareButton = [[UIBarButtonItem alloc] init];
    barShareButton.customView = shareButton;
    self.navigationItem.rightBarButtonItem = barShareButton;
}

-(void)configureViewItems{
    _movieTitleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18];
    _yearLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    _movieQualityLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    _favoriteButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
    _movieDescriptionLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
    _buyButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:15];
    [_favoriteButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)]; // Set space between label and image
    [_posterImage pin_setImageFromURL: [NSURL URLWithString:_movieData.poster_path]];
    _movieDescriptionLabel.text = _movieData.overview;
    _movieTitleLabel.text = _movieData.original_title;
    _yearLabel.text = _movieData.year;
    [_movieDescriptionLabel sizeToFit];
    
    //Verify if this movie is Favorited
    FavoritesDatabase * favDatabase = [[FavoritesDatabase alloc] init];
    
    if([favDatabase getMovieWithMovieId:_movieData.movieID])
        [_favoriteButton setTitle:@"Remover dos favoritos" forState:UIControlStateNormal];
    else
        [_favoriteButton setTitle:@"Add aos favoritos" forState:UIControlStateNormal];
    
    //We don't have the movie quality information, let's set FULL HD when the movie are after 2015, HD after 2005, SD are default
    int year = [_movieData.year intValue];
    if(year > 2015)
        _fullHDLabel.enabled = YES;
    if(year > 2005)
        _HDLabel.enabled = YES;
    
    _SDLabel.enabled = YES;
}

#pragma mark Movie Details events
-(IBAction)addToFavorites:(id)sender{
    if([_favoriteButton.titleLabel.text isEqualToString:@"Add aos favoritos"]){
        FavoritesDatabase * favDatabase = [[FavoritesDatabase alloc] init];
        if([favDatabase saveMovieWithMovieData:_movieData])
            [_favoriteButton setTitle:@"Remover dos favoritos" forState:UIControlStateNormal];
    }else{
        FavoritesDatabase * favDatabase = [[FavoritesDatabase alloc] init];
        [favDatabase removeMovieWithMovieId:_movieData.movieID];
        [_favoriteButton setTitle:@"Add aos favoritos" forState:UIControlStateNormal];
    }
}

-(IBAction)buyMovie:(id)sender{
    [self performSegueWithIdentifier:@"buyMovieSegue" sender:self];
}

#pragma mark navigation controller events
-(IBAction)goBack:(id)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        if([_delegate respondsToSelector:@selector(reloadData)])
            [_delegate reloadData];
    }];
}

-(IBAction)share:(id)sender{
    NSString *textToShare = [NSString stringWithFormat:@"Assista o filme %@! - %@\n%@",self.movieData.original_title,self.movieData.year,self.movieData.overview];
    
    NSArray *objectsToShare = @[textToShare];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    NSArray *excludeActivities = @[UIActivityTypeAirDrop,
                                   UIActivityTypePrint,
                                   UIActivityTypeAssignToContact,
                                   UIActivityTypeSaveToCameraRoll,
                                   UIActivityTypeAddToReadingList,
                                   UIActivityTypePostToFlickr,
                                   UIActivityTypePostToVimeo];
    
    activityVC.excludedActivityTypes = excludeActivities;
    
    [self presentViewController:activityVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"buyMovieSegue"]){
        BuyMovieViewController * buyViewController = (BuyMovieViewController*)segue.destinationViewController;
        [buyViewController setMovieData:_movieData];
    }
}

@end
