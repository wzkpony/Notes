//
//  Header.h
//  Text
//
//  Created by 王正魁 on 14-7-4.
//  Copyright (c) 2014年 Psylife_iMac02. All rights reserved.
//

#ifndef Text_Header_h
#define Text_Header_h
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IsIOS7 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=7)
#include "Header.h"
#import "Most.h"
#import "OtherModel.h"
#import "AnimationForMe.h"


#endif
