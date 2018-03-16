//
//  OtherModel.m
//  Text
//
//  Created by 王正魁 on 14-7-4.
//  Copyright (c) 2014年 Psylife_iMac02. All rights reserved.
//

#import "OtherModel.h"
#import "Most.h"
@implementation OtherModel
static  OtherModel*shareOtherModel = nil;
+(OtherModel *)sharedController{
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



- (void)callActionWithNumberER:(NSString* )number{
     NSString *num = [[NSString alloc] initWithFormat:@"tel://%@",number]; //number为号码字符串 如果使用这个方法 结束电话之后会进入联系人列表
 
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
}

- (void)callActionWithNumber:(NSString* )number{
    
    NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",number]; //而这个方法则打电话前先弹框  是否打电话 然后打完电话之后回到程序中 网上说这个方法可能不合法 无法通过审核
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
    
}


//  第三种方式打电话



-(void)CallPhoneWithPhoneNum:(NSString* )phoneNum
{
    
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNum]];
    
    if ( !phoneCallWebView ) {
        
        phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];// 这个webView只是一个后台的容易 不需要add到页面上来  效果跟方法二一样 但是这个方法是合法的
        
    } 
    
    [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
    
}

- (void)smsActionWithNumberER:(NSString* )number{
    NSString *num = [[NSString alloc] initWithFormat:@"sms://%@",number];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
}

-(void)smsPhoneWithPhoneNum:(NSString* )phoneNum
{
    
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"sms:%@",phoneNum]];
    
    if ( !phoneCallWebView ) {
        
        phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero]; 
        
    }
    
    [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
    
}
-(MFMessageComposeViewController*)displaySMSComposerSheetnum:(NSString* )num withROOLneirong:(NSString* )neirong

{
    
    MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
    
    picker.messageComposeDelegate = self;
    picker.body=neirong;
     picker.recipients = [NSArray arrayWithObject:num];
    return picker;
    
    
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [controller dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    AVAssetImageGenerator *assetImageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60) actualTime:NULL error:&thumbnailImageGenerationError];
    
    if (!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@", thumbnailImageGenerationError);
    
    UIImage *thumbnailImage = thumbnailImageRef ? [[UIImage alloc] initWithCGImage:thumbnailImageRef] : nil;
    
    CGImageRelease(thumbnailImageRef);
    return thumbnailImage;
}



-(void)playMusicForProductWithName:(NSString* )string WithType:(NSString*)type
{
    NSError* error = nil;
    //  NSString* path1 = [[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"笔画.m4a"];
    NSString* path = [[NSBundle mainBundle] pathForResource:string ofType:type];
    
    
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:path] error:&error];
    _player.delegate = self;
    [_player prepareToPlay];
    
}
-(void)playMusicForhuancun:(NSString* )path
{
    
    NSURL *webSoundUrl = [NSURL URLWithString: path];
    NSURLRequest *request = [NSURLRequest requestWithURL:webSoundUrl];
   
//    NSData   *data = [NSURLConnection sendSynchronousRequest:request
//                                           returningResponse:nil
//                                                       error:&error];
    con = [NSURLConnection connectionWithRequest:request delegate:self];
    /* 下载的数据 */

    
}
-(void)bofang
{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSError *err = nil;
    [audioSession setCategory :AVAudioSessionCategoryPlayback error:&err];
    NSError *error = nil;
    _player = [[AVAudioPlayer alloc] initWithData:bufer error:&error];
    _player.volume = 1;
    _player.delegate = self;
    [_player prepareToPlay];
    if (error !=nil) {
        [self stopMusic];
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"文件下载错误，重新下载" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
    [self playBigin];

}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self performSelectorOnMainThread:@selector(bofang) withObject:self waitUntilDone:YES];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
     NSError *error = nil;
    if (data != nil){
        NSLog(@"下载成功");
        if (bufer == nil) {
            bufer = [[NSMutableData alloc] init];

        }
        [bufer appendData:data];
//        bufer = data;
    } else {
        NSLog(@"%@", error);
    }

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            [_player stop];
        }
            break;
            
        default:
            break;
    }
}
-(void)playMusicForDocumentWithPath:(NSString* )path
{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSError *err = nil;
    [audioSession setCategory :AVAudioSessionCategoryPlayback error:&err];
    NSError* error = nil;
    
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:path] error:&error];
    _player.volume = 1;
    _player.delegate = self;
    [_player prepareToPlay];
    
}
-(void)closepPlayMusic
{
    [_player   pause];
}
-(void)stopMusic
{
    [con cancel];
    con = nil;
    [_player stop];
}
-(void)playBigin
{
    [_player play];
    bufer = nil;
}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if ( self.blockForDidFinishAVAudioPlayer == nil) {
        return;
    }
    else{
    self.blockForDidFinishAVAudioPlayer(player,flag);
    }
}

