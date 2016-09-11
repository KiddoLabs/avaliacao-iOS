//
//  MovieDetail.m
//  GuideboxiOS
//
//  Created by Ezequiel Thomazetto on 09/09/16.
//  Copyright © 2016 Ezequiel Thomazetto. All rights reserved.
//

#import "MovieDetail.h"

@implementation MovieDetail

//+ (NSDictionary *)JSONKeyPathsByPropertyKey {
//    return @{
//             @"thumbnailURL": @"poster_120x171",
//             @"title": @"title",
//             @"releaseYear": @"release_year",
//             
//             @"movieDescription": @"overview",
//             @"purchaseSources": @"purchase_web_sources"
//             };
//}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"movieDescription": @"overview",
             @"purchaseSources": @"purchase_web_sources"
             };
}


#warning fazer a logica para pegar todos os video formats e popular o atributo correspondente nessa classe


+ (NSValueTransformer *)purchaseSourcesJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[PurchaseSource class]];
}


-(NSMutableDictionary*)getFormats{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    for (PurchaseSource *purchaseSource in self.purchaseSources) {
        
        for (Format *format in purchaseSource.formats) {
            
            NSNumber *formatCount = [dic objectForKey:format.formatName];

            int value = [formatCount intValue];

            [dic setObject:[NSNumber numberWithInt:value + 1] forKey:format.formatName];

        }
    }
    
    return dic;
    
}
@end
