//
//  FilmCell.h
//  GuideboxiOS
//
//  Created by Ezequiel Thomazetto on 08/09/16.
//  Copyright © 2016 Ezequiel Thomazetto. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Movie.h"

@interface MovieCell : UICollectionViewCell

-(void)configCellWithMovie:(Movie*)movie;

@end
