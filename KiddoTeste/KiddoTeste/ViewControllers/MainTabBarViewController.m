//
//  MainTabBarViewController.m
//  KiddoTeste
//
//  Created by Aloisio Mello on 19/02/18.
//  Copyright © 2018 Aloisio Mello. All rights reserved.
//

#import "MainTabBarViewController.h"

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configTabBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configTabBar{
    UITabBarItem * homeButton = (UITabBarItem*)[self.tabBar.items objectAtIndex:0];
    UIImage * imageHomeSelected = [[UIImage imageNamed:@"ic-home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * imageHomeUnselected = [[UIImage imageNamed:@"ic-home-disabled"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [homeButton setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorFromHexString:@"#9B0801"]} forState:UIControlStateSelected];
    [homeButton setImage:imageHomeUnselected];
    [homeButton setSelectedImage:imageHomeSelected];
    
    UITabBarItem * favButton = (UITabBarItem*)[self.tabBar.items objectAtIndex:1];
    UIImage * imageFavSelected = [[UIImage imageNamed:@"ic-fav"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * imageFavUnselected = [[UIImage imageNamed:@"ic-fav-disabled"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [favButton setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorFromHexString:@"#9B0801"]} forState:UIControlStateSelected];
    [favButton setImage:imageFavUnselected];
    [favButton setSelectedImage:imageFavSelected];
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
