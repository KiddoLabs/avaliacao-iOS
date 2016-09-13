//
//  DetailViewController.m
//  GuideboxiOS
//
//  Created by Ezequiel Thomazetto on 08/09/16.
//  Copyright © 2016 Ezequiel Thomazetto. All rights reserved.
//

#import "DetailViewController.h"
#import "MovieService.h"
#import "PurchaseViewController.h"
#import <PINImageView+PINRemoteImage.h>
#import <TSMessages/TSMessage.h>
#import <Realm/Realm.h>
#import "FavoriteMovieDetail.h"
#import "GBButton.h"
#import "GBAnimator.h"

@interface DetailViewController () <MovieServiceDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;
@property (weak, nonatomic) IBOutlet UILabel *movieTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseYearLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *firstFormatLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondFormatLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdFormatLabel;
@property (weak, nonatomic) IBOutlet GBButton *purchaseButton;
@property (weak, nonatomic) IBOutlet UIButton *addFavoriteButton;
@property (nonatomic, strong)FavoriteMovieDetail *favoriteMovieDetail;

@end

@implementation DetailViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.delegate = self;
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status == AFNetworkReachabilityStatusNotReachable) {
            [TSMessage showNotificationWithTitle:@"Sem conexão"
                                        subtitle:@"Verifique sua conexão com a internet"
                                            type:TSMessageNotificationTypeError];
        }
        
    }];
    
    MovieService *service = [[MovieService alloc]initWithTarget:self];
    
    [service getMovieDetailWithMovieID:self.movieDetail.movieID];
    
    RLMResults<FavoriteMovieDetail *> *queryFavoriteMovieDetail = [FavoriteMovieDetail objectsWhere:[NSString stringWithFormat:@"movieID == %@", [self.movieDetail.movieID stringValue]]];
    
    self.favoriteMovieDetail = [queryFavoriteMovieDetail firstObject];
    
    if (self.favoriteMovieDetail) {
        [self.addFavoriteButton setTitle:@"Remover dos favoritos" forState: UIControlStateNormal];
    }
    else{
        [self.addFavoriteButton setTitle:@"Add aos favoritos" forState: UIControlStateNormal];
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:NO];
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    [self updateScreenData];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    self.activityIndicator.center = self.view.center;

    [self.view addSubview:self.activityIndicator];
    
    if (self.movieDetail.movieDescription) {
        self.purchaseButton.enable = YES;
        [self.addFavoriteButton setEnabled:YES];
    }
    else{
        self.purchaseButton.enable = NO;
        [self.addFavoriteButton setEnabled:NO];
        [self.activityIndicator startAnimating];
    }
    
    [self.purchaseButton setNeedsLayout];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)hidesBottomBarWhenPushed
{
    return YES;
}

#pragma mark - UINavigationControllerDelegate

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    return [[GBAnimator alloc] init];
}

-(void)updateScreenData{
    
    [self.thumbnailImageView setPin_updateWithProgress:YES];
    [self.thumbnailImageView pin_setImageFromURL:self.movieDetail.thumbnailURL];
    
    [self.movieTitleLabel setText:self.movieDetail.title];
    [self.releaseYearLabel setText:[self.movieDetail.releaseYear stringValue]];
    [self.descriptionTextView setText:self.movieDetail.movieDescription];
    
    
    CATransition *animation = [CATransition animation];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionReveal;
    animation.duration = 0.75;
    
    [self.firstFormatLabel.layer addAnimation:animation forKey:@"kCATransitionFade"];
    [self.secondFormatLabel.layer addAnimation:animation forKey:@"kCATransitionFade"];
    [self.thirdFormatLabel.layer addAnimation:animation forKey:@"kCATransitionFade"];
    
    NSArray *formats = [self.movieDetail getAllFormats];
    
    if ([formats count] >= 1) {
        [self.firstFormatLabel setText:[(Format*)[formats objectAtIndex:0] formatName]];
    }
    
    if ([formats count] >= 2) {
        [self.secondFormatLabel setText:[(Format*)[formats objectAtIndex:1] formatName]];
    }
    
    if ([formats count] >= 3) {
        [self.thirdFormatLabel setText:[(Format*)[formats objectAtIndex:2] formatName]];
    }

}

- (IBAction)addFavorites:(id)sender {
    
    if (self.favoriteMovieDetail) {
        [self removeFromFavorites];
    }
    else{
        [self addFavorite];
    }
    
}

-(void)addFavorite{
    
    self.favoriteMovieDetail = [FavoriteMovieDetail new];
    self.favoriteMovieDetail.movieID = self.movieDetail.movieID;
    self.favoriteMovieDetail.thumbnailURL = [self.movieDetail.thumbnailURL absoluteString];
    self.favoriteMovieDetail.title = self.movieDetail.title;
    self.favoriteMovieDetail.releaseYear = self.movieDetail.releaseYear;
    self.favoriteMovieDetail.movieDescription = self.movieDetail.movieDescription;
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm beginWriteTransaction];
    [realm addObject:self.favoriteMovieDetail];
    
    NSError *error = nil;
    
    [realm commitWriteTransaction:&error];
    
    if (!error) {
        [self.addFavoriteButton setTitle:@"Remover dos favoritos" forState: UIControlStateNormal];
    }
    
}

-(void)removeFromFavorites{
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    NSError *error = nil;
    
    [realm beginWriteTransaction];
    [realm deleteObject:self.favoriteMovieDetail];
    [realm commitWriteTransaction:&error];
    
    if (!error) {
        self.favoriteMovieDetail = nil;
        [self.addFavoriteButton setTitle:@"Add aos favoritos" forState: UIControlStateNormal];
    }
}

#pragma mark - MovieServiceDelegate

-(void)responseSuccess:(id)response{
    
    if ([response isKindOfClass:[MovieDetail class]]) {
        
        MovieDetail *movieDetail = (MovieDetail*)response;
        self.movieDetail.movieDescription = movieDetail.movieDescription;
        self.movieDetail.purchaseSources = movieDetail.purchaseSources;
        
        [self updateScreenData];
        [self.activityIndicator stopAnimating];
        self.purchaseButton.enable = YES;
        [self.addFavoriteButton setEnabled:YES];
        [self.purchaseButton setNeedsLayout];
    }
}

-(void)responseError:(NSError *)error{
    
    [TSMessage showNotificationWithTitle:error.localizedDescription
                                subtitle:error.localizedFailureReason
                                    type:TSMessageNotificationTypeError];
    
    [self.activityIndicator stopAnimating];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"detailToPurchase"]) {
        
        PurchaseViewController *purchaseViewController = (PurchaseViewController *)segue.destinationViewController;
        
        purchaseViewController.purchaseSources = self.movieDetail.purchaseSources;
        purchaseViewController.thumbnailURL = self.movieDetail.thumbnailURL;
    }
}

@end
