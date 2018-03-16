//
//  SwipeUpInteractiveTransition.h
//  WZKPonyBiJi
//
//  Created by 王正魁 on 15-3-20.
//  Copyright (c) 2015年 psylife. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwipeUpInteractiveTransition : UIPercentDrivenInteractiveTransition
@property (nonatomic, assign) BOOL interacting;

- (void)wireToViewController:(UIViewController*)viewController;

@end
