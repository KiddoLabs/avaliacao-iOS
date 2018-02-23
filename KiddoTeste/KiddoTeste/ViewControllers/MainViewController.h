//
//  MainViewController.h
//  KiddoTeste
//
//  Created by Aloisio Mello on 19/02/18.
//  Copyright © 2018 Aloisio Mello. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PINRemoteImage/PINImageView+PINRemoteImage.h>
#import <CCBottomRefreshControl/UIScrollView+BottomRefreshControl.h>
#import <ADLivelyCollectionView/ADLivelyCollectionView.h>
#import "MovieDetailsViewController.h"
#import "MovieListCollectionViewCell.h"
#import "CurrentTitleViewCollectionReusableView.h"
#import "ApiManager.h"
#import "MovieData.h"
#import "MovieDetailNavigationController.h"
#import "KiddoTeste-Bridging-Header.h"

@import CCZoomTransition;

@interface MainViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource,MovieDetailsViewControllerDelegate>
@property(nonatomic) NSInteger currentPage;
@property(nonatomic, strong) NSMutableArray * movieDatasource;
@property(nonatomic, weak) IBOutlet ADLivelyCollectionView * collectionView;

@end
