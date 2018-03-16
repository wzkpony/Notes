//
//  Most.h
//  Text
//
//  Created by 王正魁 on 14-5-23.
//  Copyright (c) 2014年 Psylife_iMac02. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#define imageName_ @"cache"
#define luxiangName_ @"lvxiang"
@interface Most : NSObject<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    
}
//@property(nonatomic ,assign)id delegate;


//////////////////////路径和时间
+(NSString*)getTimeForSystemWithDate;//获取系统日期
+(NSString*)getTimeForSystemWithTime;//获取系统时间
+(NSString*)getTimeForSystemWithTimeAndDate;//获取系统日期和时间
+(NSString *)getPathForDocument;//获取沙盒Document路径
+(NSString *)getSandBoxPathWithName:(NSString*)name;//获取沙盒文件(或文件夹)路径


+(NSString *)loadRESPathWithName:(NSString *)filename;//读文件的时候的文件路径（现在工程里找，要是没有在沙盒里找，要是都没有就会返回nil）



//////////////////////////---------文件管理
+(void)creatFolderWithName:(NSString *)name;//创建文件夹
+(void)cleanFolderWithName:(NSString *)name;//清楚文件夹内容
+(void)cleanFolderWithFileName:(NSString *)name;//清楚文件夹
+(void)moveFolderWithPaht:(NSString *)path toPath:(NSString*)toPath;//移动文件（或文件夹）
+(void)deleteFolderWithPaht:(NSString *)path;//删除文件

+(void)getDBForPathWithName:(NSString*)name;//将工程文件拷贝到沙盒

+(void)creatFileWithName:(NSString* )name WithArray:(NSArray *)array;//将NSArray写入文件中 ， 不会创建文件
+(void)creatFileWithName:(NSString* )name WithDictionary:(NSDictionary *)dic;//将NSDictionary写入文件中 ， 不会创建文件
+(void)creatFileWithName:(NSString* )name WithData:(NSData *)data;//将data写入文件，如果有就会写入，如果没有就会新创建一个
+(void)creatFileWithName:(NSString* )name WithString:(NSString *)str;//将string写入文件中，如果没有就会创建一个


+(void)creatFileWithName:(NSString* )name WithWriteString:(NSString *)str//将字符串写入文件中 ， 不会创建文件
;

//+(id)readFileWithPaht:(NSString *)path;
+(void)writeToFileContent:(NSString*)string WithPaht:(NSString* )path;//写入文件

+(float)getHeightWithString:(NSString*)string WithFontSize:(float)size;//根据字符串获取高度

+(NSString*)getSubStringWithString:(NSString *)string WithBeginFloat:(float)n WithEndFloat:(float)m;//截取字符串

+(NSMutableArray* )selectFileWithPath:(NSString* )path WithNameForType:(NSString* )type;//筛选文件夹里的文件（path是文件夹路径）

+(NSArray* )loadFileForArrayWithPath:(NSString*)path;//读取文件目录
//////////////////获取系统信息和项目版本

+(NSString* )getver;//获取设置的版本号
+(NSString* )getBundleDisplayName;//获取项目展示的名字
+(NSString* )getDeviceName;//获取设备名字，例如：王正魁的iphone
+(NSString* )getSystemName;//用于返回当前操作系统的名字  例如：iPhone OS
+(NSString* )getSystemVersion;//用于返回ios或os的版本
+(NSString* )getModel;//返回设备型号


/////////////////////////////////////////////////

#pragma mark -压缩图片
-(UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
#pragma mark -save image to 沙盒
- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName;
#pragma mark -remove image to 沙盒
- (void)removeImage:(NSString *)imageName;





@end
/*
 NSPredicate* per = [NSPredicate predicateWithFormat:@"SELF like %@",string];
 arrayline = [array filteredArrayUsingPredicate:per];
 //详细见http://www.cnblogs.com/MarsGG/articles/1949239.html
 */
/*
 UIBezierPath 的使用介绍
 http://blog.csdn.net/guo_hongjun1611/article/details/7839371
 
 */

/*
 
 
@protocol Most <NSObject>

-(void)delegateSelect;


@end
 */
