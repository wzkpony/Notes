//
//  EvenForLeiBieTableViewCell.h
//  WZKPonyBiJi
//
//  Created by 王正魁 on 15-4-1.
//  Copyright (c) 2015年 psylife. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EvenForLeiBieTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *evenName;
@property (strong, nonatomic) IBOutlet UILabel *evenContext;
@property (strong, nonatomic) IBOutlet UILabel *evenTime;
@property (strong, nonatomic) IBOutlet UIImageView *imageForImage;
@property (strong, nonatomic) IBOutlet UIButton *Labelgengduo;
-(void)buju;
@end
