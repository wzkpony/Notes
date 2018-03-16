//
//  Most.m
//  Text
//
//  Created by 王正魁 on 14-5-23.
//  Copyright (c) 2014年 Psylife_iMac02. All rights reserved.
//

#import "Most.h"

@implementation Most
-(id)init
{
    self = [super init];
    if (self) {
//        if ([self.delegate respondsToSelector:@selector(delegateSelect)]) {
//            [self.delegate delegateSelect];
//        }
        
        
        /*
         //去掉这个可以让cell的button变得更灵敏，事件传递问题（UITableViewCellScrollView拦截了，所以会变慢）
         for (UIView *currentView in self.subviews){
         if ([NSStringFromClass([currentView class]) isEqualToString:@"UITableViewCellScrollView"])
         {
         UIScrollView *sv = (UIScrollView *) currentView;
         [sv setDelaysContentTouches:NO];
         break;
         }
         }
         */
        
    }
    return self;
}

+(void)getDBForPathWithName:(NSString*)name
{
    NSArray* array = [name componentsSeparatedByString:@"."];
    if ([array count]<2) {
        return;
    }
    NSString* stringDB = [[NSBundle mainBundle]pathForResource:[array objectAtIndex:0] ofType:[array objectAtIndex:1]];
    if (stringDB == nil) {
        return;
    }
    NSString* stringpath = [self getSandBoxPathWithName:name];
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:stringpath]) {
        if ( [manager copyItemAtPath:stringDB toPath:stringpath error:Nil]) {
            NSLog(@"数据库拷贝成功");
        }
        else
        {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"友情提示" message:@"本地数据异常，是否重新加载" delegate:self cancelButtonTitle:@"不" otherButtonTitles:@"是", nil];
            [alert show];
        }
    }
    else
    {
        NSLog(@"数据库已经存在");
    }
    
}

+(NSString *)loadRESPathWithName:(NSString *)filename;
{
    NSFileManager *fileMang = [NSFileManager defaultManager];
    NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *rePath = [documentDir stringByAppendingPathComponent:filename];
    BOOL dbIsExits = [fileMang fileExistsAtPath:rePath];
    if (!dbIsExits) {
        NSArray* array = [filename componentsSeparatedByString:@"."];
       
        if ([array count]==2) {//当文件有一个.的时候
            rePath = [[NSBundle mainBundle] pathForResource:[array objectAtIndex:0] ofType:[array objectAtIndex:1]];
        }
        if ([array count]==3) {//当文件有两个.的时候
            rePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@.%@",[array objectAtIndex:0],[array objectAtIndex:1]] ofType:[array objectAtIndex:2]];
        }
        BOOL dbIsExitss = [fileMang fileExistsAtPath:rePath];
        if (!dbIsExitss) {
//            rePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:filename];
            rePath = nil;
        }
    }
    return  rePath;
}
+(NSArray* )loadFileForArrayWithPath:(NSString*)path
{
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSArray* arrays = nil;
    if ([fileManager fileExistsAtPath:path] != NO) {
        arrays = [fileManager contentsOfDirectoryAtPath:path error:nil];
    }
    
    return arrays;
}


+(NSString* )getModel
{
    UIDevice* device = [UIDevice currentDevice];
    return device.model;
}
+(NSString* )getSystemVersion
{
    UIDevice* device = [UIDevice currentDevice];
    return device.systemVersion;
}

+(NSString* )getSystemName
{
    UIDevice* device = [UIDevice currentDevice];
    return device.systemName;
}
+(NSString* )getDeviceName
{
    UIDevice* device = [UIDevice currentDevice];
    return device.name;
}


