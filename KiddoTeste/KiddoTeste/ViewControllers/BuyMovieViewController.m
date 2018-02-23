//
//  BuyMovieViewController.m
//  KiddoTeste
//
//  Created by Aloisio Mello on 22/02/18.
//  Copyright © 2018 Aloisio Mello. All rights reserved.
//

#import "BuyMovieViewController.h"

@interface BuyMovieViewController ()

@end

@implementation BuyMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_collectionView setBackgroundColor:[UIColor blackColor]];
    
    _backdropImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _collectionView.frame.size.width, _collectionView.frame.size.height)];
    _backdropImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_backdropImageView pin_setImageFromURL: [NSURL URLWithString:_movieData.backdrop_path]];
    UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView * blurView = [[UIVisualEffectView alloc] initWithEffect:blur];
    [blurView setFrame:_backdropImageView.frame];
    [_backdropImageView addSubview:blurView];
    
    _collectionView.backgroundView = _backdropImageView;
    
    _buyButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:15];
    [self configureNavigationBar];
}

-(void)configureNavigationBar{    
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 80, 32);
    backButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [backButton setImage:[UIImage imageNamed:@"white-back-btn"] forState:UIControlStateNormal];
    [backButton setTitle:@"Voltar" forState:UIControlStateNormal];
    [backButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Regular" size:18]];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [backButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft]; //Align button content to horizontal left
    [backButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)]; // Set space between label and image
    
    [backButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * barBackButton = [[UIBarButtonItem alloc] init];
    barBackButton.customView = backButton;
    self.navigationItem.leftBarButtonItem = barBackButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }else{
        return 4;
    }
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SellItemCollectionViewCell *movieInformationCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellPrice" forIndexPath:indexPath];
    movieInformationCell.enabled = NO;
    movieInformationCell.delegate = self;
    
    int year = [_movieData.year intValue];
    if(indexPath.section == 0){
        int year = [_movieData.year intValue];
        switch (indexPath.row) {
            case 0:{
                if(year > 2015)
                    movieInformationCell.enabled = YES;
                
                    movieInformationCell.movieQualityLabel.text = @"Full HD";
                    movieInformationCell.moviePriceLabel.text = @"R$20,00";
                    movieInformationCell.moviePriceLabel.accessibilityLabel = @"R$20,00";
                    movieInformationCell.accessibilityLabel = @"Comprar Full HD R$20,00 Applestore";
                    movieInformationCell.movieSellCategoryLabel.text = @"Comprar";
                    [movieInformationCell configCell];
                
                break;
            }
            case 1:{
                if(year > 2005)
                    movieInformationCell.enabled = YES;
                
                    movieInformationCell.movieQualityLabel.text = @"HD";
                    movieInformationCell.moviePriceLabel.text = @"R$10,00";
                    movieInformationCell.accessibilityLabel = @"HD R$10,00 Alugar: 3 Dias Applestore";
                    movieInformationCell.movieSellCategoryLabel.text = @"Alugar: 3 Dias";
                    [movieInformationCell configCell];
                break;
            }
            case 2:{
                    movieInformationCell.enabled = YES;
                    movieInformationCell.movieQualityLabel.text = @"SD";
                    movieInformationCell.moviePriceLabel.text = @"R$5,00";
                    movieInformationCell.accessibilityLabel = @"SD R$5,00 Alugar: 3 Dias Applestore";
                    movieInformationCell.movieSellCategoryLabel.text = @"Alugar: 3 Dias";
                    [movieInformationCell configCell];
                break;
            }
            default:
                break;
        }
    }else if (indexPath.section == 1){
        switch (indexPath.row) {
            case 0:{
                if(year > 2015)
                    movieInformationCell.enabled = YES;
                
                movieInformationCell.movieQualityLabel.text = @"Full HD";
                movieInformationCell.moviePriceLabel.text = @"R$20,00";
                movieInformationCell.movieSellCategoryLabel.text = @"Comprar";
                movieInformationCell.accessibilityLabel = @"Comprar Full HD R$20,00 VUDU";
                [movieInformationCell configCell];
                break;
            }
            case 1:{
                if(year > 2005)
                    movieInformationCell.enabled = YES;
                
                movieInformationCell.movieQualityLabel.text = @"HD";
                movieInformationCell.moviePriceLabel.text = @"R$10,00";
                movieInformationCell.movieSellCategoryLabel.text = @"Alugar: 3 Dias";
                movieInformationCell.accessibilityLabel = @"HD R$10,00 Alugar: 3 Dias VUDU";
                [movieInformationCell configCell];
                break;
            }
            case 2:{
                movieInformationCell.enabled = YES;
                movieInformationCell.movieQualityLabel.text = @"SD";
                movieInformationCell.moviePriceLabel.text = @"R$5,00";
                movieInformationCell.movieSellCategoryLabel.text = @"Alugar: 3 Dias";
                movieInformationCell.accessibilityLabel = @"SD R$5,00 Alugar: 3 Dias VUDU";
                [movieInformationCell configCell];
                break;
            }
            case 3:{
                movieInformationCell.enabled = YES;
                movieInformationCell.movieQualityLabel.text = @"SD";
                movieInformationCell.moviePriceLabel.text = @"R$20,00";
                movieInformationCell.movieSellCategoryLabel.text = @"Comprar";
                movieInformationCell.accessibilityLabel = @"Comprar SD HD R$20,00 VUDU";
                [movieInformationCell configCell];
                break;
            }
            default:
                break;
        }
    }

    
    return movieInformationCell;
}

-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView * homeReusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        SellSectionCollectionReusableView * merchantTitleSection =
        [collectionView dequeueReusableSupplementaryViewOfKind : UICollectionElementKindSectionHeader withReuseIdentifier : @ "buyMerchantSection" forIndexPath : indexPath ] ;
        if (indexPath.section == 0) {
            merchantTitleSection.lblTitle.text = @"Apple Store";
        }else{
            merchantTitleSection.lblTitle.text = @"Vudu";
        }
        
        [merchantTitleSection configCell];
        homeReusableView = merchantTitleSection;
    }
    
    return homeReusableView;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    UICollectionViewCell *datasetCell =[collectionView cellForItemAtIndexPath:indexPath];
    datasetCell.backgroundColor = [UIColor whiteColor]; // highlight selection
    _buyButton.enabled = YES;
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *datasetCell =[collectionView cellForItemAtIndexPath:indexPath];
    datasetCell.backgroundColor = [UIColor clearColor]; // Default color
}

#pragma mark movieInformationCell delegates
-(void)buyMovie{
    if(_buyButton.enabled)
        [_buyButton setBackgroundColor:[UIColor colorFromHexString:@"#9B0801"]];
    else
        [_buyButton setBackgroundColor:[UIColor colorFromHexString:@"#B7B7B7"]];
}

#pragma mark navigation controller events
-(IBAction)goBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
