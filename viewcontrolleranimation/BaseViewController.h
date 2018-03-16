//
//  BaseViewController.h
//  WZKPonyBiJi
//
//  Created by 王正魁 on 15-3-20.
//  Copyright (c) 2015年 psylife. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Animations.h"
#import "Animator.h"
#import "OtherModel.h"
#import "Animatornow.h"
#import "Animationsnow.h"
#define soundID 1117
@interface BaseViewController : UIViewController<UIViewControllerTransitioningDelegate,UIViewControllerInteractiveTransitioning>
@property(nonatomic,strong)Animator*  animator;
@property(nonatomic,strong)Animations*  animatorBack;

@property(nonatomic,strong)Animatornow*  animatornow;
@property(nonatomic,strong)Animationsnow*  animatorBacknow;

@property(nonatomic,assign)BOOL shoushi;


//- (instancetype)initWithViewController:(UIViewController*)coller;

@end
