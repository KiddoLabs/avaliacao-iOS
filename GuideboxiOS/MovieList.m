//
//  MovieList.m
//  GuideboxiOS
//
//  Created by Ezequiel Thomazetto on 09/09/16.
//  Copyright © 2016 Ezequiel Thomazetto. All rights reserved.
//

#import "MovieList.h"


@implementation MovieList

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"movieListSize": @"total_results",
             @"returnedMovieListSize": @"total_returned",
             @"movies": @"results"
             };
}

+ (NSValueTransformer *)moviesJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[Movie class]];
}

@end
