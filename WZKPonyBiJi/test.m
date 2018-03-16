//
//  test.m
//  WZKPonyBiJi
//
//  Created by 王正魁 on 15-3-17.
//  Copyright (c) 2015年 psylife. All rights reserved.
//

#import "test.h"

@implementation test
-(void)tagst
{
    if ([self.delegate respondsToSelector:@selector(gong)]) {
        NSLog(@"代理中的调用");
    }
}
@end
