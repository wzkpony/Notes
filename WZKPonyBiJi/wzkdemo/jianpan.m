//
//  jianpan.m
//  YingYuanMath
//
//  Created by 王正魁 on 14-9-28.
//  Copyright (c) 2014年 psylife. All rights reserved.
//

#import "jianpan.h"

@implementation jianpan
//@synthesize currentTextField;
-(id)init{
    if((self = [super init])) {
//        prevButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"上一项" style:UIBarButtonItemStyleBordered target:self action:@selector(showPrevious)];
//        nextButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一项" style:UIBarButtonItemStyleBordered target:self action:@selector(showNext)];
        hiddenButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"隐藏键盘" style:UIBarButtonItemStyleBordered target:self action:@selector(HiddenKeyBoard)];
        spaceButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        view = [[UIToolbar alloc] initWithFrame:CGRectMake(0,480,320,44)];
        view.barStyle = UIBarStyleBlackTranslucent;
//        view.items = [NSArray arrayWithObjects:prevButtonItem,nextButtonItem,spaceButtonItem,hiddenButtonItem,nil];
        view.items = [NSArray arrayWithObjects:hiddenButtonItem,nil];
        allowShowPreAndNext = YES;
        textFields = nil;
        isInNavigationController = YES;
        currentTextField = nil;
    }
    return self;
}
//设置是否在导航视图中
-(void)setIsInNavigationController:(BOOL)isbool{
    isInNavigationController = isbool;
}
//显示上一项
-(void)showPrevious{
    if (textFields==nil) {
        return;
    }
    NSInteger num = -1;
    for (NSInteger i=0; i<[textFields count]; i++) {
        if ([textFields objectAtIndex:i]==currentTextField) {
            num = i;
            break;
        }
    }
    if (num>0){
        [[textFields objectAtIndex:num] resignFirstResponder];
        [[textFields objectAtIndex:num-1 ] becomeFirstResponder];
        [self showBar:[textFields objectAtIndex:num-1]];
    }
}
//显示下一项
-(void)showNext{
    if (textFields==nil) {
        return;
    }
    NSInteger num = -1;
    for (NSInteger i=0; i<[textFields count]; i++) {
        if ([textFields objectAtIndex:i]==currentTextField) {
            num = i;
            break;
        }
    }
    if (num<[textFields count]-1){
        [[textFields objectAtIndex:num] resignFirstResponder];
        [[textFields objectAtIndex:num+1] becomeFirstResponder];
        [self showBar:[textFields objectAtIndex:num+1]];
    }
}
//显示工具条
-(void)showBar:(UITextField *)textField{
    currentTextField = textField;
    if (allowShowPreAndNext) {
//        [view setItems:[NSArray arrayWithObjects:prevButtonItem,nextButtonItem,spaceButtonItem,hiddenButtonItem,nil]];
           [view setItems:[NSArray arrayWithObjects:hiddenButtonItem,nil]];
    }
    else {
//        [view setItems:[NSArray arrayWithObjects:spaceButtonItem,hiddenButtonItem,nil]];
          [view setItems:[NSArray arrayWithObjects:hiddenButtonItem,nil]];
    }
//    if (textFields==nil) {
//        prevButtonItem.enabled = NO;
//        nextButtonItem.enabled = NO;
//    }
//    else {
        NSInteger num = -1;
        for (NSInteger i=0; i<[textFields count]; i++) {
            if ([textFields objectAtIndex:i]==currentTextField) {
                num = i;
                break;
            }
        }
        if (num>0) {
            prevButtonItem.enabled = YES;
        }
        else {
            prevButtonItem.enabled = NO;
        }
        if (num<[textFields count]-1) {
//            nextBut0tonItem.enabled = YES;
        }
        else {
//            nextButtonItem.enabled = NO;
        }
//    }
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    if (isInNavigationController) {
        view.frame = CGRectMake(0, 201-40, withs, 44);
    }
    else {
        view.frame = CGRectMake(0, 201, withs, 44);
    }
    [UIView commitAnimations];
}
//设置输入框数组
-(void)setTextFieldsArray:(NSArray *)array{
    textFields = array;
}
//设置是否显示上一项和下一项按钮
-(void)setAllowShowPreAndNext:(BOOL)isShow{
    allowShowPreAndNext = isShow;
}
//隐藏键盘和工具条
-(void)HiddenKeyBoard{
    if (currentTextField!=nil) {
        [currentTextField  resignFirstResponder];
    }
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    view.frame = CGRectMake(0,heights, withs, 44);
    [UIView commitAnimations];
}

/*键盘遮挡高度
 *
 *
 -(void)sureKeyBoardShow:(NSNotification *)noti{
 //获取通知键盘信息的值
 NSValue *value=[noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
 //根据键盘的信息值获取坐标CGRect值
 CGRect frame=[value CGRectValue];
 //获取键盘出现动画的时间
 NSNumber * duration=[noti.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
 NSNumber *curve=[noti.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
 
 CGRect keyboardFrame = [self.view convertRect:frame fromView:nil];
 
 CGRect textFrame=tempText.frame;
 
 //获取键盘遮住的高度
 float th=textFrame.origin.y+textFrame.size.height-(748.0-keyboardFrame.size.height);
 //如果大于0则让他上升
 if (th>0.0) {
 [self changeView:th duration:duration curve:curve];
 }
 
 }
 -(void)sureKeyBoardHide:(NSNotification *)noti{
 NSNumber * duration=[noti.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];//动画的持续时间
 NSNumber *curve=[noti.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];//键盘尺寸大小
 //将键盘的尺寸和时间传了过去
 [self changeView:0.0 duration:duration curve:curve];
 }
 -(void)textFieldDidBeginEditing:(UITextField *)textField{
 
 tempText=textField;
 
 }
 -(void)changeView:(float)h  duration:(NSNumber *)d curve:(NSNumber *)c{
 [UIView beginAnimations:@"BGCHANGELogin" context:nil];
 [UIView setAnimationDuration:[d floatValue]];
 [UIView setAnimationCurve:[c floatValue]];
 CGRect bounds=self.view.bounds;
 bounds.origin.y=-h;
 self.view.frame=bounds;
 [UIView commitAnimations];
 }
 -(void)viewDidAppear:(BOOL)animated{
 [super viewDidAppear:animated];
 //键盘刚要出来的是的通知方法
 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sureKeyBoardShow:) name:UIKeyboardDidShowNotification object:nil];
 //键盘将要下去的方法
 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sureKeyBoardHide:) name:UIKeyboardDidHideNotification object:nil];
 }

 *
 *
 *
 */


@end
