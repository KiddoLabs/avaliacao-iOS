//
//  MovieService.h
//  GuideboxiOS
//
//  Created by Ezequiel Thomazetto on 08/09/16.
//  Copyright © 2016 Ezequiel Thomazetto. All rights reserved.
//

#import <Foundation/Foundation.h>

//Models
#import "MovieList.h"
#import "MovieDetail.h"

@protocol MovieServiceDelegate

@optional
-(void)responseSuccess:(id)response;
-(void)responseError:(NSError*)error;

//@required
//-(void)refreshTokenExpired;

@end

@interface MovieService : NSObject

- (instancetype)initWithTarget:(id<MovieServiceDelegate>)target;

-(void)getMovieListWithStart:(NSInteger)startAt size:(NSInteger)size;
-(void)getMovieDetailWithMovieID:(NSNumber*)movieID;

@end
