//
//  MovieDetail.h
//  GuideboxiOS
//
//  Created by Ezequiel Thomazetto on 09/09/16.
//  Copyright © 2016 Ezequiel Thomazetto. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "PurchaseSource.h"

@interface MovieDetail : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *movieID;
@property (nonatomic, strong) NSURL *thumbnailURL;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *releaseYear;

@property (nonatomic, strong) NSArray *videoFormats;
@property (nonatomic, strong) NSString *movieDescription;
@property (nonatomic, strong) NSArray *purchaseSources;


#warning metodo para retornar os tres formtas mas usados
@end
