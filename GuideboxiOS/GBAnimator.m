//
//  GBAnimator.m
//  GuideboxiOS
//
//  Created by Ezequiel Thomazetto on 12/09/16.
//  Copyright © 2016 Ezequiel Thomazetto. All rights reserved.
//

#import "GBAnimator.h"
#define kTransitionDuration 0.27

@implementation GBAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return kTransitionDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* toController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIViewController* fromController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView* container = [transitionContext containerView];
    
    toController.view.alpha = 0.0f;
    [container addSubview:toController.view];
    
    [UIView animateWithDuration:kTransitionDuration animations:^{
        toController.view.alpha = 1.0f;
    } completion:^(BOOL finished){
        [fromController.view removeFromSuperview];
        [transitionContext completeTransition:finished];
    }];
}

@end
