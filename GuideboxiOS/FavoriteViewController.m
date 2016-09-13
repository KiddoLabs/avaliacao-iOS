//
//  FavoriteViewController.m
//  GuideboxiOS
//
//  Created by Ezequiel Thomazetto on 08/09/16.
//  Copyright © 2016 Ezequiel Thomazetto. All rights reserved.
//

#import "FavoriteViewController.h"
#import "MovieCell.h"
#import "MovieListHeader.h"
#import "FavoriteMovieDetail.h"
#import "DetailViewController.h"

@interface FavoriteViewController () <UICollectionViewDelegateFlowLayout ,UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *favoriteMovieDetailList;
@property (nonatomic, strong)FavoriteMovieDetail *selectedFavoriteMovieDetail;

@end

@implementation FavoriteViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    UINib *movieCellNib = [UINib nibWithNibName:@"MovieCell" bundle: nil];
    [self.collectionView registerNib:movieCellNib forCellWithReuseIdentifier:@"MovieCell"];
    
    UINib *movieListHeaderNib = [UINib nibWithNibName:@"MovieListHeader" bundle: nil];
    [self.collectionView registerNib:movieListHeaderNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"movieListHeader"];
    
    self.favoriteMovieDetailList = [NSMutableArray new];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:YES];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    RLMResults<FavoriteMovieDetail *> *queryFavoriteMovieDetail = [FavoriteMovieDetail allObjects];
    
    [self.favoriteMovieDetailList removeAllObjects];
    
    for (RLMObject *object in queryFavoriteMovieDetail) {
        [self.favoriteMovieDetailList addObject:object];
    }
    
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionView

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [self.favoriteMovieDetailList count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MovieCell *cell = (MovieCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"MovieCell" forIndexPath:indexPath];
    
    FavoriteMovieDetail *movie = (FavoriteMovieDetail*)[self.favoriteMovieDetailList objectAtIndex:indexPath.row];
    
    [cell configCellWithFavouriteMovie:movie];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    self.selectedFavoriteMovieDetail = (FavoriteMovieDetail*)[self.favoriteMovieDetailList objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"favoriteToDetailSegue" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"favoriteToDetailSegue"]) {
        
        DetailViewController *detailViewController = (DetailViewController *)segue.destinationViewController;
        
        detailViewController.movieDetail = [MovieDetail new];
        detailViewController.movieDetail.movieID = self.selectedFavoriteMovieDetail.movieID;
        detailViewController.movieDetail.thumbnailURL = [NSURL URLWithString:self.selectedFavoriteMovieDetail.thumbnailURL];
        detailViewController.movieDetail.title = self.selectedFavoriteMovieDetail.title;
        detailViewController.movieDetail.releaseYear = self.selectedFavoriteMovieDetail.releaseYear;
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
