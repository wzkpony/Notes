//
//  test.h
//  WZKPonyBiJi
//
//  Created by 王正魁 on 15-3-17.
//  Copyright (c) 2015年 psylife. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface test : NSObject
@property(nonatomic,assign)id delegate;
@end
@protocol testDelegate <NSObject>

-(void)gong;

@end