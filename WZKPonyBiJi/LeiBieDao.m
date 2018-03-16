//
//  LeiBieDao.m
//  WZKPonyBiJi
//
//  Created by 王正魁 on 15-4-10.
//  Copyright (c) 2015年 psylife. All rights reserved.
//

#import "LeiBieDao.h"

@implementation LeiBieDao
+(NSString* )getDBPath
{
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    
    return [path stringByAppendingPathComponent:@"test.sqlite"];
    
}
+(NSArray* )getAllNameWithNStringTableName:(NSString*)tablename//得到表中所有的内容
{
    FMDatabase* DB = [FMDatabase databaseWithPath:[self getDBPath]];
    if (![DB open]) {
        [DB close];
        NSAssert(NO, @"数据库为空！");
        return nil;
    }
    if (![DB tableExists:tablename])
    {
        [DB close];
//        NSAssert(NO, @"表不存在");
        return Nil;
        
    }
    NSString* stirng = [NSString stringWithFormat:@"select * from %@ ORDER BY id DESC",tablename];
    FMResultSet* re = [DB executeQuery:stirng];
    NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:0];
    while ([re next]) {
        LeiBie* ca = [[LeiBie alloc] init];
        ca.name = [re stringForColumn:@"name"] ;
        ca.timess = [re stringForColumn:@"timed"];
        ca.leibie = [re stringForColumn:@"leibies"];
        [array addObject:ca];
    }
    
    [re close];
    [DB close];
    return array;
}
+(NSArray* )getChongNameWithNStringTableName:(NSString*)tablename withName:(NSString* )names withUsers:(NSString*)users withLeiBieName:(NSString*)leibiename//判断是否重名
{
    FMDatabase* DB = [FMDatabase databaseWithPath:[self getDBPath]];
    if (![DB open]) {
        [DB close];
        NSAssert(NO, @"数据库为空！");
        return nil;
    }
    if (![DB tableExists:tablename])
    {
        [DB close];
//        NSAssert(NO, @"表不存在");
        return Nil;
        
    }
    NSString* stirng = [NSString stringWithFormat:@"select * from %@ where name = \"%@\" and leibies = \"%@\" and users = \"%@\" ORDER BY id DESC",tablename,names,leibiename,users];//判断事件是否重名
    if ([tablename isEqualToString:@"leibie"]) {
        stirng = [NSString stringWithFormat:@"select * from %@ where name = \"%@\" and users = \"%@\" ORDER BY id DESC",tablename,names,users];//判断类别是否重名
    }
    FMResultSet* re = [DB executeQuery:stirng];
    NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:0];
    while ([re next]) {
        LeiBie* ca = [[LeiBie alloc] init];
        ca.name = [re stringForColumn:@"name"] ;
        ca.timess = [re stringForColumn:@"timed"];
        ca.leibie = [re stringForColumn:@"leibies"];
        [array addObject:ca];
    }
    
    [re close];
    [DB close];
    return array;
}
+(NSArray* )getLeiBieXiaDeNameWithNStringTableName:(NSString*)tablename withUsers:(NSString*)users withLeiBieName:(NSString*)leibiename
{
    FMDatabase* DB = [FMDatabase databaseWithPath:[self getDBPath]];
    if (![DB open]) {
        [DB close];
        NSAssert(NO, @"数据库为空！");
        return nil;
    }
    if (![DB tableExists:tablename])
    {
        [DB close];
//        NSAssert(NO, @"表不存在");
        return Nil;
    }
    NSString* stirng = [NSString stringWithFormat:@"select * from %@ where leibies = \"%@\" and users = \"%@\"ORDER BY id DESC",tablename,leibiename,users];//查询用户下的－－类别下的－－事件
    //查询用户下的－－类别
    if([tablename isEqualToString:@"leibie"]){
        stirng = [NSString stringWithFormat:@"select * from %@ where users = \"%@\"ORDER BY id DESC",tablename,users];
    }
    FMResultSet* re = [DB executeQuery:stirng];
    NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:0];
    while ([re next]) {
        LeiBie* ca = [[LeiBie alloc] init];
        ca.name = [re stringForColumn:@"name"] ;
        ca.timess = [re stringForColumn:@"timed"];
        ca.leibie = [re stringForColumn:@"leibies"];
        [array addObject:ca];
    }
    
    [re close];
    [DB close];
    return array;
}


