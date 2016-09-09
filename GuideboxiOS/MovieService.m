//
//  MovieService.m
//  GuideboxiOS
//
//  Created by Ezequiel Thomazetto on 08/09/16.
//  Copyright © 2016 Ezequiel Thomazetto. All rights reserved.
//

#import "MovieService.h"
#import <AFNetworking/AFNetworking.h>

@implementation MovieService


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)movieList{
    
    NSURL *url = [NSURL URLWithString:@"https://api-public.guidebox.com/v1.43"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithBaseURL:url];
    
    [manager GET:@"US/rKJwmLEQB3qOouvHckEwjDrsGqKWpHgE/movies/all/1/10/all/all" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
    }];
    
}
@end
