//
//  GBButton.h
//  GuideboxiOS
//
//  Created by Ezequiel Thomazetto on 09/09/16.
//  Copyright © 2016 Ezequiel Thomazetto. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface GBButton : UIButton

/**
 Flag para habilitar ou desabilitar o botão.
 */
@property (nonatomic) IBInspectable BOOL enable;

@end
