//
//  UIDevice+Hardware.m
//  NewCode
//
//  Created by 王正魁 on 14-4-29.
//  Copyright (c) 2014年 psylife. All rights reserved.
//

#import "UIDevice+Hardware.h"
#include <sys/types.h>
#include <sys/sysctl.h>
@implementation UIDevice (Hardware)
+(NSString*)getSysInfoVyName:(char*)typeSpecifier
{
    size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    char* answer = malloc(size);
    NSString* results = [NSString stringWithCString:answer encoding:NSUTF8StringEncoding];
    free(answer);
    return results;
}
-(NSString* )platform
{
    NSLog(@"%@",[UIDevice getSysInfoVyName:"hw.machine"]);
    return[UIDevice getSysInfoVyName:"hw.machine"];
}
+(NSUInteger)getSysInfo:(uint)typeSpecifier
{
    size_t size = sizeof(int);
    int results;
    int mib[2] = {CTL_HW,typeSpecifier};
    sysctl(mib,2,&results,&size,NULL,0);
    return(NSUInteger)results;
}
-(NSUInteger)cpuFrequecy
{
    return [UIDevice getSysInfo:HW_CPU_FREQ];
}
-(NSInteger)busFrequency
{
    return [UIDevice getSysInfo:HW_BUS_FREQ];
}
-(NSUInteger)totalMemory
{
    return [UIDevice getSysInfo:HW_PHYSMEM];
}
-(NSUInteger)userMemory
{
    return [UIDevice getSysInfo:HW_USERMEM];
}
-(NSUInteger)maxSocketBufferSize
{
    return [UIDevice getSysInfo:KIPC_MAXSOCKBUF];
}
@end
