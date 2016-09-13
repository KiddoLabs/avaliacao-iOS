//
//  HomeViewController.m
//  GuideboxiOS
//
//  Created by Ezequiel Thomazetto on 08/09/16.
//  Copyright © 2016 Ezequiel Thomazetto. All rights reserved.
//

#import "HomeViewController.h"
#import "MovieCell.h"
#import "MovieListHeader.h"
#import "MovieService.h"
#import "DetailViewController.h"
#import "SVPullToRefresh.h"
#import <TSMessages/TSMessage.h>

@interface HomeViewController () <UICollectionViewDelegateFlowLayout ,UICollectionViewDataSource, UICollectionViewDelegate, MovieServiceDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) MovieList *movieList;
@property (nonatomic, strong) Movie *selectedMovie;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation HomeViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status == AFNetworkReachabilityStatusNotReachable) {
            [TSMessage showNotificationWithTitle:@"Sem conexão"
                                        subtitle:@"Verifique sua conexão com a internet"
                                            type:TSMessageNotificationTypeError];
        }
        
    }];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    UINib *movieCellNib = [UINib nibWithNibName:@"MovieCell" bundle: nil];
    [self.collectionView registerNib:movieCellNib forCellWithReuseIdentifier:@"MovieCell"];
    
    UINib *movieListHeaderNib = [UINib nibWithNibName:@"MovieListHeader" bundle: nil];
    [self.collectionView registerNib:movieListHeaderNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"movieListHeader"];
    
    MovieService *service = [[MovieService alloc]initWithTarget:self];
    [service getMovieListWithStart:0 size:20];
    
    self.movieList = [MovieList new];
    self.movieList.movies = [NSMutableArray new];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.collectionView setBackgroundView:self.activityIndicator];
    [self.activityIndicator startAnimating];
    
    [self.collectionView addInfiniteScrollingWithActionHandler:^{
        [self insertRowAtBottom];
    }];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:YES];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertRowAtBottom {
    
    MovieService *service = [[MovieService alloc]initWithTarget:self];
    [service getMovieListWithStart:[self.movieList.movies count] size:20];
}

-(void)updateData:(MovieList*)movieList{
    
    [self.collectionView performBatchUpdates:^{
        
        NSInteger resultsSize = [self.movieList.movies count];
        
        [self.movieList.movies addObjectsFromArray:movieList.movies];
        
        NSMutableArray *arrayWithIndexPaths = [NSMutableArray array];
        
        for (int i = (int)resultsSize; i < resultsSize + movieList.movies.count; i++) {
            
            [arrayWithIndexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        }
        
        [self.collectionView insertItemsAtIndexPaths:arrayWithIndexPaths];
        
    } completion:^(BOOL finished) {
        
        [self.collectionView.infiniteScrollingView stopAnimating];
    }];
}

#pragma mark - MovieServiceDelegate

-(void)responseSuccess:(id)response{
    
    if ([response isKindOfClass:[MovieList class]]) {
        
        [self updateData:response];
        [self.activityIndicator stopAnimating];
    }
}

-(void)responseError:(NSError *)error{
    
    [TSMessage showNotificationWithTitle:error.localizedDescription
                                subtitle:error.localizedFailureReason
                                    type:TSMessageNotificationTypeError];
    
    [self.activityIndicator stopAnimating];
}

#pragma mark - UICollectionView

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [self.movieList.movies count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MovieCell *cell = (MovieCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"MovieCell" forIndexPath:indexPath];
    
    Movie *movie = (Movie*)[self.movieList.movies objectAtIndex:indexPath.row];
    
    [cell configCellWithMovie:movie];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    self.selectedMovie = (Movie*)[self.movieList.movies objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"homeToDetailSegue" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"homeToDetailSegue"]) {
        
        DetailViewController *detailViewController = (DetailViewController *)segue.destinationViewController;
        
        detailViewController.movieDetail = [MovieDetail new];
        detailViewController.movieDetail.movieID = self.selectedMovie.movieID;
        detailViewController.movieDetail.thumbnailURL = self.selectedMovie.thumbnailURL;
        detailViewController.movieDetail.title = self.selectedMovie.title;
        detailViewController.movieDetail.releaseYear = self.selectedMovie.releaseYear;
    }
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    MovieListHeader *movieListHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"movieListHeader" forIndexPath:indexPath];
    
    return movieListHeader;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    int numberOfCellInRow = 3;
    CGFloat cellWidth =  ([[UIScreen mainScreen] bounds].size.width -20)/numberOfCellInRow;

    CGFloat cellHeight = 237.0f - (237.0f * (((120.0f - cellWidth) / (120.0f * 100)) * 100));
    
    return CGSizeMake(cellWidth,cellHeight);

}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1.0f;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

@end
