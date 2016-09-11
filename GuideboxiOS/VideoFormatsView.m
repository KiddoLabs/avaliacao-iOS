//
//  VideoFormatsView.m
//  GuideboxiOS
//
//  Created by Ezequiel Thomazetto on 10/09/16.
//  Copyright © 2016 Ezequiel Thomazetto. All rights reserved.
//

#import "VideoFormatsView.h"

@implementation VideoFormatsView


-(void)loadView{
    
    UIView *view = [[[NSBundle bundleForClass:[self class]] loadNibNamed: NSStringFromClass([self class]) owner:self options:nil] firstObject];
    
    [self addSubview:view];
    view.frame = self.bounds;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadView];
        [self configView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self loadView];
        [self configView];
    }
    return self;
}

-(void)configView{
    
//    UIView *leftPadding = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.titleLabel.frame.origin.x, 50)];
//    
//    self.textField.leftView = leftPadding;
//    self.textField.leftViewMode = UITextFieldViewModeAlways;
//    
//    self.textField.layer.cornerRadius = 4.0f;
//    
//    UIColor *color = [UIColor colorWithRed:16/255.0 green:169/255.0 blue:131/255.0 alpha:1.0];
//    
//    self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"000.000.000-00"
//                                                                           attributes:@{NSForegroundColorAttributeName: color,
//                                                                                        NSFontAttributeName: [UIFont MuseoSans300WithSize:16.0f]}];
//    
//    self.textField.mask = @"###.###.###-##";
//    self.textField.delegate = self;
//    
//    self.infoLabel.hidden = YES;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
