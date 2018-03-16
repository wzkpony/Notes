//
//  BigImageViewController.h
//  WZKPonyBiJi
//
//  Created by 王正魁 on 15-3-31.
//  Copyright (c) 2015年 psylife. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface BigImageViewController : BaseViewController<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *images;
@property(nonatomic,strong)UIImage* image_;
@end
