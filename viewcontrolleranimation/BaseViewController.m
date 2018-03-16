//
//  BaseViewController.m
//  WZKPonyBiJi
//
//  Created by 王正魁 on 15-3-20.
//  Copyright (c) 2015年 psylife. All rights reserved.
//

#import "BaseViewController.h"
#import "SwipeUpInteractiveTransition.h"
#import "BigImageViewController.h"
#import "ImageAnimationShow.h"
#import "ShiJianXiangQingViewController.h"
@interface BaseViewController ()
@property (strong, nonatomic) UIPercentDrivenInteractiveTransition* interactionController;
//@property (nonatomic, strong) NormalDismissAnimation *dismissAnimation;


@property (nonatomic, strong) ImageAnimationShow *showImage;
@end

@implementation BaseViewController
//- (instancetype)initWithViewController:(UIViewController*)coller
//{
//    self.transitioningDelegate = coller;
//    return self;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.frame = CGRectMake(0, 0, withs, heights);
    self.animator = [Animator new];
    self.animatorBack = [Animations new];
    self.animatornow = [Animatornow new];
    self.animatorBacknow = [Animationsnow new];
    self.showImage = [ImageAnimationShow new];
//    if (self.shoushi == YES) {
        UIPanGestureRecognizer* panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
        [self.view addGestureRecognizer:panRecognizer];
//    }
//     self.view.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin;
    self.view.autoresizesSubviews = YES;
}
-(void)panGestureAction:(UIPanGestureRecognizer *)gesture{
    
    CGPoint translation = [gesture translationInView:self.view];
    switch (gesture.state) {
        case  UIGestureRecognizerStateBegan:
        {
            self.interactionController = [UIPercentDrivenInteractiveTransition new];
        }
        case UIGestureRecognizerStateChanged:{
            //1
            
            CGFloat d = fabs(translation.x / CGRectGetWidth(self.view.bounds));
            [self.interactionController updateInteractiveTransition:d];
            
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:{
            //2
            if (gesture.state == UIGestureRecognizerStateCancelled) {
                  self.interactionController = [UIPercentDrivenInteractiveTransition new];
                [self.interactionController cancelInteractiveTransition];
            }else{
                  self.interactionController = [UIPercentDrivenInteractiveTransition new];
                [self.interactionController finishInteractiveTransition];
            }
            break;
        }
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    
//    return self.transitionController.interacting ?self.animator:nil;
    if ([presented isKindOfClass:[BigImageViewController class]]) {
        return self.showImage;
    }
    if ([presented isKindOfClass:[ShiJianXiangQingViewController class]]) {
        return self.animatorBacknow;
    }
    return self.animator;
}
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    if ([dismissed isKindOfClass:[BigImageViewController class]]) {
        return self.showImage;
    }
    if ([dismissed isKindOfClass:[ShiJianXiangQingViewController class]]) {
        return self.animatornow;
    }
    return self.animatorBack;
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