+(NSArray* )getTimesNameWithNStringTableName:(NSString*)tablename withUsers:(NSString*)users withLeiBieName:(NSString*)leibiename withTime:(NSString*)stringtime
{
    NSString* path = [self getDBPath];
    FMDatabase* DB = [FMDatabase databaseWithPath:path];
    if (![DB open]) {
        [DB close];
        NSAssert(NO, @"数据库为空！");
        return nil;
    }
    if (![DB tableExists:tablename])
    {
        [DB close];
//        NSAssert(NO, @"表不存在");
        return Nil;
    }
    NSString* stirng = [NSString stringWithFormat:@"select * from %@ where date(timed) =  date( 'now','localtime') and users = \"%@\"ORDER BY id DESC",tablename,users];
    //查询用户下的－－类别   date(timed) =  date( 'now','localtime')
    if([tablename isEqualToString:@"leibie"]){
        stirng = [NSString stringWithFormat:@"select * from %@ where date(timed) =  date( 'now','localtime') and users = \"%@\"ORDER BY id DESC",tablename,users];
    }
    FMResultSet* re = [DB executeQuery:stirng];
    NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:0];
    while ([re next]) {
        LeiBie* ca = [[LeiBie alloc] init];
        ca.name = [re stringForColumn:@"name"] ;
        ca.timess = [re stringForColumn:@"timed"];
        ca.leibie = [re stringForColumn:@"leibies"];
        [array addObject:ca];
    }
    [re close];
    [DB close];
    return array;
}
//过去
+(NSArray* )getQianTimesNameWithNStringTableName:(NSString*)tablename withUsers:(NSString*)users withLeiBieName:(NSString*)leibiename withTime:(NSString*)stringtime
{
    FMDatabase* DB = [FMDatabase databaseWithPath:[self getDBPath]];
    if (![DB open]) {
        [DB close];
        NSAssert(NO, @"数据库为空！");
        return nil;
    }
    if (![DB tableExists:tablename])
    {
        [DB close];
//        NSAssert(NO, @"表不存在");
        return Nil;
    }
    NSString* stirng = [NSString stringWithFormat:@"select * from %@ where leibies = \"%@\" and users = \"%@\"ORDER BY id DESC",tablename,leibiename,users];
    if([tablename isEqualToString:@"shijan"]){
        stirng = [NSString stringWithFormat:@"select * from %@ where date(timed) <  date( 'now','localtime') and users = \"%@\"ORDER BY id DESC",tablename,users];
    }
    FMResultSet* re = [DB executeQuery:stirng];
    NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:0];
    while ([re next]) {
        LeiBie* ca = [[LeiBie alloc] init];
        ca.name = [re stringForColumn:@"name"] ;
        ca.timess = [re stringForColumn:@"timed"];
        ca.leibie = [re stringForColumn:@"leibies"];
        [array addObject:ca];
    }
    
    [re close];
    [DB close];
    return array;
}
//未来
+(NSArray* )getWeiLaiTimesNameWithNStringTableName:(NSString*)tablename withUsers:(NSString*)users withLeiBieName:(NSString*)leibiename withTime:(NSString*)stringtime
{
    FMDatabase* DB = [FMDatabase databaseWithPath:[self getDBPath]];
    if (![DB open]) {
        [DB close];
        NSAssert(NO, @"数据库为空！");
        return nil;
    }
    if (![DB tableExists:tablename])
    {
        [DB close];
//        NSAssert(NO, @"表不存在");
        return Nil;
    }
    NSString* stirng = [NSString stringWithFormat:@"select * from %@ where leibies = \"%@\" and users = \"%@\"ORDER BY id DESC",tablename,leibiename,users];
    if([tablename isEqualToString:@"shijan"]){
        stirng = [NSString stringWithFormat:@"select * from %@ where date(timed) >  date( 'now','localtime') and users = \"%@\"ORDER BY id DESC",tablename,users];
    }
    FMResultSet* re = [DB executeQuery:stirng];
    NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:0];
    while ([re next]) {
        LeiBie* ca = [[LeiBie alloc] init];
        ca.name = [re stringForColumn:@"name"] ;
        ca.timess = [re stringForColumn:@"timed"];
        ca.leibie = [re stringForColumn:@"leibies"];
        [array addObject:ca];
    }
    
    [re close];
    [DB close];
    return array;
}





