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

@property (nonatomic, weak) id<MovieServiceDelegate> delegate;

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation MovieService

-(instancetype)initWithTarget:(id<MovieServiceDelegate>)target{
    
    self = [super init];
    if (self) {
        
        self.delegate = target;
        
        NSURL *url = [NSURL URLWithString:@"https://api-public.guidebox.com/v1.43"];
        
         self.manager = [[AFHTTPSessionManager alloc]initWithBaseURL:url];

    }
    return self;
}

-(void)getMovieList{
    
    [self.manager GET:@"US/rKJwmLEQB3qOouvHckEwjDrsGqKWpHgE/movies/all/1/10/all/all" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *responseDictionary = (NSDictionary *)responseObject;
        
        NSError *error;
        
        MovieList *movieList = [MTLJSONAdapter modelOfClass:[MovieList class] fromJSONDictionary:responseDictionary error:&error];
        
        if (error) {
            [self.delegate responseError:error];
        }
        else{
            [self.delegate responseSuccess:movieList];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self.delegate responseError:error];

    }];
    
}

-(void)getMovieDetailWithMovieID:(NSNumber*)movieID{
    
    [self.manager GET:@"US/rKJwmLEQB3qOouvHckEwjDrsGqKWpHgE/movie/138841" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *responseDictionary = (NSDictionary *)responseObject;
        
        NSError *error;
        
        MovieDetail *movieDetail = [MTLJSONAdapter modelOfClass:[MovieDetail class] fromJSONDictionary:responseDictionary error:&error];
        
        if (error) {
            [self.delegate responseError:error];
        }
        else{
            [self.delegate responseSuccess:movieDetail];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self.delegate responseError:error];
        
    }];
}
@end
