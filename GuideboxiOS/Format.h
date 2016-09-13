//
//  Format.h
//  GuideboxiOS
//
//  Created by Ezequiel Thomazetto on 09/09/16.
//  Copyright © 2016 Ezequiel Thomazetto. All rights reserved.
//

#import <Mantle/Mantle.h>

typedef enum : NSUInteger {
    PurchaseTypePurchase,
    PurchaseTypeRent
} PurchaseType;

@interface Format : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *formatName;
@property (nonatomic, strong) NSString *price;
@property (nonatomic) PurchaseType type;

-(NSString*)getFormatType;

@end
