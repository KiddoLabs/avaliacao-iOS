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
//#import "UIImageView+AFNetworking.h"

//#import <SDWebImage/UIImageView+WebCache.h>

#import <PINImageView+PINRemoteImage.h>
#import <TSMessages/TSMessage.h>

@interface DetailViewController () <MovieServiceDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;
@property (weak, nonatomic) IBOutlet UILabel *movieTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseYearLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status == AFNetworkReachabilityStatusNotReachable) {
            [TSMessage showNotificationWithTitle:@"Sem conexão"
                                        subtitle:@"Verifique sua conexão com a internet"
                                            type:TSMessageNotificationTypeError];
        }
        
    }];
    
    MovieService *service = [[MovieService alloc]initWithTarget:self];
    
    [service getMovieDetailWithMovieID:self.movieDetail.movieID];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:NO];
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    [self updateScreenData];
    
}

-(BOOL)hidesBottomBarWhenPushed
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateScreenData{
    
//    [self.thumbnailImageView setImageWithURL:self.movieDetail.thumbnailURL];
//    [self.thumbnailImageView sd_setImageWithURL:self.movieDetail.thumbnailURL];
    
    [self.thumbnailImageView setPin_updateWithProgress:YES];
    
    [self.thumbnailImageView pin_setImageFromURL:self.movieDetail.thumbnailURL];
    
    [self.movieTitleLabel setText:self.movieDetail.title];
    [self.releaseYearLabel setText:[self.movieDetail.releaseYear stringValue]];
    [self.descriptionTextView setText:self.movieDetail.movieDescription];
    
}

#pragma mark - MovieServiceDelegate

-(void)responseSuccess:(id)response{
    
    if ([response isKindOfClass:[MovieDetail class]]) {
        NSLog(@"%@", response);
        //        self.movieList = response;
        
        //        [self.collectionView reloadData];
        
        MovieDetail *movieDetail = (MovieDetail*)response;
        
        self.movieDetail.movieDescription = movieDetail.movieDescription;
        self.movieDetail.purchaseSources = movieDetail.purchaseSources;
        
        [self updateScreenData];
    }
}

-(void)responseError:(NSError *)error{
    NSLog(@"%@", error);
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"detailToPurchase"]) {
        
        PurchaseViewController *purchaseViewController = (PurchaseViewController *)segue.destinationViewController;
        purchaseViewController.purchaseSources = self.movieDetail.purchaseSources;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
