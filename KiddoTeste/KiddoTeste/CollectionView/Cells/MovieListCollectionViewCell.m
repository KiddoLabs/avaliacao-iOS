//
//  MovieListCollectionViewCell.m
//  KiddoTeste
//
//  Created by Aloisio Mello on 19/02/18.
//  Copyright © 2018 Aloisio Mello. All rights reserved.
//

#import "MovieListCollectionViewCell.h"
#import <QuartzCore/QuartzCore.h>
@implementation MovieListCollectionViewCell

-(void)configCell{
    [_labelMovieName setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15]];
    [_labelMovieName setAdjustsFontSizeToFitWidth:YES];
    [_labelMovieReleaseYear setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16]];
    [_labelMovieReleaseYear setAdjustsFontSizeToFitWidth:YES];
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 5.0f;
    self.layer.masksToBounds = NO;
    self.layer.shadowOffset = CGSizeMake(0, 5);
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = 0.5;
}
@end
