//
//  WZKTest.m
//  WZKPonyBiJi
//
//  Created by 王正魁 on 15-3-23.
//  Copyright (c) 2015年 psylife. All rights reserved.
//

#import "WZKTest.h"
#import <CoreText/CoreText.h>
@implementation WZKTest
- (NSMutableAttributedString *)filterLinkWithContent:(NSString *)content {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:content];
    NSError *error = NULL;
    NSDataDetector *detector =
    [NSDataDetector dataDetectorWithTypes:(NSTextCheckingTypes)NSTextCheckingTypePhoneNumber|NSTextCheckingTypeLink
                                    error:&error];
    //    NSDataDetector* detector = [[NSDataDetector alloc] init] ;
    //    [detector firstMatchInString:@"^[0-9]*$" options:NSMatchingReportProgress range:NSMakeRange(0, [content length])];
    
    NSArray *matches = [detector matchesInString:content
                                         options:0
                                           range:NSMakeRange(0, [content length])];
    
    for (NSTextCheckingResult *match in matches) {
        
        switch ([match resultType]) {
            case NSTextCheckingTypeQuote:
            {
                NSURL *url = [match URL];
                [attributedString addAttribute:NSUnderlineColorAttributeName value:url range:match.range];
            }
                break;
            case NSTextCheckingTypeDash:
            {
                NSURL *url = [match URL];
                [attributedString addAttribute:NSStrikethroughStyleAttributeName value:url range:match.range];
            }
                break;
            case NSTextCheckingTypeLink:
            {
                NSURL *url = [match URL];
                [attributedString addAttribute:NSLinkAttributeName value:url range:match.range];
            }
                break;
            case NSTextCheckingTypePhoneNumber:
            {
                NSString *url = [match phoneNumber];
                if (url == nil) {
                    break ;
                }
                //                [attributedString addAttribute:NSLinkAttributeName value:url range:match.range];//link;
                [attributedString setAttributes:@{UITextAttributeTextColor:[UIColor redColor]} range:match.range];//red color
            }
                break;
                
            default:
                break;
        }
        //        if (([match resultType] == NSTextCheckingTypeQuote)) {
        //
        //            NSURL *url = [match URL];
        //            [attributedString addAttribute:NSUnderlineColorAttributeName value:url range:match.range];
        //
        //        }
        //        if (([match resultType] == NSTextCheckingTypeDash)) {
        //
        //            NSURL *url = [match URL];
        //            [attributedString addAttribute:NSStrikethroughStyleAttributeName value:url range:match.range];
        //
        //        }
        //        if (([match resultType] == NSTextCheckingTypeLink)) {
        //
        //            NSURL *url = [match URL];
        //            [attributedString addAttribute:NSLinkAttributeName value:url range:match.range];
        //
        //        }
        NSLog(@"%llu----%lu======%llu",[match resultType],(unsigned long)[content length],NSTextCheckingTypeLink | NSTextCheckingTypePhoneNumber);
        
        
    }
    return attributedString;
}

