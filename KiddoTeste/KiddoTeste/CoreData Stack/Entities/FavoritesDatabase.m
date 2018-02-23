//
//  FavoritesDatabase.m
//  KiddoTeste
//
//  Created by Aloisio Mello on 21/02/18.
//  Copyright © 2018 Aloisio Mello. All rights reserved.
//

#import "FavoritesDatabase.h"

@implementation FavoritesDatabase

- (BOOL)saveMovieWithMovieData : (MovieData*)movieData{
    NSManagedObjectContext *context = [[MovieDatabaseManager sharedManager] managedObjectContext];
    
    NSManagedObject *newMovie = [NSEntityDescription insertNewObjectForEntityForName:@"Favorites" inManagedObjectContext:context];
    
    [newMovie setValue: movieData.backdrop_path forKey:@"backdrop_path"];
    [newMovie setValue: movieData.movieID forKey:@"movieID"];
    [newMovie setValue: movieData.original_title forKey:@"original_title"];
    [newMovie setValue: movieData.overview forKey:@"overview"];
    [newMovie setValue: movieData.poster_path forKey:@"poster_path"];
    [newMovie setValue: movieData.year forKey:@"year"];
    
    NSError *error;
    
    if(![context save:&error]){
        return NO;
    }
    return YES;
}

- (NSArray*)getAllMovies{
    NSManagedObjectContext *context = [[MovieDatabaseManager sharedManager] managedObjectContext];
    
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"Favorites"
                inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    NSError *error = nil;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"year"
                                                                 ascending:YES];
    
    NSArray *results = [objects sortedArrayUsingDescriptors:[NSArray arrayWithObject:descriptor]];
    
    if([results count] > 0){
        NSMutableArray * arrRet = [[NSMutableArray alloc] initWithCapacity:0];\
        for(NSManagedObject * obj in results){
            NSMutableDictionary * dict = [[NSMutableDictionary alloc] initWithCapacity:0];
            
            [dict setValue: [obj valueForKey:@"backdrop_path"] forKey:@"backdrop_path"];
            [dict setValue: [obj valueForKey:@"movieID"] forKey:@"movieID"];
            [dict setValue: [obj valueForKey:@"original_title"] forKey:@"original_title"];
            [dict setValue: [obj valueForKey:@"overview"] forKey:@"overview"];
            [dict setValue: [obj valueForKey:@"poster_path"] forKey:@"poster_path"];
            [dict setValue: [obj valueForKey:@"year"] forKey:@"year"];
            
            MovieData * movieData = [[MovieData alloc] initWithDictionary:dict];
            [arrRet addObject:movieData];
        }
        return arrRet;
    }
    return results;
}
- (MovieData*)getMovieWithMovieId : (NSNumber*)movieId{
    NSManagedObjectContext *context = [[MovieDatabaseManager sharedManager] managedObjectContext];
    
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"Favorites"
                inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"movieID=%@",movieId];
    [request setPredicate:pred];
    
    NSError *error = nil;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"year"
                                                                 ascending:YES];
    
    NSArray *results = [objects sortedArrayUsingDescriptors:[NSArray arrayWithObject:descriptor]];
    
    if([results count] > 0){
        NSDictionary * movieInfoDict = [results firstObject];
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] initWithCapacity:0];
        
        [dict setValue: [movieInfoDict valueForKey:@"backdrop_path"] forKey:@"backdrop_path"];
        [dict setValue: [movieInfoDict valueForKey:@"movieID"] forKey:@"movieID"];
        [dict setValue: [movieInfoDict valueForKey:@"original_title"] forKey:@"original_title"];
        [dict setValue: [movieInfoDict valueForKey:@"overview"] forKey:@"overview"];
        [dict setValue: [movieInfoDict valueForKey:@"poster_path"] forKey:@"poster_path"];
        [dict setValue: [movieInfoDict valueForKey:@"year"] forKey:@"year"];
        
        MovieData * movieData = [[MovieData alloc] initWithDictionary:dict];
        return movieData;
    }
    
    return nil;
}
- (void)removeMovieWithMovieId : (NSNumber*)movieId{
    NSManagedObjectContext *context = [[MovieDatabaseManager sharedManager] managedObjectContext];
    
    NSFetchRequest *allStatus = [[NSFetchRequest alloc] init];
    [allStatus setEntity:[NSEntityDescription entityForName:@"Favorites" inManagedObjectContext:context]];
    [allStatus setIncludesPropertyValues:NO];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"movieID == %@", movieId];
    [allStatus setPredicate:pred];
    NSError *error = nil;
    NSArray *arrStatus = [context executeFetchRequest:allStatus error:&error];
    
    for (NSManagedObject *status in arrStatus) {
        [context deleteObject:status];
    }
    NSError *saveError = nil;
    if(![context save:&saveError]){
        NSLog(@"%@ -> Error = %@", NSStringFromClass([self class]),saveError.description);
    }
}

@end
