//
//  SellItemCollectionViewCell.h
//  KiddoTeste
//
//  Created by Aloisio Mello on 22/02/18.
//  Copyright © 2018 Aloisio Mello. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+Essentials.h"

@protocol SellItemCollectionDelegate <NSObject>

-(void)buyMovie;

@end
@interface SellItemCollectionViewCell : UICollectionViewCell

@property(nonatomic, weak) IBOutlet UIView * cellBackground;
@property(nonatomic, weak) IBOutlet UILabel * movieQualityLabel;
@property(nonatomic, weak) IBOutlet UILabel * moviePriceLabel;
@property(nonatomic, weak) IBOutlet UILabel * movieSellCategoryLabel;

@property(nonatomic) id<SellItemCollectionDelegate> delegate;
@property(nonatomic) BOOL enabled;
-(void)configCell;

@end