-(void)RecorderWithStringPath:(NSString*)path
{
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    NSMutableDictionary *recodSettings=[[NSMutableDictionary alloc] init];
    [recodSettings setValue:[NSNumber numberWithFloat:11025.0] forKey:AVSampleRateKey];
    [recodSettings setValue:[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
    [recodSettings setValue:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
    [recodSettings setValue:[NSNumber numberWithInt:AVAudioQualityLow] forKey:AVEncoderAudioQualityKey];
    NSURL* utl= [NSURL URLWithString:path];
    self.recorder=[[AVAudioRecorder alloc] initWithURL:utl settings:recodSettings error:nil];
    self.recorder.delegate=self;
    [self.recorder recordForDuration:300];
    [self.recorder prepareToRecord];
    [self.recorder record];
    
}
-(void)RecorderStop
{
    [self.recorder stop];
}
-(void)RecorderPause
{
    [self.recorder pause];
}




- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    if (self.blockForRecorderDidFinishAVAudioRecorder ==nil) {
        return;
    }
    else
    {
    self.blockForRecorderDidFinishAVAudioRecorder(recorder,flag);
    }
    
}
- (void)doLuXiang:(id)sender {
    
    UIImagePickerController *imagePickerController=[[UIImagePickerController alloc] init];
    imagePickerController.sourceType=UIImagePickerControllerSourceTypeCamera;
    //设置图像选取控制器的类型为动态图像
    imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects:(NSString*)kUTTypeMovie, nil];
    //设置摄像图像品质
    imagePickerController.videoQuality = UIImagePickerControllerQualityTypeMedium;
    //设置最长摄像时间
    //imagePickerController.videoMaximumDuration = 30;
    //允许用户进行编辑
    imagePickerController.allowsEditing = YES;
    //设置委托对象
    imagePickerController.delegate = self;
    //以模式视图控制器的形式显示
    /*
     imagePickerController 需要在viewcontroller中弹出，这是需要代理出去
     */
}

-(void)shengyin
{
    /*
    NSString *path =  [[NSBundle mainBundle] pathForResource:@"Tink" ofType:@"caf"];;
    if (path) {
        SystemSoundID theSoundID;
        OSStatus error =  AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &theSoundID);
        if (error == kAudioServicesNoError) {
            AudioServicesPlaySystemSound(theSoundID);
        }
        else
        {
            NSLog(@"Failed to create sound ");
        }
    }
     */
     AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    /*
    SystemSoundID myAlertSound;
    NSURL *url = [NSURL URLWithString:@"/System/Library/Audio/UISounds/begin_video_record.caf"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &myAlertSound);
    AudioServicesPlaySystemSound(myAlertSound);
    */
    
    
    SystemSoundID sameViewSoundID;
    NSString *thesoundFilePath = [[NSBundle bundleWithIdentifier:@"com.apple.UIKit"] pathForResource:@"Clap Crowd" ofType:@"caf"]; //音乐文件路径
    if (thesoundFilePath == nil) {
        NSLog(@"声音文件找不到");
        return;
    }
    CFURLRef thesoundURL = (__bridge CFURLRef)[NSURL fileURLWithPath:thesoundFilePath];
    AudioServicesCreateSystemSoundID(thesoundURL, &sameViewSoundID);
    //变量SoundID与URL对应
    
    AudioServicesPlaySystemSound(sameViewSoundID); //播放SoundID声音
}
+(void)playSound:(int)soundID{
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    
    if ([[def objectForKey:@"tapSound"] isEqualToString:@"yes"]) {
        SystemSoundID id = soundID;
        AudioServicesPlaySystemSound(id);
    }
   
}


/**
 
 **/
-(UIImagePickerController* )imageForLuXiang
{
    UIImagePickerController *imagePickerController=[[UIImagePickerController alloc] init];
    imagePickerController.sourceType=UIImagePickerControllerSourceTypeCamera;
    //设置图像选取控制器的类型为动态图像
    imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects:(NSString*)kUTTypeMovie, nil];
    //设置摄像图像品质
    imagePickerController.videoQuality = UIImagePickerControllerQualityTypeMedium;
    //设置最长摄像时间
    //imagePickerController.videoMaximumDuration = 30;
    //允许用户进行编辑
    imagePickerController.allowsEditing = YES;
    //设置委托对象
    imagePickerController.delegate = self;
    //以模式视图控制器的形式显示
    return imagePickerController;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    [picker dismissModalViewControllerAnimated:YES];
    //获取媒体类型
    NSString* mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    //获取视频文件的url
    NSURL* mediaURL = [info objectForKey:UIImagePickerControllerMediaURL];
    
    NSData *movieData=[[NSData alloc] initWithContentsOfURL:mediaURL];
    NSString *moveName=[NSString stringWithFormat:@"摄像.MOV"];
    
    
    NSString* documentsDirectory = [[Most getPathForDocument] stringByAppendingPathComponent:luxiangName_];
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:moveName];
    BOOL movieSuc=[movieData writeToFile:fullPathToFile atomically:NO];
    if (!movieSuc) {
        NSLog(@"写入视频数据失败");
    }
    
    if (self.blockForLuXiang != nil) {
        self.blockForLuXiang();
    }
}


@end
