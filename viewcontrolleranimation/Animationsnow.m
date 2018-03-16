//
//  Animations1.m
//  WZKPonyBiJi
//
//  Created by 王正魁 on 15-5-4.
//  Copyright (c) 2015年 psylife. All rights reserved.
//

#import "Animationsnow.h"

@implementation Animationsnow
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
    toViewController.view.transform = CGAffineTransformMakeScale(0.1,0.1);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        //        fromViewController.view.transform = CGAffineTransformMakeRotation(M_PI/2);//旋转
        //        fromViewController.view.transform = CGAffineTransformMakeTranslation(0,fromViewController.view.frame.size.height);
        fromViewController.view.transform = CGAffineTransformMakeScale(2,2);
        
        toViewController.view.alpha = 1;
        toViewController.view.transform = CGAffineTransformMakeScale(1,1);
    } completion:^(BOOL finished) {
        fromViewController.view.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
    }];
    
}
@end
