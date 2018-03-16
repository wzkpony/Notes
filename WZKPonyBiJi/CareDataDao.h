//
//  CareDataDao.h
//  OldHome
//
//  Created by macbook007 on 14-2-26.
//  Copyright (c) 2014年 psylife. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CareData.h"
@interface CareDataDao : NSObject
+(void)insertWithCareID:(NSString* )CareID withTabID:(NSString* )TabID withNo:(int)No withSubTabID:(NSString*)SubTabID withSubNo:(int)SubNo withValue:(NSString*)Value withModifyState:(int)ModifyState withUploadFlag:(int)UploadFlag withstringRecID:(NSString* )reid;
+(NSArray* )getWithNString:(int)name;
+(void)deletewithstring:(NSString* )string;
+(void)deletewithstringall;
+(void)updateWithCareid:(NSString*)careid;
+(void)deletewithstringcare:(NSString* )CareID;
+(void)updateWithTabID:(NSString*)TabID;

@end
