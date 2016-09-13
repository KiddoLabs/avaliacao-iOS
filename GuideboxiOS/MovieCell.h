//
//  FilmCell.h
//  GuideboxiOS
//
//  Created by Ezequiel Thomazetto on 08/09/16.
//  Copyright © 2016 Ezequiel Thomazetto. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Movie.h"
#import "FavoriteMovieDetail.h"

@interface MovieCell : UICollectionViewCell

/**
 Este metodo é responsável por configurar a célula a partir de um objeto do tipo Movie.
 
 @param movie objeto com informações requeridas para configuração da célula.
 */
-(void)configCellWithMovie:(Movie*)movie;

/**
 Este metodo é responsável por configurar a célula a partir de um objeto do tipo FavoriteMovieDetail.
 
 @param favoriteMovieDetail objeto com informações requeridas para configuração da célula.
 */
-(void)configCellWithFavouriteMovie:(FavoriteMovieDetail*)favoriteMovieDetail;

@end
