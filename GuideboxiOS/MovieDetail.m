//
//  MovieDetail.m
//  GuideboxiOS
//
//  Created by Ezequiel Thomazetto on 09/09/16.
//  Copyright © 2016 Ezequiel Thomazetto. All rights reserved.
//

#import "MovieDetail.h"

@implementation MovieDetail

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"movieDescription": @"overview",
             @"purchaseSources": @"purchase_web_sources"
             };
}

+ (NSValueTransformer *)purchaseSourcesJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[PurchaseSource class]];
}

-(NSMutableArray*)getAllFormats{
    
    NSMutableArray *ret = [NSMutableArray new];
    
    for (PurchaseSource *purchaseSources in self.purchaseSources) {
        
        for (Format *format in purchaseSources.formats) {
            [ret addObject:format];
        }
    }
    
    return ret;
}

@end
