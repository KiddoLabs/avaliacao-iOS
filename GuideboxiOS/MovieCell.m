//
//  FilmCell.m
//  GuideboxiOS
//
//  Created by Ezequiel Thomazetto on 08/09/16.
//  Copyright © 2016 Ezequiel Thomazetto. All rights reserved.
//

#import "MovieCell.h"
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
    self.contentView.layer.masksToBounds = YES;
    
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.5f;
    self.layer.shadowOffset = CGSizeMake(0, 2);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 4.0f;
    self.layer.masksToBounds = NO;
}

-(void)configCellWithMovie:(Movie*)movie{
    
    [self.thumbnailImageView setPin_updateWithProgress:YES];
    [self.thumbnailImageView pin_setImageFromURL:movie.thumbnailURL];
    
    [self.movieNameLabel setText:movie.title];
    [self.releaseYearLabel setText:[movie.releaseYear stringValue]];
}

-(void)configCellWithFavouriteMovie:(FavoriteMovieDetail*)favoriteMovieDetail{
    
    [self.thumbnailImageView setPin_updateWithProgress:YES];
    [self.thumbnailImageView pin_setImageFromURL:[NSURL URLWithString:favoriteMovieDetail.thumbnailURL]];
    
    [self.movieNameLabel setText:favoriteMovieDetail.title];
    [self.releaseYearLabel setText:[favoriteMovieDetail.releaseYear stringValue]];
}

@end
