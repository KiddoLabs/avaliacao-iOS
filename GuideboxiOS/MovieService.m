//
//  MovieService.m
//  GuideboxiOS
//
//  Created by Ezequiel Thomazetto on 08/09/16.
//  Copyright © 2016 Ezequiel Thomazetto. All rights reserved.
//

#import "MovieService.h"

@interface MovieService ()

@property (nonatomic, weak) id<MovieServiceDelegate> delegate;
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong)NSString *key;

@end

@implementation MovieService

-(instancetype)initWithTarget:(id<MovieServiceDelegate>)target{
    
    self = [super init];
    if (self) {
        
        self.delegate = target;
        
        NSURL *url = [NSURL URLWithString:@"https://api-public.guidebox.com/v1.43"];
        self.key = @"rKJwmLEQB3qOouvHckEwjDrsGqKWpHgE";
        self.manager = [[AFHTTPSessionManager alloc]initWithBaseURL:url];
        
    }
    return self;
}

-(void)getMovieListWithStart:(NSInteger)startAt size:(NSInteger)size{
    
    NSString *urlString = [NSString stringWithFormat:@"US/%@/movies/all/%ld/%ld/all/all", self.key, (long)startAt, (long)size];
    
    [self.manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
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
    
    NSString *urlString = [NSString stringWithFormat:@"US/%@/movie/%@", self.key, [movieID stringValue]];
    
    [self.manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
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
