//
//  Movie.h
//  GuideboxiOS
//
//  Created by Ezequiel Thomazetto on 09/09/16.
//  Copyright © 2016 Ezequiel Thomazetto. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface Movie : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *movieID;
@property (nonatomic, strong) NSURL *thumbnailURL;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *releaseYear;

@end
    