+(void)insertWithName:(NSString*)name withTime:(NSString*)time withTableName:(NSString*)tablename withUserName:(NSString*)username withShiJianXiaDeLeiBieName:(NSString*)leibeiname withTiXing:(NSString*)stringBool
{
    FMDatabase* DB = [FMDatabase databaseWithPath:[self getDBPath]];
    if (![DB open]) {
        [DB close];
        NSAssert(NO, @"数据库为空！");
        
    }
    if (![DB tableExists:tablename])
    {
        [DB close];
//        NSAssert(NO, @"表不存在");
        
        
    }
    NSString* st = [NSString stringWithFormat:@"INSERT INTO %@(name,timed) VALUES(\"%@\",\"%@\") ",tablename,name,time];//记录人和时间
    if([tablename isEqualToString:@"leibie"]){
        st = [NSString stringWithFormat:@"INSERT INTO %@(name,timed,users) VALUES(\"%@\",\"%@\",\"%@\")",tablename,name,time,username];
    }
    if ([tablename isEqualToString:@"shijan"]) {
        st = [NSString stringWithFormat:@"INSERT INTO %@(name,timed,leibies,users,tixing) VALUES(\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",tablename,name,time,leibeiname,username,stringBool];
    }
    BOOL bo =[DB executeUpdate:st];
    if (bo) {
        [DB close];
        
    }
    
}


+(NSArray* )getAllTiXingNameWithNStringTableName:(NSString*)tablename withTiXingFol:(NSString*)tixing//得到表中所有的提醒内容
{
    FMDatabase* DB = [FMDatabase databaseWithPath:[self getDBPath]];
    if (![DB open]) {
        [DB close];
        NSAssert(NO, @"数据库为空！");
        return nil;
    }
    if (![DB tableExists:tablename])
    {
        [DB close];
//        NSAssert(NO, @"表不存在");
        return Nil;
        
    }
    NSString* stirng = [NSString stringWithFormat:@"select * from %@ where tixing = '%@' ORDER BY id DESC",tablename,tixing];
    FMResultSet* re = [DB executeQuery:stirng];
    NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:0];
    while ([re next]) {
        LeiBie* ca = [[LeiBie alloc] init];
        ca.name = [re stringForColumn:@"name"] ;
        ca.timess = [re stringForColumn:@"timed"];
        ca.leibie = [re stringForColumn:@"leibies"];
        ca.tixing = [re stringForColumn:@"tixing"];
        [array addObject:ca];
    }
    
    [re close];
    [DB close];
    return array;
}



+(NSArray* )getTimeTableName:(NSString*)tablename withName:(NSString*)name
{
    tablename = @"shijan";
    FMDatabase* DB = [FMDatabase databaseWithPath:[self getDBPath]];
    if (![DB open]) {
        [DB close];
        NSAssert(NO, @"数据库为空！");
        return nil;
    }
    if (![DB tableExists:tablename])
    {
        [DB close];
//        NSAssert(NO, @"表不存在");
        return Nil;
        
    }
    NSString* stirng = [NSString stringWithFormat:@"select * from %@ where name = '%@' ORDER BY id DESC",tablename,name];
    FMResultSet* re = [DB executeQuery:stirng];
    NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:0];
    while ([re next]) {
        LeiBie* ca = [[LeiBie alloc] init];
        ca.name = [re stringForColumn:@"name"] ;
        ca.timess = [re stringForColumn:@"timed"];
        ca.leibie = [re stringForColumn:@"leibies"];
        ca.tixing = [re stringForColumn:@"tixing"];
        [array addObject:ca];
    }
    
    [re close];
    [DB close];
    return array;
}
@end
