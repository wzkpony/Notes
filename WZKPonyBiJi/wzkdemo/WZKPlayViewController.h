//
//  WZKPlayViewController.h
//  LTSYActionDemo
//
//  Created by 王正魁 on 14-7-23.
//  Copyright (c) 2014年 Psylife. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#define withs [UIScreen mainScreen].bounds.size.width
#define heights [UIScreen mainScreen].bounds.size.height
@interface WZKPlayViewController : UIViewController
{
     MPMoviePlayerController* mp;

}
@property (copy, nonatomic)  NSString *stringWithUrl;
@property(nonatomic,assign)BOOL type;
@property(nonatomic,copy)void (^block)(void);
@end
