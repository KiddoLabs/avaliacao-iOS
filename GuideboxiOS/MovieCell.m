//
//  FilmCell.m
//  GuideboxiOS
//
//  Created by Ezequiel Thomazetto on 08/09/16.
//  Copyright © 2016 Ezequiel Thomazetto. All rights reserved.
//

#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"

@interface MovieCell ()

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;
@property (weak, nonatomic) IBOutlet UILabel *movieNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseYearLabel;

@end

@implementation MovieCell

-(void)configCellWithMovie:(Movie*)movie{
    
    [self.thumbnailImageView setImageWithURL:movie.thumbnailURL];
#warning implementar esse metodo depois
//    self.thumbnailImageView setImageWithURL:<#(nonnull NSURL *)#> placeholderImage:<#(nullable UIImage *)#>
    
    [self.movieNameLabel setText:movie.title];
    [self.releaseYearLabel setText:[movie.releaseYear stringValue]];
}

@end
