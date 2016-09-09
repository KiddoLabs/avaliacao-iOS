//
//  MovieService.m
//  GuideboxiOS
//
//  Created by Ezequiel Thomazetto on 08/09/16.
//  Copyright © 2016 Ezequiel Thomazetto. All rights reserved.
//

#import "MovieService.h"
#import <AFNetworking/AFNetworking.h>

@interface MovieService ()

@property (nonatomic, strong) id<MovieServiceDelegate> delegate;

@end

@implementation MovieService

-(instancetype)initWithTarget:(id<MovieServiceDelegate>)target{
    
    self = [super init];
    if (self) {
        
        self.delegate = target;

    }
    return self;
}

-(void)getMovieList{
    
    NSURL *url = [NSURL URLWithString:@"https://api-public.guidebox.com/v1.43"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithBaseURL:url];
    
    [manager GET:@"US/rKJwmLEQB3qOouvHckEwjDrsGqKWpHgE/movies/all/1/10/all/all" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@", responseObject);
        
        [self.delegate responseSuccess:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self.delegate responseError:error];
        NSLog(@"%@", error);
    }];
    
}
@end
