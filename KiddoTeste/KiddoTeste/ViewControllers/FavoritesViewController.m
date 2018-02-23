//
//  FavoritesViewController.m
//  KiddoTeste
//
//  Created by Aloisio Mello on 22/02/18.
//  Copyright © 2018 Aloisio Mello. All rights reserved.
//

#import "FavoritesViewController.h"

@interface FavoritesViewController ()

@end

@implementation FavoritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _collectionView.initialCellTransformBlock = ADLivelyTransformFan;
    // Do any additional setup after loading the view.
}

-(void)reloadData{
    FavoritesDatabase * favDatabase = [[FavoritesDatabase alloc] init];
    _movieDatasource = [favDatabase getAllMovies];
    [_collectionView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_movieDatasource count];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MovieListCollectionViewCell *movieInformationCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellMovie" forIndexPath:indexPath];
    
    [movieInformationCell configCell];
    MovieData * mData = (MovieData*)[_movieDatasource objectAtIndex:indexPath.row];
    [movieInformationCell.imageMovieCover pin_setImageFromURL: [NSURL URLWithString:mData.poster_path]];
    [movieInformationCell.labelMovieName setText:mData.original_title];
    [movieInformationCell setAccessibilityLabel:mData.original_title]; //To be readed by KIF test and be possible to users who needs aceessibility
    [movieInformationCell.labelMovieReleaseYear setText:mData.year];
    return movieInformationCell;
}

-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView * homeReusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        CurrentTitleViewCollectionReusableView * headerView =
        [ collectionView dequeueReusableSupplementaryViewOfKind : UICollectionElementKindSectionHeader withReuseIdentifier : @ "sectionTitle" forIndexPath : indexPath ] ;
        
        [headerView configCell];
        homeReusableView = headerView;
        
    }
    
    return homeReusableView;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MovieDetailNavigationController * navigationController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"MovieDetailNavigationController"];
    
    
    MovieDetailsViewController *movieDetailsViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"movieDetailsViewID"];
    [movieDetailsViewController setDelegate:self];
    [movieDetailsViewController setMovieData:(MovieData*)[_movieDatasource objectAtIndex:indexPath.row]];
    [movieDetailsViewController setCc_swipeBackDisabled:NO];
    [navigationController pushViewController:movieDetailsViewController animated:YES];
    
    MovieListCollectionViewCell * cell = (MovieListCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    [navigationController cc_setZoomTransitionWithOriginalView:cell.imageMovieCover];
    
    [self presentViewController:navigationController animated:YES completion:nil];
    
    return true;
}

-(void)viewWillAppear:(BOOL)animated{
    [self reloadData];
}
@end
