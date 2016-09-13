//
//  PurchaseSource.h
//  GuideboxiOS
//
//  Created by Ezequiel Thomazetto on 09/09/16.
//  Copyright © 2016 Ezequiel Thomazetto. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "Format.h"

@interface PurchaseSource : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *formats;

@end
