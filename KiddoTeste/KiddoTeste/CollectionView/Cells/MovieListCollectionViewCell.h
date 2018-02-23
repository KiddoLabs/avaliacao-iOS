//
//  MovieListCollectionViewCell.h
//  KiddoTeste
//
//  Created by Aloisio Mello on 19/02/18.
//  Copyright © 2018 Aloisio Mello. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieListCollectionViewCell : UICollectionViewCell
@property(nonatomic, weak) IBOutlet UIImageView * imageMovieCover;
@property(nonatomic, weak) IBOutlet UILabel * labelMovieName;
@property(nonatomic, weak) IBOutlet UILabel * labelMovieReleaseYear;

-(void)configCell;
@end
