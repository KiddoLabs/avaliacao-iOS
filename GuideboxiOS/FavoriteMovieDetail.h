//
//  FavoriteMovieDetail.h
//  GuideboxiOS
//
//  Created by Ezequiel Thomazetto on 11/09/16.
//  Copyright © 2016 Ezequiel Thomazetto. All rights reserved.
//

#import <Realm/Realm.h>

@interface FavoriteMovieDetail : RLMObject

@property (nonatomic, strong) NSNumber<RLMInt> *movieID;
@property (nonatomic, strong) NSString *thumbnailURL;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber<RLMInt> *releaseYear;
@property (nonatomic, strong) NSString *movieDescription;

@end
