//
//  MovieData.m
//  KiddoTeste
//
//  Created by Aloisio Mello on 20/02/18.
//  Copyright © 2018 Aloisio Mello. All rights reserved.
//

#import "MovieData.h"
#define kImageDownloadPath @"https://image.tmdb.org/t/p/w185/"
@implementation MovieData

-(id)initWithDictionary : (NSDictionary*)dict{
    self.poster_path = [dict valueForKey:@"poster_path"];
    if (![self.poster_path containsString:kImageDownloadPath]) self.poster_path = [NSString stringWithFormat:@"%@%@", kImageDownloadPath, [dict valueForKey:@"poster_path"]];
    
    self.backdrop_path = [dict valueForKey:@"backdrop_path"];
    if (![self.backdrop_path containsString:kImageDownloadPath]) self.backdrop_path = [NSString stringWithFormat:@"%@%@", kImageDownloadPath, [dict valueForKey:@"backdrop_path"]];
    
    self.original_title = [dict valueForKey:@"original_title"];
    self.overview = [dict valueForKey:@"overview"];
    
    if(dict[@"id"])
        self.movieID = [NSNumber numberWithInteger:[[dict valueForKey:@"id"] longValue]];
    else
        self.movieID = [NSNumber numberWithInteger:[[dict valueForKey:@"movieID"] longValue]];
    
    if (dict[@"release_date"]) {
        self.year = [dict valueForKey:@"release_date"];
        
        NSCalendar *sysCalendar = [NSCalendar currentCalendar];
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyy-MM-dd"];
        NSDate *myDate = [df dateFromString: self.year];
        
        unsigned int unitFlags = NSYearCalendarUnit;
        NSDateComponents *breakdownInfo = [sysCalendar components:unitFlags fromDate:myDate];
        
        self.year = [NSString stringWithFormat:@"%ld", (long)breakdownInfo.year];
    }else{
        self.year = [dict valueForKey:@"year"];
    }

    
    return self;
}
@end
