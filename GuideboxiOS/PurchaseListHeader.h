//
//  PurchaseListHeader.h
//  GuideboxiOS
//
//  Created by Ezequiel Thomazetto on 11/09/16.
//  Copyright © 2016 Ezequiel Thomazetto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PurchaseListHeader : UICollectionReusableView

/**
 Label referente ao nome da fonte de compra.
 */
@property (weak, nonatomic) IBOutlet UILabel *purchaseSourceNameLabel;

@end
