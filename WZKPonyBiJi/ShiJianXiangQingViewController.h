//
//  ShiJianXiangQingViewController.h
//  WZKPonyBiJi
//
//  Created by 王正魁 on 15-5-4.
//  Copyright (c) 2015年 psylife. All rights reserved.
//

#import "BaseViewController.h"
#import "UIImageView+WebCache.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "BigImageViewController.h"
#import "WZKPlayViewController.h"
#import "LeiBieDao.h"
#import <MediaPlayer/MediaPlayer.h>
@interface ShiJianXiangQingViewController : BaseViewController<CHTCollectionViewDelegateWaterfallLayout>
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property(nonatomic,copy)NSString* stringNeiRong;
@property(nonatomic,copy)NSString* stringTitle;
@property(nonatomic,copy)NSString* stringLeiBie;
@end
