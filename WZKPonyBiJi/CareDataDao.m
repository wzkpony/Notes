//
//  CareDataDao.m
//  OldHome
//
//  Created by macbook007 on 14-2-26.
//  Copyright (c) 2014年 psylife. All rights reserved.
//

#import "CareDataDao.h"

@implementation CareDataDao
+(void)updateWithCareid:(NSString*)careid
{
    FMDatabase* DB = [FMDatabase databaseWithPath:[self getDBPath]];
    if (![DB open]) {
        //[DB close];
        NSAssert(NO, @"数据库为空！");
        
    }
    if (![DB tableExists:@"CareData"])
	{
        //[DB close];
//	NSAssert(NO, @"表不存在");
        
        
	}
    NSString* stirng = [NSString stringWithFormat:@"UPDATE CareData SET ModifyState = 2 WHERE ModifyState == 1 and CareID = '%@'",careid];
    if ([DB executeUpdate:stirng]) {
        //[DB close];
    }
    
}
+(void)insertWithCareID:(NSString* )CareID withTabID:(NSString* )TabID withNo:(int)No withSubTabID:(NSString*)SubTabID withSubNo:(int)SubNo withValue:(NSString*)Value withModifyState:(int)ModifyState withUploadFlag:(int)UploadFlag withstringRecID:(NSString* )reid
{
    FMDatabase* DB = [FMDatabase databaseWithPath:[self getDBPath]];
    if (![DB open]) {
        //[DB close];
        NSAssert(NO, @"数据库为空！");
        
    }
    if (![DB tableExists:@"CareData"])
	{
        //[DB close];
//	NSAssert(NO, @"表不存在");
        
        
	}
    NSString* st = [NSString stringWithFormat:@"INSERT INTO CareData(CareID,TabID,No,SubTabID,SubNo,Value,ModifyState,UploadFlag,RecID) VALUES(\"%@\",\"%@\",%d,\"%@\",%d,\"%@\",%d,%d,\"%@\")",CareID,TabID,No,SubTabID,SubNo,Value,ModifyState,UploadFlag,reid];
    //NSLog(@"%@",st);
    BOOL bo =[DB executeUpdate:st];
    if (bo) {
        //[DB close];

    }
    
}
+(void)deletewithstringall
{
    FMDatabase* DB = [FMDatabase databaseWithPath:[self getDBPath]];
    if (![DB open]) {
        //[DB close];
        NSAssert(NO, @"数据库为空！");
        
    }
    if (![DB tableExists:@"CareData"])
	{
        //[DB close];
//	NSAssert(NO, @"表不存在");
        
        
	}
    NSString* st = [NSString stringWithFormat:@"delete from CareData"];
    BOOL bo =[DB executeUpdate:st];
    if (bo) {
        //[DB close];
        
    }
    
    
}
+(void)updateWithTabID:(NSString*)TabID
{
    FMDatabase* DB = [FMDatabase databaseWithPath:[self getDBPath]];
    if (![DB open]) {
        //[DB close];
        NSAssert(NO, @"数据库为空！");
        
    }
    if (![DB tableExists:@"CareData"])
	{
        //[DB close];
//	NSAssert(NO, @"表不存在");
        
        
	}
    NSString* stirng = [NSString stringWithFormat:@"UPDATE CareData SET ModifyState = -1 WHERE ModifyState == 1 and TabID = %d",[TabID intValue]];
    if ([DB executeUpdate:stirng]) {
        //[DB close];
    }
    
}
+(void)deletewithstring:(NSString* )string
{
    FMDatabase* DB = [FMDatabase databaseWithPath:[self getDBPath]];
    if (![DB open]) {
        //[DB close];
        NSAssert(NO, @"数据库为空！");
        
    }
    if (![DB tableExists:@"CareData"])
	{
        //[DB close];
//	NSAssert(NO, @"表不存在");
        
        
	}
    NSString* st = [NSString stringWithFormat:@"delete from CareData where TabID = %d",[string intValue]];
    BOOL bo =[DB executeUpdate:st];
    if (bo) {
        //[DB close];
        
    }

    
}
+(void)deletewithstringcare:(NSString* )CareID
{
    FMDatabase* DB = [FMDatabase databaseWithPath:[self getDBPath]];
    if (![DB open]) {
        //[DB close];
        NSAssert(NO, @"数据库为空！");
        
    }
    if (![DB tableExists:@"CareData"])
	{
        //[DB close];
//	NSAssert(NO, @"表不存在");
        
        
	}
    NSString* st = [NSString stringWithFormat:@"delete from CareData where CareID = '%@'",CareID];
    BOOL bo =[DB executeUpdate:st];
    if (bo) {
        //[DB close];
        
    }
    
    
}
+(NSArray* )getWithNString:(int)name
{
    FMDatabase* DB = [FMDatabase databaseWithPath:[self getDBPath]];
    if (![DB open]) {
        //[DB close];
        NSAssert(NO, @"数据库为空！");
        return nil;
    }
    if (![DB tableExists:@"CareData"])
	{
        //[DB close];
//	NSAssert(NO, @"表不存在");
        return Nil;
        
	}
    NSString* stirng = [NSString stringWithFormat:@"select * from Care where TabID = \"%d\"",name];
    FMResultSet* re = [DB executeQuery:stirng];
    NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:0];
    while ([re next]) {
        CareData* ca = [[CareData alloc] init];
        ca.CareID = [re stringForColumn:@"CareID"] ;
        [array addObject:ca];
    }
//    NSLog(@"%d",[array count]);
    //[DB close];
    [re close];
    return array;
}


+(NSArray* )getTiXingWithNString:(NSString* )name
{
    FMDatabase* DB = [FMDatabase databaseWithPath:[self getDBPath]];
    if (![DB open]) {
        //[DB close];
        NSAssert(NO, @"数据库为空！");
        return nil;
    }
    if (![DB tableExists:@"CareData"])
    {
        //[DB close];
//        NSAssert(NO, @"表不存在");
        return Nil;
        
    }
    NSString* stirng = [NSString stringWithFormat:@"select * from Care where TabID = \"%d\"",name];
    FMResultSet* re = [DB executeQuery:stirng];
    NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:0];
    while ([re next]) {
        CareData* ca = [[CareData alloc] init];
        ca.CareID = [re stringForColumn:@"CareID"] ;
        [array addObject:ca];
    }
    //    NSLog(@"%d",[array count]);
    //[DB close];
    [re close];
    return array;
}


+(NSString* )getDBPath
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    
    return [path stringByAppendingPathComponent:@"test.sqlite"];
    
}
@end
