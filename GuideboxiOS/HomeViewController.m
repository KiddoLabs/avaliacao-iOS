//
//  HomeViewController.m
//  GuideboxiOS
//
//  Created by Ezequiel Thomazetto on 08/09/16.
//  Copyright © 2016 Ezequiel Thomazetto. All rights reserved.
//

#import "HomeViewController.h"
#import "MovieCell.h"

#import "MovieService.h"

@interface HomeViewController () <UICollectionViewDataSource, UICollectionViewDelegate, MovieServiceDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) MovieList *movieList;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    UINib *nib = [UINib nibWithNibName:@"MovieCell" bundle: nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"MovieCell"];
//    nibMyCellloaded = YES;
    
    MovieService *service = [[MovieService alloc]initWithTarget:self];
    
    [service getMovieList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MovieServiceDelegate

-(void)responseSuccess:(id)response{
    NSLog(@"%@", response);
    
    if ([response isKindOfClass:[MovieList class]]) {
        
        self.movieList = response;
        
        [self.collectionView reloadData];
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
    
    [cell configCellWithMovie:[self.movieList.movies objectAtIndex:indexPath.row]];
    
//     *cell= (photoUploadCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"photoUploadCell" forIndexPath:indexPath];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self performSegueWithIdentifier:@"homeToDetailSegue" sender:self];
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
