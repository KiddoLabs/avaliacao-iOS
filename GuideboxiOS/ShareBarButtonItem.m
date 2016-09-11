//
//  ShareBarButtonItem.m
//  GuideboxiOS
//
//  Created by Ezequiel Thomazetto on 10/09/16.
//  Copyright © 2016 Ezequiel Thomazetto. All rights reserved.
//

#import "ShareBarButtonItem.h"

@implementation ShareBarButtonItem


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

-(void)configButton{
    
    UIImage *chatImage = [UIImage imageNamed:@"shareButton"];
    
    UIButton *chatButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [chatButton setBackgroundImage:chatImage forState:UIControlStateNormal];
    [chatButton setTitle:@"Share" forState:UIControlStateNormal];
    chatButton.frame = (CGRect) {
        .size.width = 100,
        .size.height = 30,
    };
    
    [super initWithCustomView:chatButton];
    
//    UIBarButtonItem *barButton= [[[UIBarButtonItem alloc] initWithCustomView:chatButton] autorelease];
//    self.toolbar.items = [NSArray arrayWithObject:barButton];
    
}
@end
