//
//  MainViewController.h
//  WZKPonyBiJi
//
//  Created by 王正魁 on 15-3-14.
//  Copyright (c) 2015年 psylife. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "test.h"
#import "NextViewController.h"
#import "TestViewController.h"
#import "BaseViewController.h"
#import "LeiBieDao.h"
#import "Most.h"
#define withs [UIScreen mainScreen].bounds.size.width
#define heights [UIScreen mainScreen].bounds.size.height
//#import "Area.h"
//#import "CameraCalibration.h"
@interface MainViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSArray      *keys;
}
- (IBAction)buttonTest:(id)sender;
@property (nonatomic, retain) NSArray *keys;
@end
