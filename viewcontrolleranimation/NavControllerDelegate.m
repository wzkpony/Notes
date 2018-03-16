//
//  NavControllerDelegate.m
//  WZKPonyBiJi
//
//  Created by 王正魁 on 15-3-17.
//  Copyright (c) 2015年 psylife. All rights reserved.
//

#import "NavControllerDelegate.h"

@interface NavControllerDelegate ()
{
    CGFloat _startScale;
}
@property (strong, nonatomic) Animator* animator;
@property (strong, nonatomic) Animations* animatorBack;
@property (strong, nonatomic) UIPercentDrivenInteractiveTransition* interactionController;

@end
@implementation NavControllerDelegate
static NavControllerDelegate * sharedSingleton = nil;

+ (NavControllerDelegate *) sharedInstance
{
    if (sharedSingleton == nil) {
        sharedSingleton = [[NavControllerDelegate alloc] init];
      
    }
    return sharedSingleton;
}
-(void)addtag
{
    UIPanGestureRecognizer* panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.navigationController.view addGestureRecognizer:panRecognizer];
    
    _pinchRecognizer = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(handlePinch:)];
    
    [self.navigationController.view addGestureRecognizer:_pinchRecognizer];
    
    
    self.navigationController.delegate = self;
    self.animator = [Animator new];
    self.animatorBack = [Animations new];
}
-(void)handlePinch:(UIPinchGestureRecognizer *)pinch {
    CGFloat scale = pinch.scale;
    switch (pinch.state) {
        case UIGestureRecognizerStateBegan: {
            self.interactionController = [UIPercentDrivenInteractiveTransition new];
            _startScale = scale;
            //            [self.interactionController isInteractive];
            if (self.navigationController.viewControllers.count > 1) {
                [self.navigationController popViewControllerAnimated:YES];
            }
            
            break;
        }
        case UIGestureRecognizerStateChanged: {
            CGFloat percent = (1.0 - scale/_startScale);
            [self.interactionController updateInteractiveTransition:(percent < 0.0) ?
             0.0 : percent];
            break;
        }
        case UIGestureRecognizerStateEnded: {
            CGFloat percent = (1.0 - scale/_startScale);
            BOOL cancelled = ([pinch velocity] < 5.0 && percent
                              <= 0.3);
            if (cancelled)
            {
                [self.interactionController cancelInteractiveTransition];
            }
            else
            {
                [self.interactionController finishInteractiveTransition];
            }
            self.interactionController = nil;
            break;
        }
        case UIGestureRecognizerStateCancelled: {
            CGFloat percent = (1.0 - scale/_startScale);
            BOOL cancelled = ([pinch velocity] < 5.0 && percent
                              <= 0.3);
            if (cancelled) {
                [self.interactionController cancelInteractiveTransition];
            }
            else{
                [self.interactionController finishInteractiveTransition];
            }
            self.interactionController = nil;
            break;
        }
    }
}

- (void)pan:(UIPanGestureRecognizer*)recognizer
{
    UIView* view = self.navigationController.view;
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint location = [recognizer locationInView:view];
        if (location.x <  CGRectGetMidX(view.bounds) && self.navigationController.viewControllers.count > 1) { // left half
            self.interactionController = [UIPercentDrivenInteractiveTransition new];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else if (location.x <  CGRectGetMaxX(view.bounds) && self.navigationController.viewControllers.count > 1)
        {
            self.interactionController = [UIPercentDrivenInteractiveTransition new];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else
        if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [recognizer translationInView:view];
        CGFloat d = fabs(translation.x / CGRectGetWidth(view.bounds));
        [self.interactionController updateInteractiveTransition:d];
    } else
        if (recognizer.state == UIGestureRecognizerStateEnded) {
        if ([recognizer velocityInView:view].x > 0) {
            [self.interactionController finishInteractiveTransition];
        } else {
            [self.interactionController cancelInteractiveTransition];
        }
        self.interactionController = nil;
    }
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPop) {
        
//        [self selectAnimation];
        return self.animator;
    }
    if (operation == UINavigationControllerOperationPush) {
//        [self selectAnimation];
        return self.animatorBack;
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return self.interactionController;
}
-(id<UIViewControllerAnimatedTransitioning>)selectAnimation
{
    switch (self.animationForTransition) {
        case TestA:
            return self.animator;
            break;
        case TestB:
            return self.animatorBack;
            break;
            
        default:
            return nil;
            break;
    }
}

/*
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return self.animator;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self.animatorBack;
}
*/

@end
