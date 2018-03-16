//
//  WZKTest.h
//  WZKPonyBiJi
//
//  Created by 王正魁 on 15-3-23.
//  Copyright (c) 2015年 psylife. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface WZKTest : UIView
/*
  self.lableCount.attributedText = [self filterLinkWithContent:@"我是王正魁http://123456789，@haha567哈哈，<《“测试测试”》>，——ooo——有一个网址：wwww.JohnnyLiu.com有一个电话：15310547654 2014-12-30还有一个地址：大屯路. tel:112345678998"];
 */
- (NSMutableAttributedString *)filterLinkWithContent:(NSString *)content;
@end
