//
//  SellItemCollectionViewCell.m
//  KiddoTeste
//
//  Created by Aloisio Mello on 22/02/18.
//  Copyright © 2018 Aloisio Mello. All rights reserved.
//

#import "SellItemCollectionViewCell.h"

@implementation SellItemCollectionViewCell

-(void)configCell{
    self.layer.cornerRadius = 5.0f;
    
    UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView * blurView = [[UIVisualEffectView alloc] initWithEffect:blur];
    [blurView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self.cellBackground addSubview:blurView];
    
    _movieQualityLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
    _movieQualityLabel.textColor = [UIColor whiteColor];
    _movieQualityLabel.enabled = _enabled;
    
    _moviePriceLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
    _moviePriceLabel.textColor = [UIColor whiteColor];
    _moviePriceLabel.enabled = _enabled;
    
    _movieSellCategoryLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
    _movieSellCategoryLabel.textColor = [UIColor whiteColor];
    _movieSellCategoryLabel.enabled = _enabled;
    
    self.userInteractionEnabled = _enabled;
}



-(void)setSelected:(BOOL)selected{
    if(selected){
        self.cellBackground.backgroundColor = [UIColor whiteColor];
        _movieQualityLabel.textColor = [UIColor colorFromHexString:@"#9B0801"];
        _moviePriceLabel.textColor = [UIColor colorFromHexString:@"#9B0801"];
        _movieSellCategoryLabel.textColor = [UIColor colorFromHexString:@"#9B0801"];
        [_delegate buyMovie];
    }
    else{
        self.cellBackground.backgroundColor = [UIColor clearColor];
        _movieQualityLabel.textColor = [UIColor whiteColor];
        _moviePriceLabel.textColor = [UIColor whiteColor];
        _movieSellCategoryLabel.textColor = [UIColor whiteColor];
    }
}

@end
