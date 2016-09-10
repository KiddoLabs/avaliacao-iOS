//
//  MovieList.h
//  GuideboxiOS
//
//  Created by Ezequiel Thomazetto on 09/09/16.
//  Copyright © 2016 Ezequiel Thomazetto. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "Movie.h"

@interface MovieList : MTLModel <MTLJSONSerializing>

@property (nonatomic) NSInteger movieListSize;

@property (nonatomic) NSInteger returnedMovieListSize;

@property (nonatomic, strong) NSArray *movies;

@end
