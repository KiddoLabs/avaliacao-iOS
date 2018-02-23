//
//  MovieData.h
//  KiddoTeste
//
//  Created by Aloisio Mello on 20/02/18.
//  Copyright © 2018 Aloisio Mello. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieData : NSObject

@property(nonatomic, strong) NSNumber * movieID;
@property(nonatomic, strong) NSString * original_title;
@property(nonatomic, strong) NSString * poster_path;
@property(nonatomic, strong) NSString * backdrop_path;
@property(nonatomic, strong) NSString * year;
@property(nonatomic, strong) NSString * overview;

-(id)initWithDictionary : (NSDictionary*)dict;
@end
