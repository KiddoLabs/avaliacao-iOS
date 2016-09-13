//
//  Format.m
//  GuideboxiOS
//
//  Created by Ezequiel Thomazetto on 09/09/16.
//  Copyright © 2016 Ezequiel Thomazetto. All rights reserved.
//

#import "Format.h"

@implementation Format

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"formatName": @"format",
             @"price": @"price",
             @"type": @"type"
             };
}

+ (NSValueTransformer *)typeJSONTransformer {
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{@"purchase": @(PurchaseTypePurchase), @"rent": @(PurchaseTypeRent)}];
}

-(NSString*)getFormatType{
    
    NSString *result;
    
    switch (self.type) {
        case PurchaseTypePurchase:
            result = @"Comprar";
            break;
        case PurchaseTypeRent:
            result = @"Alugar: 3 Dias";
            break;
            
        default:
            result = @"";
            break;
    }
    
    return result;
}

@end
