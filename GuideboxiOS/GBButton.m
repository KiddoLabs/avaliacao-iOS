//
//  GBButton.m
//  GuideboxiOS
//
//  Created by Ezequiel Thomazetto on 09/09/16.
//  Copyright © 2016 Ezequiel Thomazetto. All rights reserved.
//

#import "GBButton.h"
#import "UIColor+GBColor.h"

@implementation GBButton

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self enableButton:self.enable];
    [self.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0f]];
    [self.titleLabel setTextColor:[UIColor whiteColor]];
    
}

- (void)enableButton:(BOOL)enable {
    
    if (enable) {
        [self setBackgroundColor:[UIColor GBRedColor]];
        [self setEnabled:YES];
    }
    else{
        [self setBackgroundColor:[UIColor GBGrayColor]];
        [self setEnabled:NO];
    }
}

@end
