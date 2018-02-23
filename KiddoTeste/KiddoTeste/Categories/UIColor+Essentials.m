//
//  UIColor+Essentials.m
//  KiddoTeste
//
//  Created by Aloisio Mello on 19/02/18.
//  Copyright © 2018 Aloisio Mello. All rights reserved.
//

#import "UIColor+Essentials.h"

@implementation UIColor (Essentials)

+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

@end
