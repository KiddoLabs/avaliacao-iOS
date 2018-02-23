//
//  CurrentTitleViewCollectionReusableView.h
//  KiddoTeste
//
//  Created by Aloisio Mello on 20/02/18.
//  Copyright © 2018 Aloisio Mello. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrentTitleViewCollectionReusableView : UICollectionReusableView

@property(nonatomic, weak) IBOutlet UILabel * lblTitle;
-(void)configCell;
@end
