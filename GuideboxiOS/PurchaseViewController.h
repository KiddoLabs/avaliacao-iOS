//
//  PurchaseViewController.h
//  GuideboxiOS
//
//  Created by Ezequiel Thomazetto on 08/09/16.
//  Copyright © 2016 Ezequiel Thomazetto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PurchaseSource.h"

@interface PurchaseViewController : UIViewController

@property (nonatomic, strong) NSArray *purchaseSources;
@property (nonatomic, strong) NSURL *thumbnailURL;

@end
