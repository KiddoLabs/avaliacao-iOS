//
//  PurchaseViewController.m
//  GuideboxiOS
//
//  Created by Ezequiel Thomazetto on 08/09/16.
//  Copyright © 2016 Ezequiel Thomazetto. All rights reserved.
//

#import "PurchaseViewController.h"
#import "FormatCell.h"
#import "PurchaseListHeader.h"
#import "GBButton.h"
#import <PINImageView+PINRemoteImage.h>
#import "UIImage+ImageEffects.h"

@interface PurchaseViewController () <UICollectionViewDelegateFlowLayout ,UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong)NSIndexPath *selectedIndexPath;
@property (weak, nonatomic) IBOutlet GBButton *purchaseButton;

@end

@implementation PurchaseViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"FormatCell" bundle: nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"formatCell"];
    
    UINib *purchaseListHeader = [UINib nibWithNibName:@"PurchaseListHeader" bundle: nil];
    [self.collectionView registerNib:purchaseListHeader forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"PurchaseListHeader"];
    
    int itemsCount = 0;
    
    for (PurchaseSource *purchaseSource in self.purchaseSources) {
        itemsCount += [purchaseSource.formats count];

    }

    if (itemsCount > 0) {
        
        UIImageView *backGroundImage = [UIImageView new];
        [backGroundImage setPin_updateWithProgress:YES];
        [backGroundImage pin_setImageFromURL:self.thumbnailURL];
        
        backGroundImage.image = [self blurWithImageEffects:backGroundImage.image];
        [self.collectionView setBackgroundView:backGroundImage];
    }
    else{
        self.purchaseSources = nil;
        
        UILabel *label = [[UILabel alloc]initWithFrame:self.collectionView.frame];
        
        [label setNumberOfLines:0];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setTextColor:[UIColor whiteColor]];
        
        [label setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f]];
        
        label.text = @"Este título não está disponível para compra ou aluguel";
        
        [self.collectionView setBackgroundView:label];
        
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:NO];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)blurWithImageEffects:(UIImage *)image
{
    return [image applyBlurWithRadius:2 tintColor:[UIColor colorWithWhite:0.2 alpha:0.5] saturationDeltaFactor:1.5 maskImage:nil];
}

#pragma mark - UICollectionView

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [self.purchaseSources count];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [[(PurchaseSource*)[self.purchaseSources objectAtIndex:section] formats] count];
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    PurchaseListHeader *purchaseListHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"PurchaseListHeader" forIndexPath:indexPath];
    
    purchaseListHeader.purchaseSourceNameLabel.text = [(PurchaseSource*)[self.purchaseSources objectAtIndex:indexPath.section] name];
    
    
    return purchaseListHeader;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FormatCell *cell = (FormatCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"formatCell" forIndexPath:indexPath];
    
    Format *format = (Format*)[[(PurchaseSource*)[self.purchaseSources objectAtIndex:indexPath.section] formats] objectAtIndex:indexPath.row];
    
    [cell configCellWithFormat:format];
    
    if (self.selectedIndexPath != nil && [self.selectedIndexPath compare:indexPath] == NSOrderedSame) {
        [cell configCellSelectedState:YES];
    }
    else{
        [cell configCellSelectedState:NO];
    }
    
    if (self.selectedIndexPath == nil) {
        self.purchaseButton.enable = NO;
    }
    else{
        self.purchaseButton.enable = YES;
    }
    [self.purchaseButton setNeedsLayout];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.selectedIndexPath != nil && [self.selectedIndexPath compare:indexPath] == NSOrderedSame) {
        self.selectedIndexPath = nil;
    }
    else{
        self.selectedIndexPath = indexPath;
    }
    
    [collectionView reloadData];
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 7, 0, 7);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1.0f;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    int numberOfCellInRow = 3;
    CGFloat cellWidth =  ([[UIScreen mainScreen] bounds].size.width -30)/numberOfCellInRow;
    
    CGFloat cellHeight = 100.0f - (100.0f * (((115.0f - cellWidth) / (115.0f * 100)) * 100));
    
    return CGSizeMake(cellWidth,cellHeight);
    
}

@end
