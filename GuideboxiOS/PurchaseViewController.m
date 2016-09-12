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

@interface PurchaseViewController () <UICollectionViewDelegateFlowLayout ,UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong)NSIndexPath *selectedIndexPath;
@property (weak, nonatomic) IBOutlet GBButton *purchaseButton;

@end

@implementation PurchaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UINib *nib = [UINib nibWithNibName:@"FormatCell" bundle: nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"formatCell"];
    
    UINib *purchaseListHeader = [UINib nibWithNibName:@"PurchaseListHeader" bundle: nil];
    [self.collectionView registerNib:purchaseListHeader forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"PurchaseListHeader"];
    
//    self.selectedIndexPath = nil;
    
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [self.purchaseSources count];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [[(PurchaseSource*)[self.purchaseSources objectAtIndex:section] formats] count];
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    //    if (kind == UICollectionElementKindSectionHeader) {
    
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
//
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    [self performSegueWithIdentifier:@"homeToDetailSegue" sender:self];
//    FormatCell *cell = (FormatCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"formatCell" forIndexPath:indexPath];
    
//    FormatCell *cell = (FormatCell*)[collectionView cellForItemAtIndexPath:indexPath];
    
//    [cell selectCell];
    if (self.selectedIndexPath != nil && [self.selectedIndexPath compare:indexPath] == NSOrderedSame) {
        self.selectedIndexPath = nil;
    }
    else{
        self.selectedIndexPath = indexPath;
    }
    
    

//    [collectionView reloadData];
    
    [collectionView reloadData];
    
//    [collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
    
//    cell.selectedBackgroundView
    
    
//    [cell selectCell];
    
}

//-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    FormatCell *cell = (FormatCell*)[collectionView cellForItemAtIndexPath:indexPath];
//    
//    [cell configCellSelectedState:NO];
//    
//    [collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
//    
//}

//-(void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    FormatCell *cell = (FormatCell*)[collectionView cellForItemAtIndexPath:indexPath];
//    
//    [cell configCellSelectedState:YES];
//}
//
//-(void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    FormatCell *cell = (FormatCell*)[collectionView cellForItemAtIndexPath:indexPath];
//    
//    [cell configCellSelectedState:NO];
//    
//}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 7, 0, 7);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1.0f;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    int numberOfCellInRow = 3;
    CGFloat cellWidth =  ([[UIScreen mainScreen] bounds].size.width -30)/numberOfCellInRow;
    
    CGFloat one = 115.0f - cellWidth;
    
    CGFloat two = 115.0f * 100;
    
    CGFloat three = one / two;
    
    CGFloat four = three * 100;//=percent
    
    CGFloat five = 100.0f * four;
    
    CGFloat cellHeight = 100.0f - five;
    
    return CGSizeMake(cellWidth,cellHeight);
    
    //
    //    float cellWidth = (self.view.frame.size.width / 3) - 20;
    //    float cellHeight = cellWidth * 190.0f / 270.0f;
    //    return CGSizeMake(cellWidth, cellHeight);
    
    //    //120x237
    //
    //    int numberOfCellInRow = 3;
    //    CGFloat cellWidth =  ([[UIScreen mainScreen] bounds].size.width -20)/numberOfCellInRow;
    //
    //    CGFloat percent = ((120 - cellWidth)/120*100);
    //
    //    CGFloat cellHeight = 237 * percent;
    //
    //    return CGSizeMake(cellWidth,cellHeight);
    
    
    //#define kCellsPerRow 3
    //
    //    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    //
    //    CGFloat availableWidthForCells = CGRectGetWidth(self.collectionView.frame) - flowLayout.sectionInset.left - flowLayout.sectionInset.right - flowLayout.minimumInteritemSpacing * (kCellsPerRow - 1);
    //
    //    CGFloat cellWidth = availableWidthForCells / kCellsPerRow;
    //    flowLayout.itemSize = CGSizeMake(cellWidth, flowLayout.itemSize.height);
    //
    //    return flowLayout.itemSize;
    
    
    //    return CGSizeMake((UIScreen.mainScreen().bounds.width-15)/4,120); //use height whatever you wants.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
