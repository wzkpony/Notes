//
//  CareData.h
//  OldHome
//
//  Created by macbook007 on 14-2-26.
//  Copyright (c) 2014年 psylife. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
@interface CareData : NSObject
@property(nonatomic,copy)NSString* RecId;
@property(nonatomic,copy)NSString*CareID;
@property(nonatomic,copy)NSString* TabID;
@property(nonatomic,assign)int No;
@property(nonatomic,copy)NSString* SubTabID;
@property(nonatomic,assign)int SubNo;
@property(nonatomic,copy)NSString* Value;
@property(nonatomic,assign)int ModifyState;
@property(nonatomic,assign)int UploadFlag;

@end
