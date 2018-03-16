//
//  Animations.m
//  WZKPonyBiJi
//
//  Created by 王正魁 on 15-3-17.
//  Copyright (c) 2015年 psylife. All rights reserved.
//

#import "Animations.h"

@implementation Animations
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.35;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [[transitionContext containerView] addSubview:toViewController.view];
    toViewController.view.alpha = 0;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
//        fromViewController.view.transform = CGAffineTransformMakeRotation(M_PI/2);//旋转
        fromViewController.view.transform = CGAffineTransformMakeTranslation(0,fromViewController.view.frame.size.height);
        toViewController.view.alpha = 1;
    } completion:^(BOOL finished) {
        fromViewController.view.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
    }];
    
}
@end