- (void)drawRect:(CGRect)rect
{
    [self characterAttribute];
}
-(void)characterAttribute
{
    NSString *str = @"This is a test of characterAttribute. 中文字符: 今天是我的演讲，做一个小样子，看看效果怎么样";
    NSMutableAttributedString *mabstring = [[NSMutableAttributedString alloc]initWithString:str];
    
    [mabstring beginEditing];
    /*
     long number = 1;
     CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
     [mabstring addAttribute:(id)kCTCharacterShapeAttributeName value:(id)num range:NSMakeRange(0, 4)];
     */
    /*
     //设置字体属性
     CTFontRef font = CTFontCreateWithName(CFSTR("Georgia"), 40, NULL);
     [mabstring addAttribute:(id)kCTFontAttributeName value:(id)font range:NSMakeRange(0, 4)];
     */
    /*
     //设置字体简隔 eg:test
     long number = 10;
     CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
     [mabstring addAttribute:(id)kCTKernAttributeName value:(id)num range:NSMakeRange(10, 4)];
     */
    
    /*
     long number = 1;
     CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
     [mabstring addAttribute:(id)kCTLigatureAttributeName value:(id)num range:NSMakeRange(0, [str length])];
     */
    /*
     //设置字体颜色
     [mabstring addAttribute:(id)kCTForegroundColorAttributeName value:(id)[UIColor redColor].CGColor range:NSMakeRange(0, 9)];
    */
    /*
     //设置字体颜色为前影色
     CFBooleanRef flag = kCFBooleanTrue;
     [mabstring addAttribute:(id)kCTForegroundColorFromContextAttributeName value:(id)flag range:NSMakeRange(5, 10)];
     */
    
    /*
     //设置空心字
     long number = 2;
     CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
     [mabstring addAttribute:(id)kCTStrokeWidthAttributeName value:(id)num range:NSMakeRange(0, [str length])];
     
     //设置空心字颜色
     [mabstring addAttribute:(id)kCTStrokeColorAttributeName value:(id)[UIColor greenColor].CGColor range:NSMakeRange(0, [str length])];
     */
    
    /*
     long number = 1;
     CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
     [mabstring addAttribute:(id)kCTSuperscriptAttributeName value:(id)num range:NSMakeRange(3, 1)];
     */
    
    /*
     //设置斜体字
     CTFontRef font = CTFontCreateWithName((CFStringRef)[UIFont italicSystemFontOfSize:20].fontName, 14, NULL);
     [mabstring addAttribute:(id)kCTFontAttributeName value:(id)font range:NSMakeRange(0, 4)];
     */
    
    /*
     //下划线
     [mabstring addAttribute:(id)kCTUnderlineStyleAttributeName value:(id)[NSNumber numberWithInt:kCTUnderlineStyleDouble] range:NSMakeRange(0, 4)];
     //下划线颜色
     [mabstring addAttribute:(id)kCTUnderlineColorAttributeName value:(id)[UIColor redColor].CGColor range:NSMakeRange(0, 4)];
     */
    
    
    
    //对同一段字体进行多属性设置
    //红色
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithObject:(id)[UIColor redColor].CGColor forKey:(id)kCTForegroundColorAttributeName];
    //斜体
    CTFontRef font = CTFontCreateWithName((CFStringRef)[UIFont italicSystemFontOfSize:20].fontName, 40, NULL);
    [attributes setObject:(__bridge id)font forKey:(id)kCTFontAttributeName];
    //下划线
    [attributes setObject:(id)[NSNumber numberWithInt:kCTUnderlineStyleDouble] forKey:(id)kCTUnderlineStyleAttributeName];
    
    long number = 2;
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
    [mabstring addAttribute:(id)kCTStrokeWidthAttributeName value:(__bridge id)num range:NSMakeRange(0, [str length])];
    
    CTFontRef font1 = CTFontCreateWithName(CFSTR("Georgia"), 15, NULL);
    [mabstring addAttribute:(id)kCTFontAttributeName value:(__bridge id)font1 range:NSMakeRange(5, [str length]-12)];
    [mabstring addAttributes:attributes range:NSMakeRange(0, 4)];
    
    
    
    NSRange kk = NSMakeRange(0, 4);
    
    NSDictionary * dc = [mabstring attributesAtIndex:0 effectiveRange:&kk];
    
    [mabstring endEditing];
    
    NSLog(@"value = %@",dc);
    
    
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)mabstring);
    
    CGMutablePathRef Path = CGPathCreateMutable();
    
    CGPathAddRect(Path, NULL ,CGRectMake(10 , 0 ,self.bounds.size.width-10 , self.bounds.size.height-10));
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), Path, NULL);
    
    //获取当前(View)上下文以便于之后的绘画，这个是一个离屏。
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetTextMatrix(context , CGAffineTransformIdentity);
    
    //压栈，压入图形状态栈中.每个图形上下文维护一个图形状态栈，并不是所有的当前绘画环境的图形状态的元素都被保存。图形状态中不考虑当前路径，所以不保存
    //保存现在得上下文图形状态。不管后续对context上绘制什么都不会影响真正得屏幕。
    CGContextSaveGState(context);
    
    //x，y轴方向移动
    CGContextTranslateCTM(context , 0 ,self.bounds.size.height);
    
    //缩放x，y轴方向缩放，－1.0为反向1.0倍,坐标系转换,沿x轴翻转180度
    CGContextScaleCTM(context, 1.0 ,-1.0);
    
    CTFrameDraw(frame,context);
    
    CGPathRelease(Path);
    CFRelease(framesetter);
}


@end
