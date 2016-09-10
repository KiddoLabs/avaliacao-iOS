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

@end
