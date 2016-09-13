//
//  PurchaseCell.m
//  GuideboxiOS
//
//  Created by Ezequiel Thomazetto on 09/09/16.
//  Copyright © 2016 Ezequiel Thomazetto. All rights reserved.
//

#import "FormatCell.h"
#import "UIColor+GBColor.h"

@interface FormatCell ()

@property (weak, nonatomic) IBOutlet UILabel *formatNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property BOOL selectedState;

@end

@implementation FormatCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self configCell];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self configCell];
    }
    return self;
}

-(void)configCell{
    
    self.layer.cornerRadius = 3.0f;
    self.layer.masksToBounds = YES;
}

-(void)configCellWithFormat:(Format*)format{
    
    [self.formatNameLabel setText:format.formatName];
    [self.priceLabel setText:[NSString stringWithFormat:@"R$ %@", format.price]];
    [self.typeLabel setText:[format getFormatType]];
    
}

-(void)configCellSelectedState:(BOOL)state{
    
    if (state) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self.formatNameLabel setTextColor:[UIColor GBRedColor]];
        [self.priceLabel setTextColor:[UIColor GBRedColor]];
        [self.typeLabel setTextColor:[UIColor GBRedColor]];
    }
    else{
        
        [self setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0.35f]];
        [self.formatNameLabel setTextColor:[UIColor whiteColor]];
        [self.priceLabel setTextColor:[UIColor whiteColor]];
        [self.typeLabel setTextColor:[UIColor whiteColor]];
    }
    
    
}

@end
