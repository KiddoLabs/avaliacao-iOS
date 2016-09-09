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


//- (instancetype)initWithCoder:(NSCoder *)coder
//{
//    self = [super initWithCoder:coder];
//    if (self) {
//        self.enable = YES;
//    }
//    return self;
//}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
//    if (self.buttonColor) {
//        [self.titleLabel setTextColor:self.buttonColor];
//        [self.layer setBorderColor:self.buttonColor.CGColor];
//    }
//    else {
    
//        [self.layer setBorderColor:[UIColor cartaoVirtualGreenColor].CGColor];
//    }
    
//    [self setBackgroundColor:[UIColor GBRedColor]];
    
    [self enableButton:self.enable];
    
    [self.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0f]];
    
    [self.titleLabel setTextColor:[UIColor whiteColor]];
    
//    [self.layer setCornerRadius:(self.frame.size.height/2)];
//    [self.layer setBorderWidth:2.0f];
}

- (void)enableButton:(BOOL)enable {
    
    if (enable) {
//        [self setAlpha:1.0f];
        
        [self setBackgroundColor:[UIColor GBRedColor]];
        [self setEnabled:YES];
    }
    else{
        [self setBackgroundColor:[UIColor GBGrayColor]];
//        [self setAlpha:0.3f];
        [self setEnabled:NO];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
