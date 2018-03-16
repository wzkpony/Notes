//
//  NSURLConnection+WZKConnection.m
//  WZKPony
//
//  Created by 王正魁 on 15-1-5.
//  Copyright (c) 2015年 psylife. All rights reserved.
//
//objc_getAssociatedObject是runtime的方法，会根据self找到self对的类（也就是NSURLConnection）  &strAddrKey是内存地址，也可以是SEL，SEL其主要作用是快速的通过方法名字（makeText）查找到对应方法的函数指针，然后调用其函 数。SEL其本身是一个Int类型的一个地址，地址中存放着方法的名字




#import "NSURLConnection+WZKConnection.h"
#import <objc/runtime.h>
@implementation NSURLConnection (WZKConnection)
static char strAddrKey = 'a';

- (NSString *)addr
{
    return objc_getAssociatedObject(self, &strAddrKey);
}

- (void)setAddr:(NSString *)addr
{
    objc_setAssociatedObject(self, &strAddrKey, addr, OBJC_ASSOCIATION_COPY_NONATOMIC);//OBJC_ASSOCIATION_COPY_NONATOMIC  : 指定相关的对象
}

@end
