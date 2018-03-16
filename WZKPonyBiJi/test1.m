//
//  test1.m
//  WZKPonyBiJi
//
//  Created by 王正魁 on 15-3-17.
//  Copyright (c) 2015年 psylife. All rights reserved.
//

#import "test1.h"

@interface test1()
{
    
}
@end
@implementation test1
/*
 - (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
 
 */

-(void)testxxx
{
    test* ts = [[test alloc] init];
    ts.delegate = self;
    
    [self tableView:nil willDisplayCell:nil forRowAtIndexPath:nil];
    
}
- (void)firstMethod
{
    NSLog(@"协议方法1");
    
}
- (void)secondMethod
{
    NSLog(@"协议方法2");
}
-(void)gong
{
    NSLog(@"代理方法的实现");
}
@end
