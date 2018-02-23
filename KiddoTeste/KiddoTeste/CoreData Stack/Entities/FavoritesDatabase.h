//
//  FavoritesDatabase.h
//  KiddoTeste
//
//  Created by Aloisio Mello on 21/02/18.
//  Copyright © 2018 Aloisio Mello. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovieDatabaseManager.h"
#import "MovieData.h"

@interface FavoritesDatabase : NSObject

- (BOOL)saveMovieWithMovieData : (MovieData*)movieData;
- (NSArray*)getAllMovies;
- (MovieData*)getMovieWithMovieId : (NSNumber*)movieId;
- (void)removeMovieWithMovieId : (NSNumber*)movieId;

@end
