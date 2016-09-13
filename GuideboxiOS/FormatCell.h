//
//  PurchaseCell.h
//  GuideboxiOS
//
//  Created by Ezequiel Thomazetto on 09/09/16.
//  Copyright © 2016 Ezequiel Thomazetto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Format.h"

@interface FormatCell : UICollectionViewCell

/**
 Este metodo é responsável por configurar a célula a partir de um objeto do tipo Format.
 
 @param format objeto com informações requeridas para configuração da célula.
 */
-(void)configCellWithFormat:(Format*)format;

/**
 Este metodo é responsável por configurar um estado de seleção para a célula.
 
 @param state flag responsável por definir o estado de seleção.
 */
-(void)configCellSelectedState:(BOOL)state;

@end
