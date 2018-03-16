//
//  jianpan.h
//  YingYuanMath
//
//  Created by 王正魁 on 14-9-28.
//  Copyright (c) 2014年 psylife. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "jianpan.h"
#define withs [UIScreen mainScreen].bounds.size.width
#define heights [UIScreen mainScreen].bounds.size.height
@interface jianpan : NSObject
{
    UIToolbar       *view;                       //工具条
    NSArray         *textFields;                 //输入框数组
    BOOL            allowShowPreAndNext;         //是否显示上一项、下一项
    BOOL            isInNavigationController;    //是否在导航视图中
    UIBarButtonItem *prevButtonItem;             //上一项按钮
    UIBarButtonItem *nextButtonItem;             //下一项按钮
    UIBarButtonItem *hiddenButtonItem;           //隐藏按钮
    UIBarButtonItem *spaceButtonItem;            //空白按钮
    UITextField     *currentTextField;           //当前输入框
}
@property(nonatomic,retain) UIToolbar *view;
@property(nonatomic,retain) UIToolbar *currentTextField;

-(id)init;
-(void)setAllowShowPreAndNext:(BOOL)isShow;//设置是否显示上一项和下一项按钮
-(void)setIsInNavigationController:(BOOL)isbool;//设置是否在导航视图中
-(void)setTextFieldsArray:(NSArray *)array;//设置输入框数组
-(void)showPrevious;//显示上一项
-(void)showNext;//显示下一项
-(void)showBar:(UITextField *)textField;//显示工具条
-(void)HiddenKeyBoard;//隐藏键盘和工具条
@end
