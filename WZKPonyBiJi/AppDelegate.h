//
//  AppDelegate.h
//  WZKPonyBiJi
//
//  Created by 王正魁 on 15-3-14.
//  Copyright (c) 2015年 psylife. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "NavControllerDelegate.h"
#import "DDMenuController.h"
#import "MainViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong)DDMenuController* menu;
@property(strong,nonatomic)MainViewController* main;
@property(copy,nonatomic)NSString* leibeis;
-(void)removeImages;

-(void)jianCeTongZhi;
-(void)naozhong:(NSInteger)inter withContent:(NSString*)content;
@end

