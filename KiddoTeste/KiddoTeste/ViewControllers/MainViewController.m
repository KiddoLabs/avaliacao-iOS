//
//  MainViewController.m
//  KiddoTeste
//
//  Created by Aloisio Mello on 19/02/18.
//  Copyright © 2018 Aloisio Mello. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIRefreshControl *topRefreshControl = [UIRefreshControl new];
    topRefreshControl.triggerVerticalOffset = 100.0;
    [topRefreshControl addTarget:self action:@selector(refreshTop:) forControlEvents:UIControlEventValueChanged];
    self.collectionView.refreshControl = topRefreshControl;
    
    UIRefreshControl *bottomRefreshControl = [UIRefreshControl new];
    bottomRefreshControl.triggerVerticalOffset = 100.0;
    [bottomRefreshControl addTarget:self action:@selector(refreshBottom:) forControlEvents:UIControlEventValueChanged];
    self.collectionView.bottomRefreshControl = bottomRefreshControl;
    
    _collectionView.initialCellTransformBlock = ADLivelyTransformFan;
    // Do any additional setup after loading the view.
    _movieDatasource = [[NSMutableArray alloc] initWithCapacity:0];
    _currentPage = 1;
    [ApiManager getMoviesFromPage:_currentPage withCallback:^(id successCallback, id faillureCallback) {
        if(successCallback){
            for(NSDictionary * dict in successCallback){
                MovieData * mData = [[MovieData alloc] initWithDictionary:dict];
                [_movieDatasource addObject:mData];
            }
            [_collectionView reloadData];
        }else{
            NSString * errorMsg = (NSString*)faillureCallback;
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Erro ao carregar os filmes" message:errorMsg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}

-(IBAction)refreshTop:(UIRefreshControl *)refreshControl {
    // Do refresh stuff here
    _currentPage = 1;
    [_movieDatasource removeAllObjects];
    [ApiManager getMoviesFromPage:_currentPage withCallback:^(id successCallback, id faillureCallback) {
        if(successCallback){
            for(NSDictionary * dict in successCallback){
                MovieData * mData = [[MovieData alloc] initWithDictionary:dict];
                [_movieDatasource addObject:mData];
            }
            [_collectionView reloadData];
        }
    }];
    [refreshControl endRefreshing];
}

-(IBAction)refreshBottom:(UIRefreshControl *)refreshControl {
    // Do refresh stuff here
    _currentPage++;
    [ApiManager getMoviesFromPage:_currentPage withCallback:^(id successCallback, id faillureCallback) {
        if(successCallback){
            for(NSDictionary * dict in successCallback){
                MovieData * mData = [[MovieData alloc] initWithDictionary:dict];
                [_movieDatasource addObject:mData];
            }
            [_collectionView reloadData];
        }
    }];
    [refreshControl endRefreshing];
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
        CurrentTitleViewCollectionReusableView * headerView = [ collectionView dequeueReusableSupplementaryViewOfKind : UICollectionElementKindSectionHeader withReuseIdentifier : @ "sectionTitle" forIndexPath : indexPath ] ;
        
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
