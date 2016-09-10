//
//  DetailViewController.m
//  GuideboxiOS
//
//  Created by Ezequiel Thomazetto on 08/09/16.
//  Copyright © 2016 Ezequiel Thomazetto. All rights reserved.
//

#import "DetailViewController.h"
#import "MovieService.h"

@interface DetailViewController () <MovieServiceDelegate>

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MovieService *service = [[MovieService alloc]initWithTarget:self];
    
    [service getMovieDetailWithMovieID:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MovieServiceDelegate

-(void)responseSuccess:(id)response{
    
    if ([response isKindOfClass:[MovieDetail class]]) {
        NSLog(@"%@", response);
        //        self.movieList = response;
        
        //        [self.collectionView reloadData];
    }
}

-(void)responseError:(NSError *)error{
    NSLog(@"%@", error);
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
