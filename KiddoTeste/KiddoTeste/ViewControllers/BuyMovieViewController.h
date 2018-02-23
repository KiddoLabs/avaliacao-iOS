//
//  BuyMovieViewController.h
//  KiddoTeste
//
//  Created by Aloisio Mello on 22/02/18.
//  Copyright © 2018 Aloisio Mello. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PINRemoteImage/PINImageView+PINRemoteImage.h>
#import "SellSectionCollectionReusableView.h"
#import "SellItemCollectionViewCell.h"
#import "MovieData.h"

@interface BuyMovieViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource,SellItemCollectionDelegate>

@property(nonatomic, weak) IBOutlet UICollectionView * collectionView;
@property(nonatomic, weak) IBOutlet UIButton * buyButton;
@property(nonatomic, strong) UIImageView * backdropImageView;
@property(nonatomic, strong) MovieData * movieData;
@end
