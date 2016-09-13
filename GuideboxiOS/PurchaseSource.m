//
//  PurchaseSource.m
//  GuideboxiOS
//
//  Created by Ezequiel Thomazetto on 09/09/16.
//  Copyright © 2016 Ezequiel Thomazetto. All rights reserved.
//

#import "PurchaseSource.h"

@implementation PurchaseSource

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"name": @"display_name",
             @"formats": @"formats"
             };
}

+ (NSValueTransformer *)formatsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[Format class]];
}

@end
