//
//  Photo.m
//  Text
//
//  Created by 王正魁 on 14-7-16.
//  Copyright (c) 2014年 Psylife_iMac02. All rights reserved.
//

#import "Photo.h"
#import "Most.h"
#import <Accelerate/Accelerate.h>
@implementation Photo
static  Photo*shareOtherModel = nil;
+(Photo *)sharedController{
    @synchronized(self){
        if(shareOtherModel == nil){
            shareOtherModel = [[self alloc] init];
            
        }
    }
    return shareOtherModel;
}

+(id)allocWithZone:(NSZone *)zone{
    @synchronized(self){
        if (shareOtherModel == nil) {
            shareOtherModel = [super allocWithZone:zone];
            return  shareOtherModel;
        }
    }
    return nil;
}


-(UIImagePickerController* )imageForPhotoOrLibrary:(NSString* )type
{
    UIImagePickerController* pic = [[UIImagePickerController alloc] init];
    if ([type isEqualToString: @"photo"]) {
        pic.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else
    {
    pic.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    pic.delegate = self;
    return pic;
     
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
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    
    [picker dismissModalViewControllerAnimated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    NSNumber *num = [def objectForKey:@"imageNums"];
    long i = [num integerValue];
    i++;
    [def setObject:[NSNumber numberWithLong:i] forKey:@"imageNums"];
    NSString *name=[NSString stringWithFormat:@"per_head%ld.png",i];
    
    float width=image.size.width;
    float heigh=image.size.height;
    
    float max=(width>=heigh)?width:heigh;
    float maxbl=max/512.0;
    
    float scale=maxbl;
    UIImage *im=[self imageWithImageSimple:image scaledToSize:CGSizeMake(image.size.width/scale, image.size.height/scale)];
    
    [self saveImage:im WithName:name];
    
    if (self.blockPhotoEnd != nil) {
        self.blockPhotoEnd(im);
    }
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
    NSString* documentsDirectory = [[Most getPathForDocument] stringByAppendingPathComponent:imageName_];
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
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
        
        // NSLog(@"删除图片路径:%@",self.picturePaths);
    }
    
}
//加模糊效果，image是图片，blur是模糊度
- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
    //模糊度,
    if ((blur < 0.1f) || (blur > 2.0f)) {
        blur = 0.5f;
    }
    
    //boxSize必须大于0
    int boxSize = (int)(blur * 100);
    boxSize -= (boxSize % 2) + 1;
    NSLog(@"boxSize:%i",boxSize);
    //图像处理
    CGImageRef img = image.CGImage;
    //需要引入#import <Accelerate/Accelerate.h>
    /*
     This document describes the Accelerate Framework, which contains C APIs for vector and matrix math, digital signal processing, large number handling, and image processing.
     本文档介绍了Accelerate Framework，其中包含C语言应用程序接口（API）的向量和矩阵数学，数字信号处理，大量处理和图像处理。
     */
    
    //图像缓存,输入缓存，输出缓存
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    //像素缓存
    void *pixelBuffer;
    
    //数据源提供者，Defines an opaque type that supplies Quartz with data.
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    // provider’s data.
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    //宽，高，字节/行，data
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    //像数缓存，字节行*图片高
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    
    // 第三个中间的缓存区,抗锯齿的效果
    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    vImage_Buffer outBuffer2;
    outBuffer2.data = pixelBuffer2;
    outBuffer2.width = CGImageGetWidth(img);
    outBuffer2.height = CGImageGetHeight(img);
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
    
    //Convolves a region of interest within an ARGB8888 source image by an implicit M x N kernel that has the effect of a box filter.
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    //    NSLog(@"字节组成部分：%zu",CGImageGetBitsPerComponent(img));
    //颜色空间DeviceRGB
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //用图片创建上下文,CGImageGetBitsPerComponent(img),7,8
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             CGImageGetBitmapInfo(image.CGImage));
    
    //根据上下文，处理过的图片，重新组件
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
//    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    free(pixelBuffer2);
    CFRelease(inBitmapData);
    
//    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}
- (UIImage *)applyBlurRadius:(CGFloat)radius toImage:(UIImage *)image
{
    if (radius < 0) radius = 0;
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:image.CGImage];
    
    // Setting up gaussian blur
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:radius] forKey:@"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    
    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
    
    UIImage *returnImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return returnImage;
}
-(UIImage*)jiping:(UIView*)view
{
    CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0);

    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
  
//    CGImageRef imageref = image.CGImage;
//     CGRect rect1 = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width*2, [UIScreen mainScreen].bounds.size.height*2);
//    CGImageRef imagerefRect = CGImageCreateWithImageInRect(imageref, rect1);
//    UIImage *sendImage = [[UIImage alloc] initWithCGImage:imagerefRect];
//    /*
//     UIImage *sendImage = [[UIImage alloc] initWithCGImage:imagerefRect scale:1 orientation:UIImageOrientationUpMirrored];UIImageOrientationUpMirrored可以控制镜像效果
//     */
//    CGImageRelease(imagerefRect);
//    UIImageWriteToSavedPhotosAlbum(sendImage, nil, nil, nil);
   
    return image;
}
@end
