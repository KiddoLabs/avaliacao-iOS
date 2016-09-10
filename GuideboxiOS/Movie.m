//
//  Movie.m
//  GuideboxiOS
//
//  Created by Ezequiel Thomazetto on 09/09/16.
//  Copyright © 2016 Ezequiel Thomazetto. All rights reserved.
//

#import "Movie.h"

@implementation Movie

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"movieID": @"id",
             @"thumbnailURL": @"poster_120x171",
             @"title": @"title",
             @"releaseYear": @"release_year"
             };
}

@end
