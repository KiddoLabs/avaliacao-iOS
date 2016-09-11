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

@interface HomeViewController () <UICollectionViewDelegateFlowLayout ,UICollectionViewDataSource, UICollectionViewDelegate, MovieServiceDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) MovieList *movieList;

@property (nonatomic, strong) Movie *selectedMovie;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    UINib *movieCellNib = [UINib nibWithNibName:@"MovieCell" bundle: nil];
    [self.collectionView registerNib:movieCellNib forCellWithReuseIdentifier:@"MovieCell"];
    
    UINib *movieListHeaderNib = [UINib nibWithNibName:@"MovieListHeader" bundle: nil];
    [self.collectionView registerNib:movieListHeaderNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"movieListHeader"];
    
    //forCellWithReuseIdentifier:@"movieListHeader"];
    
//    nibMyCellloaded = YES;
    
    MovieService *service = [[MovieService alloc]initWithTarget:self];
    
    [service getMovieListWithStart:0 size:20];
    
    self.movieList = [MovieList new];
    self.movieList.movies = [NSMutableArray new];
    
//    self.collectionView.alwaysBounceVertical = YES;
    
    __weak HomeViewController *weakSelf = self;
    
//    // setup pull-to-refresh
//    [self.collectionView addPullToRefreshWithActionHandler:^{
//        [weakSelf insertRowAtTop];
//    }];
    
    // setup infinite scrolling
    [self.collectionView addInfiniteScrollingWithActionHandler:^{
        [weakSelf insertRowAtBottom];
    }];
    

}

//- (void)insertRowAtTop {
//    __weak HomeViewController *weakSelf = self;
//    
//    int64_t delayInSeconds = 2.0;
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        
////        [weakSelf.collectionView beginUpdates];
////        [weakSelf.dataSource insertObject:[NSDate date] atIndex:0];
////        [weakSelf.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
////        [weakSelf.tableView endUpdates];
//        
//        [weakSelf.collectionView.pullToRefreshView stopAnimating];
//    });
//}


- (void)insertRowAtBottom {
//    __weak HomeViewController *weakSelf = self;
    
    //invocar servico pedindo os proximos itens
    
    MovieService *service = [[MovieService alloc]initWithTarget:self];
    
    [service getMovieListWithStart:[self.movieList.movies count] size:20];
    
//    
//    int64_t delayInSeconds = 2.0;
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    
//        [weakSelf.collectionView beginUpdates];
//        weakSelf.collectionView insertItemsAtIndexPaths:<#(nonnull NSArray<NSIndexPath *> *)#>
        
//        [weakSelf.dataSource addObject:[weakSelf.dataSource.lastObject dateByAddingTimeInterval:-90]];
//        [weakSelf.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:weakSelf.dataSource.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
//        [weakSelf.tableView endUpdates];
        
//        [weakSelf.collectionView.infiniteScrollingView stopAnimating];
//    });
    
    
//    [self.collectionView performBatchUpdates:^{
//        
//        int resultsSize = [self.results count];
//        
//        [self.results addObjectsFromArray:newData];
//        
//        NSMutableArray *arrayWithIndexPaths = [NSMutableArray array];
//        
//        for (int i = resultsSize; i < resultsSize + newData.count; i++) {
//            [arrayWithIndexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
//        }
//        
//        [self.collectionView insertItemsAtIndexPaths:arrayWithIndexPaths];
//        
//        
//    } completion:^(BOOL finished) {
//        
//        [self.collectionView.infiniteScrollingView stopAnimating];
//    }];
    
//    [self.collectionView performBatchUpdates:^{
//        
//        int resultsSize = [self.results count];
//        
//        [self.results addObjectsFromArray:newData];
//        
//        NSMutableArray *arrayWithIndexPaths = [NSMutableArray array];
//        
//        for (int i = resultsSize; i < resultsSize + newData.count; i++) {
//            [arrayWithIndexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
//        }
//        
//        [self.collectionView insertItemsAtIndexPaths:arrayWithIndexPaths];
//    }
//                                  completion:nil];
//    
//    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateData:(MovieList*)movieList{
    
    [self.collectionView performBatchUpdates:^{
        
//        int resultsSize = [self.results count];
        NSInteger resultsSize = [self.movieList.movies count];
        
//        [self.results addObjectsFromArray:newData];
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
    NSLog(@"%@", response);
    
    if ([response isKindOfClass:[MovieList class]]) {
        
//        self.movieList = response;
        
        [self updateData:response];
//        [self.collectionView reloadData];
    }
}

-(void)responseError:(NSError *)error{
    NSLog(@"%@", error);
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [self.movieList.movies count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FilmCell" forIndexPath:indexPath];
    
    MovieCell *cell = (MovieCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"MovieCell" forIndexPath:indexPath];
    
    Movie *movie = (Movie*)[self.movieList.movies objectAtIndex:indexPath.row];
    
    [cell configCellWithMovie:movie];
    
//     *cell= (photoUploadCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"photoUploadCell" forIndexPath:indexPath];
    
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
    
//    if (kind == UICollectionElementKindSectionHeader) {
    
        MovieListHeader *movieListHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"movieListHeader" forIndexPath:indexPath];
        
//        NSString *title = [[NSString alloc]initWithFormat:@"Recipe Group #%i", indexPath.section + 1];
//        headerView.title.text = title;
//        UIImage *headerImage = [UIImage imageNamed:@"header_banner.png"];
//        headerView.backgroundImage.image = headerImage;
        
        
//    }
    return movieListHeader;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    int numberOfCellInRow = 3;
    CGFloat cellWidth =  ([[UIScreen mainScreen] bounds].size.width -20)/numberOfCellInRow;
    
    CGFloat one = 120.0f - cellWidth;
    
    CGFloat two = 120.0f * 100;
    
    CGFloat three = one / two;
    
    CGFloat four = three * 100;//=percent
    
    CGFloat five = 237.0f * four;
    
    CGFloat cellHeight = 237.0f - five;
    
    return CGSizeMake(cellWidth,cellHeight);
    
    //
//    float cellWidth = (self.view.frame.size.width / 3) - 20;
//    float cellHeight = cellWidth * 190.0f / 270.0f;
//    return CGSizeMake(cellWidth, cellHeight);
    
//    //120x237
//    
//    int numberOfCellInRow = 3;
//    CGFloat cellWidth =  ([[UIScreen mainScreen] bounds].size.width -20)/numberOfCellInRow;
//    
//    CGFloat percent = ((120 - cellWidth)/120*100);
//    
//    CGFloat cellHeight = 237 * percent;
//    
//    return CGSizeMake(cellWidth,cellHeight);
    
    
//#define kCellsPerRow 3
//    
//    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
//    
//    CGFloat availableWidthForCells = CGRectGetWidth(self.collectionView.frame) - flowLayout.sectionInset.left - flowLayout.sectionInset.right - flowLayout.minimumInteritemSpacing * (kCellsPerRow - 1);
//    
//    CGFloat cellWidth = availableWidthForCells / kCellsPerRow;
//    flowLayout.itemSize = CGSizeMake(cellWidth, flowLayout.itemSize.height);
//    
//    return flowLayout.itemSize;
    
    
//    return CGSizeMake((UIScreen.mainScreen().bounds.width-15)/4,120); //use height whatever you wants.
}


//-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//    
//}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1.0f;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsMake(top, left, bottom, right);
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
