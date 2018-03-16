//
//  LeiBieDao.h
//  WZKPonyBiJi
//
//  Created by 王正魁 on 15-4-10.
//  Copyright (c) 2015年 psylife. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LeiBie.h"
@interface LeiBieDao : NSObject
+(NSArray* )getAllNameWithNStringTableName:(NSString*)tablename;//查询表事件
+(void)insertWithName:(NSString*)name withTime:(NSString*)time withTableName:(NSString*)tablename withUserName:(NSString*)username withShiJianXiaDeLeiBieName:(NSString*)leibeiname withTiXing:(NSString*)stringBool;//添加事件（类别）
+(NSArray* )getChongNameWithNStringTableName:(NSString*)tablename withName:(NSString* )names withUsers:(NSString*)users withLeiBieName:(NSString*)leibiename;//查询事件（类别）是否有重名的



+(NSArray* )getLeiBieXiaDeNameWithNStringTableName:(NSString*)tablename withUsers:(NSString*)users withLeiBieName:(NSString*)leibiename;//查询类别下的事件



+(NSArray* )getTimesNameWithNStringTableName:(NSString*)tablename withUsers:(NSString*)users withLeiBieName:(NSString*)leibiename withTime:(NSString*)stringtime;//根据事件获取类别和事件




+(NSArray* )getQianTimesNameWithNStringTableName:(NSString*)tablename withUsers:(NSString*)users withLeiBieName:(NSString*)leibiename withTime:(NSString*)stringtime;//shijian过去
+(NSArray* )getWeiLaiTimesNameWithNStringTableName:(NSString*)tablename withUsers:(NSString*)users withLeiBieName:(NSString*)leibiename withTime:(NSString*)stringtime;//未来



+(NSArray* )getAllTiXingNameWithNStringTableName:(NSString*)tablename withTiXingFol:(NSString*)tixing;//获取提醒内容



+(NSArray* )getTimeTableName:(NSString*)tablename withName:(NSString*)name;//获取事件的时间
@end
