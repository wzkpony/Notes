//
//  Photo.h
//  Text
//
//  Created by 王正魁 on 14-7-16.
//  Copyright (c) 2014年 Psylife_iMac02. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>
@interface Photo : NSObject<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

+(Photo *)sharedController;
#pragma mark -压缩图片
-(UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
#pragma mark -save image to 沙盒
- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName;
#pragma mark -remove image to 沙盒
- (void)removeImage:(NSString *)imageName;
-(UIImagePickerController* )imageForPhotoOrLibrary:(NSString* )type;
@property(nonatomic,copy)void(^blockPhotoEnd)(UIImage* image);



- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;
-(UIImage*)jiping:(UIView*)view;
- (UIImage *)applyBlurRadius:(CGFloat)radius toImage:(UIImage *)image;


@end
//@protocol PhotoDelegate <NSObject>
//
//-(void)photoEnd;
//
//
//@end