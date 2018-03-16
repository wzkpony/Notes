//
//  UIDevice+Hardware.h
//  NewCode
//
//  Created by 王正魁 on 14-4-29.
//  Copyright (c) 2014年 psylife. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <>
@interface UIDevice (Hardware)
+(NSString*)getSysInfoVyName:(char*)typeSpecifier;
-(NSString* )platform;
-(NSUInteger)getSysInfo:(uint)typeSpecifier;
-(NSUInteger)cpuFrequecy;
-(NSInteger)busFrequency;
-(NSUInteger)totalMemory;
-(NSUInteger)userMemory;
-(NSUInteger)maxSocketBufferSize;
@end
