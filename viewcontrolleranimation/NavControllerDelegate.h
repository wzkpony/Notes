//
//  NavControllerDelegate.h
//  WZKPonyBiJi
//
//  Created by 王正魁 on 15-3-17.
//  Copyright (c) 2015年 psylife. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Animator.h"
#import "Animations.h"
#import <UIKit/UIKit.h>
typedef enum
{
    //以下是枚举成员
    TestA = 0,//缩小渐变
    TestB,//下退渐变
    
    
}animationType;
@interface NavControllerDelegate : NSObject <UINavigationControllerDelegate,UIViewControllerTransitioningDelegate>
+ (NavControllerDelegate *) sharedInstance;
@property (strong, nonatomic) IBOutlet UINavigationController *navigationController;
@property(nonatomic,strong)UIPinchGestureRecognizer *pinchRecognizer;
@property (nonatomic, assign) animationType animationForTransition;
-(void)addtag;
@end
/*
 NavControllerDelegate* nav = [NavControllerDelegate sharedInstance];//初始化导航控制器动画
 MainViewController* main = [[MainViewController alloc] init];
 nav.navigationController = [[UINavigationController alloc] initWithRootViewController:main];//常见有动画的导航控制器
 [nav addtag];//将动画和手势加到导航控制器上
 */