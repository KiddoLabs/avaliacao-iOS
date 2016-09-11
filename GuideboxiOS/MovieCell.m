//
//  FilmCell.m
//  GuideboxiOS
//
//  Created by Ezequiel Thomazetto on 08/09/16.
//  Copyright © 2016 Ezequiel Thomazetto. All rights reserved.
//

#import "MovieCell.h"
//#import "UIImageView+AFNetworking.h"
//#import <SDWebImage/UIImageView+WebCache.h>
#import <PINImageView+PINRemoteImage.h>


@interface MovieCell ()

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;
@property (weak, nonatomic) IBOutlet UILabel *movieNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseYearLabel;

@end

@implementation MovieCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configCell];
    }
    return self;
    
    
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self configCell];
    }
    return self;
}

-(void)configCell{
    self.layer.cornerRadius = 4.0f;
    self.layer.borderWidth = 0.0f;
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.masksToBounds = YES;
    
    self.contentView.layer.cornerRadius = 4.0f;
//    self.contentView.layer.borderWidth = 0.1f;
//    self.contentView.layer.borderColor = [UIColor blackColor].CGColor;
    self.contentView.layer.masksToBounds = YES;
    
//    self.layer.shadowColor = [UIColor blackColor].CGColor;
//    self.layer.shadowOffset = CGSizeMake(10.0f, 10.0f);
//    self.layer.shadowRadius = 4.0f;
//    self.layer.shadowOpacity = 1.0f;
    
    
//    self.layer.masksToBounds = NO;
//    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.contentView.layer.cornerRadius].CGPath;
    
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.5f;
    self.layer.shadowOffset = CGSizeMake(0, 2);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 4.0f;
    self.layer.masksToBounds = NO;
//    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.contentView.layer.cornerRadius].CGPath;
}

-(void)configCellWithMovie:(Movie*)movie{
    
//    [self.thumbnailImageView setShowActivityIndicatorView:YES];
    
//    [self.thumbnailImageView sd_setImageWithURL:movie.thumbnailURL];
    
    [self.thumbnailImageView setPin_updateWithProgress:YES];
    
    [self.thumbnailImageView pin_setImageFromURL:movie.thumbnailURL];
    
    //setImageWithURL:movie.thumbnailURL];
    
#warning implementar esse metodo depois
//    self.thumbnailImageView setImageWithURL:<#(nonnull NSURL *)#> placeholderImage:<#(nullable UIImage *)#>
    
    [self.movieNameLabel setText:movie.title];
    [self.releaseYearLabel setText:[movie.releaseYear stringValue]];
}

@end
