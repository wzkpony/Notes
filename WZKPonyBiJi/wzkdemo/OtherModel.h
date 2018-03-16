//
//  OtherModel.h
//  Text
//
//  Created by 王正魁 on 14-7-4.
//  Copyright (c) 2014年 Psylife_iMac02. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import<AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AudioToolbox/AudioToolbox.h>
//#include "lame.h"
@interface OtherModel : NSObject<MFMessageComposeViewControllerDelegate,AVAudioPlayerDelegate,AVAudioRecorderDelegate,NSURLConnectionDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    UIWebView* phoneCallWebView;
    NSURLConnection* con;
    NSMutableData* bufer;
}
@property(nonatomic,strong)AVAudioRecorder* recorder;
@property(nonatomic,strong) AVAudioPlayer* player;
@property(nonatomic,copy)void(^blockForDidFinishAVAudioPlayer)(AVAudioPlayer* player,BOOL flag);
@property(nonatomic,copy)void(^blockForRecorderDidFinishAVAudioRecorder)(AVAudioRecorder* player,BOOL flag);
@property(nonatomic,copy)void(^blockForMP3Result)(void);
@property(nonatomic,copy)void(^blockForLuXiang)(void);
+(OtherModel *)sharedController;
/*
 播放音频和视频；录音和录像
 */
-(void)playMusicForProductWithName:(NSString* )string WithType:(NSString*)type;//音乐路径(工程文件)
-(void)playMusicForDocumentWithPath:(NSString* )path;//音乐播放（从指定路径播放）
-(void)stopMusic;//停止播放
-(void)closepPlayMusic;//暂停播放
-(void)playBigin;//开始播放


-(void)RecorderWithStringPath:(NSString*)path;//录音
-(void)RecorderStop;//停止录音
-(void)RecorderPause;//暂停录音



-(void)playMusicForhuancun:(NSString* )path;//缓存到内存中试听

/*
 打电话发短信
 */

- (void)callActionWithNumberER:(NSString* )number;//number为号码字符串 如果使用这个方法 结束电话之后会进入联系人列表
- (void)callActionWithNumber:(NSString* )number;//而这个方法则打电话前先弹框  是否打电话 然后打完电话之后回到程序中 网上说这个方法可能不合法 无法通过审核
-(void)CallPhoneWithPhoneNum:(NSString* )phoneNum;// 这个webView只是一个后台的容易 不需要add到页面上来  效果跟方法二一样 但是这个方法是合法的



- (void)smsActionWithNumberER:(NSString* )number;
-(void)smsPhoneWithPhoneNum:(NSString* )phoneNum;
-(MFMessageComposeViewController*)displaySMSComposerSheetnum:(NSString* )num withROOLneirong:(NSString* )neirong;


- (void) toMp3:(NSString* )mp3FilePath withOldName:(NSString*)cafFilePath;


-(void)shengyin;
+(void)playSound:(int)soundID;//播放系统提示音



-(UIImagePickerController* )imageForLuXiang;//录像
-(UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time;//获取视频图片
@end
