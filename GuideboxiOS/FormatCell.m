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
    
//    self.alpha = 0.5f;
//    self.contentView.alpha = 0.5f;
    
    self.layer.cornerRadius = 3.0f;
//    self.layer.borderWidth = 0.0f;
//    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.masksToBounds = YES;
}

-(void)configCellWithFormat:(Format*)format{
    
    [self.formatNameLabel setText:format.formatName];
    
    [self.priceLabel setText:[NSString stringWithFormat:@"R$ %@", format.price]];
    
    [self.typeLabel setText:[format getFormatType]];
    
//    [self.thumbnailImageView setImageWithURL:movie.thumbnailURL];
//#warning implementar esse metodo depois
//    //    self.thumbnailImageView setImageWithURL:<#(nonnull NSURL *)#> placeholderImage:<#(nullable UIImage *)#>
//    
//    [self.movieNameLabel setText:movie.title];
//    [self.releaseYearLabel setText:[movie.releaseYear stringValue]];
}

-(void)configSelectedState{
    
    if (/* DISABLES CODE */ (YES)) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self.formatNameLabel setTextColor:[UIColor GBRedColor]];
        [self.priceLabel setTextColor:[UIColor GBRedColor]];
        [self.typeLabel setTextColor:[UIColor GBRedColor]];
    }
    else{
        
        [self.backgroundColor = [UIColor whiteColor]colorWithAlphaComponent:0.35f]; //setBackgroundColor:[UIColor colo]];
        
        [self.formatNameLabel setTextColor:[UIColor GBRedColor]];
        [self.priceLabel setTextColor:[UIColor GBRedColor]];
        [self.typeLabel setTextColor:[UIColor GBRedColor]];
    }

    
}
@end