+(NSString* )getver
{
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    //    NSString *build = [infoDictionary objectForKey:@"CFBundleVersion"];
    //    NSString *label = [NSString stringWithFormat:@"%@ v%@ (build %@)", name, version, build];
//    NSLog(@"%@",version);
    return version;
}
+(NSString* )getBundleDisplayName
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];

    NSString *name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    return name;
}
+(NSString*)getTimeForSystemWithDate
{
    NSDate* data = [NSDate date];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    return [formatter stringFromDate:data];
}
+(NSString*)getTimeForSystemWithTime
{
    NSDate* data = [NSDate date];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    return [formatter stringFromDate:data];
}
+(NSString*)getTimeForSystemWithTimeAndDate
{
    NSDate* data = [NSDate date];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    return [formatter stringFromDate:data];
}
+(NSString *)getPathForDocument
{
    
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return path ;
}

+(NSString *)getSandBoxPathWithName:(NSString*)name
{
    return [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@",name]];;
}
+(void)creatFolderWithName:(NSString *)name
{
    NSError* error = nil;
    
    NSString* stringneirong = [NSString stringWithFormat:@"%@",name];
    NSString* string = [[self getPathForDocument] stringByAppendingPathComponent:stringneirong];
    NSFileManager* file = [NSFileManager defaultManager];
    if (![file fileExistsAtPath:string]) {
       [file createDirectoryAtPath:string withIntermediateDirectories:YES attributes:nil error:&error];
    }
    else
    {
        if ([name isEqualToString:imageName_]) {
            return;
        }
        if ([name isEqualToString:luxiangName_]) {
            return;
        }
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您已经创建过这个类别，请重新创建" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
}
+(void)cleanFolderWithName:(NSString *)name
{
    NSError* error = nil;
    NSString* string = [[self getPathForDocument] stringByAppendingPathComponent:name];
    NSFileManager* file = [NSFileManager defaultManager];
    if (![file fileExistsAtPath:string]) {
        [file createDirectoryAtPath:string withIntermediateDirectories:YES attributes:nil error:&error];
    }
    else
    {
       [file removeItemAtPath:string error:nil];
         [file createDirectoryAtPath:string withIntermediateDirectories:YES attributes:nil error:&error];
    }
}
+(void)cleanFolderWithFileName:(NSString *)name
{
    NSError* error = nil;
    NSString* string = [[self getPathForDocument] stringByAppendingPathComponent:name];
    NSFileManager* file = [NSFileManager defaultManager];
    if ([file fileExistsAtPath:string]) {
        [file removeItemAtPath:string error:nil];
    }
}
+(void)moveFolderWithPaht:(NSString *)path toPath:(NSString*)toPath
{
    NSError* error = nil;
    NSFileManager* file = [NSFileManager defaultManager];
    if ([file fileExistsAtPath:path]==YES) {
        [file moveItemAtPath:path toPath:toPath error:&error];
    }
    
}
+(void)deleteFolderWithPaht:(NSString *)path
{
    NSError* error = nil;
    NSFileManager* file = [NSFileManager defaultManager];
    if ([file fileExistsAtPath:path]!=NO) {
        [file removeItemAtPath:path error:&error];
    }
    
}
+(void)creatFileWithName:(NSString* )name WithArray:(NSArray *)array
{
    
    [array writeToFile:[[self getPathForDocument] stringByAppendingPathComponent:name] atomically:YES];
}
+(void)creatFileWithName:(NSString* )name WithDictionary:(NSDictionary *)dic
{
    [dic writeToFile:[[self getPathForDocument] stringByAppendingPathComponent:name] atomically:YES];
}
+(void)creatFileWithName:(NSString* )name WithData:(NSData *)data
{
    NSFileManager* file = [NSFileManager defaultManager];
    if (![file fileExistsAtPath:[[self getPathForDocument]stringByAppendingPathComponent:name]]) {
            [data writeToFile:[[self getPathForDocument] stringByAppendingPathComponent:name] atomically:YES];
    }
}
+(void)creatFileWithName:(NSString* )name WithString:(NSString *)str
{
    NSFileManager* file = [NSFileManager defaultManager];
    if (![file fileExistsAtPath:[[self getPathForDocument]stringByAppendingPathComponent:name]]) {
        [str writeToFile:[[self getPathForDocument] stringByAppendingPathComponent:name] atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
    else
    {
        if ([name isEqualToString:imageName_]) {
            return;
        }
        if ([name isEqualToString:luxiangName_]) {
            return;
        }
      
        
    }
}
+(void)creatFileWithName:(NSString* )name WithWriteString:(NSString *)str
{
    [str writeToFile:[[self getPathForDocument] stringByAppendingPathComponent:name] atomically:YES encoding:NSUTF8StringEncoding error:nil];
}


+(NSMutableArray* )selectFileWithPath:(NSString* )path WithNameForType:(NSString* )type//筛选文件夹里的文件
{
    NSFileManager *fileManage=[NSFileManager defaultManager];
    NSArray *file = [fileManage contentsOfDirectoryAtPath:path error:nil];
    NSMutableArray* arraymutable = [[NSMutableArray alloc] initWithCapacity:0];
    NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF CONTAINS %@",type];
    file=[file filteredArrayUsingPredicate:pre];
    for (NSString *name in file) {
        
        NSString *filePath=[path stringByAppendingPathComponent:name];
//        NSLog(@"filePath:%@",filePath);
        [arraymutable addObject:filePath];
        
    }
    return arraymutable;
}

+(id)readFileWithPaht:(NSString *)path
{
    NSArray* array = nil;
    NSFileManager* file = [NSFileManager defaultManager];
    if ([file fileExistsAtPath:path]) {
         array = [NSArray arrayWithContentsOfFile:path];
    }
    return array;
}

+(void)writeToFileContent:(NSString*)string WithPaht:(NSString* )path
{
    NSString* paths = [[Most getPathForDocument] stringByAppendingPathComponent:path];
    NSFileManager* file = [NSFileManager defaultManager];
    if ([file fileExistsAtPath:paths]) {
     NSFileHandle* handle = [NSFileHandle fileHandleForWritingAtPath:paths];
         [handle seekToEndOfFile];
       NSData* buffer = [string dataUsingEncoding:NSUTF8StringEncoding];
        
        [handle writeData:buffer];
       
        [handle closeFile];
    }
   
}


+(float)getHeightWithString:(NSString*)string WithFontSize:(float)size
{
    CGSize s = CGSizeZero;
    if ([[[UIDevice currentDevice] systemVersion] floatValue]<7.0) {
        UIFont *font = [UIFont fontWithName:@"Arial" size:size];
        s = [string sizeWithFont:font];
        
    }
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) {
//        s = [string sizeWithAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:size] }];
        
        
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:size]};
        
        CGSize textSize = [string boundingRectWithSize:CGSizeMake(220, 0)  options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        return textSize.height;
        
        
    }
    return s.height;
}
+(NSString*)getSubStringWithString:(NSString *)string WithBeginFloat:(float)n WithEndFloat:(float)m
{
    return [string substringWithRange:NSMakeRange(n, m)];
}



#pragma mark -压缩图片
-(UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}
#pragma mark -save image to 沙盒
- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName
{
    NSData* imageData;
    if (UIImagePNGRepresentation(tempImage) == nil) {
        
        imageData = UIImageJPEGRepresentation(tempImage, 1);
        
    } else {
        
        imageData = UIImagePNGRepresentation(tempImage);
        
    }
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
//    [self.picturePaths addObject:fullPathToFile];
    //NSLog(@"添加图片路径:%@",self.picturePaths);
    [imageData writeToFile:fullPathToFile atomically:NO];
    
}
#pragma mark -remove image to 沙盒
- (void)removeImage:(NSString *)imageName
{
    NSFileManager* fileManager=[NSFileManager defaultManager];
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    if ([fileManager fileExistsAtPath:fullPathToFile]) {
        [fileManager removeItemAtPath:fullPathToFile error:nil];
        
//        [self.picturePaths removeObject:fullPathToFile];
        
        // NSLog(@"删除图片路径:%@",self.picturePaths);
    }
    
}




@end
