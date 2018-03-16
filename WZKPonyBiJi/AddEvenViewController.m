//
//  AddEvenViewController.m
//  WZKPonyBiJi
//
//  Created by 王正魁 on 15-3-20.
//  Copyright (c) 2015年 psylife. All rights reserved.
//

#import "AddEvenViewController.h"
#import "AppDelegate.h"
#import "ImagesCollectionViewCell.h"
#import "Photo.h"
#import "Most.h"
#import "WZKPlayViewController.h"
#import "LeiBieDao.h"
/*
 图片的处理：
 1.照相和相册
 2.将选取好的照片保存到沙盒下的cache的一个文件夹下，当保存事件的时候，将这个文件加中的图片拷贝到自己名字－－>创建的新事件的目录下。要是取消保存事件返回的话，也会删除这个cache的文件夹
 */
#define shangshengH 50
@interface AddEvenViewController ()
{
    

}
@property (strong, nonatomic) IBOutlet UIButton *buttonSelectTime;
@property (strong, nonatomic) IBOutlet UIView *viewDiTu;
@property (strong, nonatomic) IBOutlet UIPickerView *picker;
@property (strong, nonatomic) IBOutlet UITextField *textfielEven;
@property (strong, nonatomic) IBOutlet UIScrollView *scroller;
@property (strong, nonatomic) IBOutlet UIImageView *luXiangImage;
@property (strong, nonatomic) IBOutlet UIView *views;
@property (strong, nonatomic) IBOutlet UITextView *textViewInput;
@property (strong, nonatomic) IBOutlet UIButton *buttonAddImage;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionForImage;
@property (strong, nonatomic) IBOutlet UIButton *buttonLuXiang;
@property (strong, nonatomic) IBOutlet UIButton *buttonFaBu;
@property (strong, nonatomic) IBOutlet UIButton *buttonSelectLeiBie;
@property (strong, nonatomic) IBOutlet UIDatePicker *datepic;
@property(strong,nonatomic)UIToolbar* bar;
@property(nonatomic,strong)NSMutableArray* arrayForImage;
@property(nonatomic,strong) Photo* photos;
@property (strong, nonatomic) IBOutlet UISwitch *kaiguan;
@property(nonatomic,strong)NSArray* array_ ;
@end
@implementation AddEvenViewController

- (IBAction)buttonTima:(id)sender {
    [self.view addSubview:self.datepic];

    self.datepic.center = CGPointMake(self.view.center.x, -self.datepic.frame.size.height);
    self.viewDiTu.frame = self.view.frame;
    [self.view insertSubview:self.viewDiTu belowSubview:self.datepic];
    [UIView animateWithDuration:0.5 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:0.8 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.datepic.center = self.view.center;
    } completion:^(BOOL finished) {
       
        
    }];
    
    
}
- (IBAction)changed:(UIDatePicker *)sender {
    NSDate *date = sender.date;
    //时区转换，取得系统时区，取得格林威治时间差秒
    NSTimeZone* zun = [NSTimeZone localTimeZone];
//
    NSInteger  timeZoneOffset=[zun secondsFromGMTForDate:date];
    NSTimeZone* zoo = [NSTimeZone timeZoneForSecondsFromGMT:timeZoneOffset];
    //格式化日期时间
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];

    [dateformatter setTimeZone:zoo];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString * dateStr=[dateformatter stringFromDate:date];
    [self.buttonSelectTime setTitle:dateStr forState:UIControlStateNormal];
}

-(void)viewDidDisappear:(BOOL)animated
{
  
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    self.photos = nil;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (IBAction)selectLeiBie:(id)sender {
    _array_ = [LeiBieDao getAllNameWithNStringTableName:@"leibie"];
  
    [self.textfielEven resignFirstResponder];
    [self.textViewInput resignFirstResponder];
    if (_array_.count == 0) {
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"请个人中心创建分组" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
        return;
        
    }
    [self.view addSubview:self.picker];
    self.picker.center = CGPointMake(self.view.center.x, -self.picker.frame.size.height);
    self.viewDiTu.frame = self.view.frame;
    [self.view insertSubview:self.viewDiTu belowSubview:self.picker];
    [UIView animateWithDuration:0.5 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:0.8 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.picker.center = self.view.center;
    } completion:^(BOOL finished) {
        if ([_array_ count]>0) {
            LeiBie* lb = [_array_ objectAtIndex:0];
            [self.buttonSelectLeiBie setTitle:lb.name forState:UIControlStateNormal];
            AppDelegate* app = [UIApplication sharedApplication].delegate;
            app.leibeis = lb.name;
        }
        
    }];
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{

    
    return _array_.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    LeiBie* lb = [_array_ objectAtIndex:row];
    return lb.name;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    LeiBie* lb = [_array_ objectAtIndex:row];
    NSString* stringtitle = lb.name;
    [self.buttonSelectLeiBie setTitle:stringtitle forState:UIControlStateNormal];
    AppDelegate* app = [UIApplication sharedApplication].delegate;
    app.leibeis = stringtitle;
}
#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([self.textViewInput isFirstResponder] == YES) {
        [self.textViewInput resignFirstResponder];
        return NO;
    }
    if ([textField.text isEqualToString:@"随笔"]) {
         textField.text = @"";
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self HiddenKeyBoard];
    if ([textField.text isEqualToString:@""]) {
        textField.text = @"随笔";
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
//    [self HiddenKeyBoard];
     [textField resignFirstResponder];
    return YES;
}
#pragma mark UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([self.textfielEven isFirstResponder] == YES) {
        [self.textfielEven resignFirstResponder];
        return NO;
    }
    if ([textView.text isEqualToString:@"请输入内容"]) {
        textView.text = @"";
    }
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionOverrideInheritedCurve animations:^{
        CGRect rect = self.view.frame;
        rect.origin.y = rect.origin.y-shangshengH;
        self.view.frame = rect;
    } completion:^(BOOL finished) {
        
    }];
   
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [self HiddenKeyBoard];
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"请输入内容";
    }
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionOverrideInheritedCurve animations:^{
        CGRect rect = self.view.frame;
        rect.origin.y = rect.origin.y+shangshengH;
        self.view.frame = rect;
    } completion:^(BOOL finished) {
    }];
    return YES;
}
#pragma mark 发布
- (IBAction)buttonBeginFaBu:(id)sender {
    NSString* stringleibie = [self.buttonSelectLeiBie currentTitle];
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    AppDelegate* app = [UIApplication sharedApplication].delegate;
    
    if ([stringleibie isEqualToString:@"请选择"]) {
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择类别" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
        return;
    }
    NSString* tablename = @"shijan";
    NSArray* arraynames = [LeiBieDao getChongNameWithNStringTableName:tablename withName:self.textfielEven.text withUsers:[def objectForKey:@"name"] withLeiBieName:app.leibeis];
    if (arraynames.count>0) {
           [[[UIAlertView alloc] initWithTitle:@"提示" message:@"事件名字已经存在，请起新的名字" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
        return;
    }
    NSString* filename = [NSString stringWithFormat:@"%@%@",[def objectForKey:@"name"],[def objectForKey:@"pwd"]];
 
    [Most creatFolderWithName:[NSString stringWithFormat:@"%@/%@/%@",filename,app.leibeis,self.textfielEven.text]];
    /*
        视频和照片的转移
     */
    NSArray* arrayImage = [Most loadFileForArrayWithPath:[Most getSandBoxPathWithName:imageName_]];
    NSArray* arrayLuXiang = [Most loadFileForArrayWithPath:[Most getSandBoxPathWithName:luxiangName_]];
    for (NSString* string in arrayImage) {
        [Most moveFolderWithPaht:[Most getSandBoxPathWithName:[NSString stringWithFormat:@"%@/%@",imageName_,string]] toPath:[Most getSandBoxPathWithName:[NSString stringWithFormat:@"%@/%@/%@/%@",filename,app.leibeis,self.textfielEven.text,string]]];
    }
    for (NSString* strings in arrayLuXiang) {
        [Most moveFolderWithPaht:[Most getSandBoxPathWithName:[NSString stringWithFormat:@"%@/%@",luxiangName_,strings]] toPath:[Most getSandBoxPathWithName:[NSString stringWithFormat:@"%@/%@/%@/%@",filename,app.leibeis,self.textfielEven.text,strings]]];
    }
  
    /*
     将类别的名字存入到数据库中（方便排序和时间的记录）
     */
    NSString* stringtime = self.buttonSelectTime.currentTitle;
    NSString* stringTiXing = @"";
    if (self.kaiguan.on) {
        stringTiXing = @"1";
    }
    [LeiBieDao insertWithName:self.textfielEven.text withTime:stringtime withTableName:tablename withUserName:[def objectForKey:@"name"] withShiJianXiaDeLeiBieName:app.leibeis withTiXing:stringTiXing];
    /*
     文本的创建
     */
 
    [Most creatFileWithName:[NSString stringWithFormat:@"%@/%@/%@/%@.txt",filename,app.leibeis,self.textfielEven.text,self.textfielEven.text] WithString:self.textViewInput.text];
    if (self.kaiguan.on) {
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString* nowTime = [Most getTimeForSystemWithTimeAndDate];
        NSString* fuckTime = stringtime;
        NSDate *date1=[dateFormatter dateFromString:nowTime];
        NSDate *date2=[dateFormatter dateFromString:fuckTime];
       
        NSTimeInterval time=[date2 timeIntervalSinceDate:date1];
        NSLog(@"%f",time);
//        if (inter<=0.0) {
//            return;
//        }
        [app naozhong:(NSInteger)time withContent:self.textfielEven.text];
    }
    
    [self buttonBack:nil];
}
#pragma mark 键盘
-(void)sureKeyBoardShow:(NSNotification *)noti
{
    //获取通知键盘信息的值
    NSValue *value=[noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
//    NSLog(@"%@－%@-%@-%@",[noti.userInfo objectForKey:UIKeyboardDidChangeFrameNotification],[noti.userInfo objectForKey:UIKeyboardWillChangeFrameNotification],[noti.userInfo objectForKey:UIKeyboardCenterBeginUserInfoKey],[noti.userInfo objectForKey:UIKeyboardBoundsUserInfoKey]);
    //根据键盘的信息值获取坐标CGRect值
    CGRect frame=[value CGRectValue];
    //获取键盘出现动画的时间
    NSNumber * duration=[noti.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    CGRect keyboardFrame = [self.view convertRect:frame fromView:nil];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    self.bar.frame = CGRectMake(0,heights - keyboardFrame.size.height+10,withs,44);
    NSLog(@"%@",NSStringFromCGRect(self.bar.frame));
    [UIView commitAnimations];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.view.bounds = [UIScreen mainScreen].bounds;
    self.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
    self.views.bounds = [UIScreen mainScreen].bounds;
    self.views.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
    [Most creatFolderWithName:imageName_];
    [Most creatFolderWithName:luxiangName_];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sureKeyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
    self.photos = [Photo  sharedController];
    AppDelegate* app = [UIApplication sharedApplication].delegate;
    [app jianCeTongZhi];
}
#pragma mark 布局
-(void)buju
{
   
    self.buttonLuXiang.frame = CGRectMake(self.buttonLuXiang.frame.origin.x, self.collectionForImage.frame.origin.y+self.collectionForImage.frame.size.height+10,  self.buttonLuXiang.frame.size.width, self.buttonLuXiang.frame.size.height);
    self.luXiangImage.frame = CGRectMake(self.luXiangImage.frame.origin.x, self.buttonLuXiang.frame.origin.y+self.buttonLuXiang.frame.size.height, self.luXiangImage.frame.size.width, self.luXiangImage.frame.size.height);
    
    self.buttonSelectTime.center = CGPointMake(self.buttonSelectTime.center.x, self.buttonLuXiang.center.y);
    
    
    if (self.luXiangImage.hidden == NO) {
        self.buttonFaBu.frame = CGRectMake(self.luXiangImage.frame.origin.x, self.luXiangImage.frame.origin.y+self.luXiangImage.frame.size.height, self.luXiangImage.frame.size.width, self.luXiangImage.frame.size.height);
    }
    else
    {
       self.buttonFaBu.frame = CGRectMake(self.luXiangImage.frame.origin.x, self.buttonLuXiang.frame.origin.y+self.buttonLuXiang.frame.size.height, self.luXiangImage.frame.size.width, self.luXiangImage.frame.size.height);
    }
    if ((self.buttonFaBu.frame.origin.y+self.buttonFaBu.frame.size.height+self.scroller.frame.origin.y)>= heights) {
        self.scroller.contentSize = CGSizeMake(withs, self.buttonFaBu.frame.origin.y+self.buttonFaBu.frame.size.height+20);
    }
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self.view addSubview:self.views];
    
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
      [def setObject:[NSNumber numberWithLong:0] forKey:@"imageNums"];
    self.buttonFaBu.frame = CGRectMake(self.luXiangImage.frame.origin.x, self.buttonLuXiang.frame.origin.y+self.buttonLuXiang.frame.size.height, self.luXiangImage.frame.size.width, self.luXiangImage.frame.size.height);
    
    self.arrayForImage = [[NSMutableArray alloc] initWithCapacity:0];
    self.collectionForImage.hidden = YES;
    [self.collectionForImage registerNib:[UINib nibWithNibName:@"ImagesCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"collectionCellID"];
    
    
    self.luXiangImage.userInteractionEnabled = YES;
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bofangluxiang)];
    [self.luXiangImage addGestureRecognizer:tap];
    
    
   UIBarButtonItem* ite = [[UIBarButtonItem alloc] initWithTitle:@"关闭键盘" style:UIBarButtonItemStyleBordered target:self action:@selector(HiddenKeyBoard)];
    self.bar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,heights,withs,44)];
    self.bar.items = [NSArray arrayWithObjects:ite,nil];
    [self.view addSubview:self.bar];
    
    [self.buttonSelectTime setTitle:[Most getTimeForSystemWithDate] forState:UIControlStateNormal];
    UITapGestureRecognizer* taps = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenForPicker)];
    [self.viewDiTu addGestureRecognizer:taps];
    [self buju];

}
-(void)hiddenForPicker
{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.picker.center = CGPointMake(self.view.center.x, self.view.frame.size.height+self.picker.frame.size.height);
        self.datepic.center = CGPointMake(self.view.center.x, self.view.frame.size.height+self.picker.frame.size.height);
    } completion:^(BOOL finished) {
        
        [self.viewDiTu removeFromSuperview];
        [self.picker removeFromSuperview];
        [self.datepic removeFromSuperview];
    }];
    
}
-(void)HiddenKeyBoard{
    [self.textViewInput resignFirstResponder];
    [self.textfielEven resignFirstResponder];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    self.bar.frame = CGRectMake(0,heights, withs, 44);
    [UIView commitAnimations];
}
-(void)bofangluxiang
{
    WZKPlayViewController* play = [[WZKPlayViewController alloc] init];
    play.stringWithUrl = [self luxianglujing];
    [self presentViewController:play animated:YES completion:^{
        
    }];
}
#pragma mark 照相和录像
- (IBAction)buttonPhonto:(UIButton *)sender {
    [self HiddenKeyBoard];
    
    if ([self.arrayForImage count]>=9) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"照片已经上限" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    UIActionSheet* action = [[UIActionSheet alloc] initWithTitle:@"请选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"照相",@"相册", nil];
    [action showInView:self.view];
}
-(NSString*)luxianglujing{
    NSString *moveName=[NSString stringWithFormat:@"摄像.MOV"];
    NSString* documentsDirectory = [[Most getPathForDocument] stringByAppendingPathComponent:luxiangName_];
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:moveName];
    return fullPathToFile;
}
- (IBAction)luXiang:(id)sender {
    [self HiddenKeyBoard];
    OtherModel* luxiangs =  [OtherModel sharedController];
    UIImagePickerController* pick =  [luxiangs imageForLuXiang];
    luxiangs.blockForLuXiang = ^(void){
        NSURL* url = [[NSURL alloc] initFileURLWithPath:[self luxianglujing]];
        UIImage* image_ = [luxiangs thumbnailImageForVideo:url atTime:0.0];
        self.luXiangImage.image = image_;
        self.luXiangImage.hidden = NO;
        [self buju];
    };
    [self presentViewController:pick animated:YES completion:^{
        
    }];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
   
    switch (buttonIndex) {
        case 0:
        {
            UIImagePickerController* pic = [self.photos imageForPhotoOrLibrary:@"photo"];
            
            [self presentViewController:pic animated:YES completion:^{
                
            }];
        }
            break;
        case 1:
        {
            UIImagePickerController* pic = [self.photos imageForPhotoOrLibrary:@"library"];
            [self presentViewController:pic animated:YES completion:^{
                
            }];
        }
            break;
        default:
            break;
    }
 
    self.photos.blockPhotoEnd = ^(UIImage* image){
        self.collectionForImage.hidden = NO;
        self.buttonAddImage.hidden = YES;
        self.arrayForImage = [Most loadFileForArrayWithPath:[[Most getPathForDocument] stringByAppendingPathComponent:imageName_]];
        NSInteger nums = self.arrayForImage.count/3;
        NSInteger yushu = self.arrayForImage.count%3;
        if (yushu != 0) {
            nums+=1;
        }
        CGFloat fl = nums*80;
        if (self.arrayForImage.count>2) {
            fl = 80*2;
        }
        
        self.collectionForImage.frame = CGRectMake(self.collectionForImage.frame.origin.x, self.collectionForImage.frame.origin.y, self.collectionForImage.frame.size.width, fl);
        
        [self buju];
        [self.collectionForImage reloadData];
    };
}
#pragma mark UICollectionView的设置
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSUInteger inte = [self.arrayForImage count];
    if (inte != 0) {
        inte+=1;
    }
    return inte;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* string  = @"collectionCellID";
    ImagesCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:string forIndexPath:indexPath];
    
    
    if (indexPath.row == [self.arrayForImage count]) {
        cell.imageAdd.image = [UIImage imageNamed:@"+image.png"];
    }
    else
    {
        NSString* stringImagePath = [NSString stringWithFormat:@"%@/%@",[[Most getPathForDocument] stringByAppendingPathComponent:imageName_],[self.arrayForImage objectAtIndex:indexPath.row]];
        UIImage* imagess = [UIImage imageWithContentsOfFile:stringImagePath];
        cell.imageBig = imagess;
        CGFloat fw = cell.imageAdd.frame.size.width/imagess.size.width;//小于0
        CGFloat fh = cell.imageAdd.frame.size.height/imagess.size.height;
        NSLog(@"%f",cell.imageAdd.frame.size.width);
        if (fw>fh) {//以宽为基准
           imagess = [self.photos imageWithImageSimple:imagess scaledToSize:CGSizeMake(cell.imageAdd.frame.size.width, (imagess.size.height)*fw)];
        }
        else
        {//以高为基准
            imagess = [self.photos imageWithImageSimple:imagess scaledToSize:CGSizeMake((imagess.size.width)*fh, cell.imageAdd.frame.size.height)];
        }
        cell.imageAdd.image = imagess;
      
    }
   
    return cell;

}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(80, 80);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [self.arrayForImage count]) {
        [self buttonPhonto:nil];
    }
    else
    {
        BigImageViewController* big = [[BigImageViewController alloc] init];
        ImagesCollectionViewCell* cell = (ImagesCollectionViewCell* )[collectionView cellForItemAtIndexPath:indexPath];
        big.image_ = cell.imageBig;
        big.transitioningDelegate = self;
        [self presentViewController:big animated:YES completion:^{
        }];
    }
}


- (IBAction)back:(id)sender {
    [self HiddenKeyBoard];
    [UIView animateWithDuration:1 animations:^{
        self.views.alpha = 0;
    } completion:^(BOOL finished) {
         [self.views removeFromSuperview];
    }];
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonBack:(id)sender {
    [self HiddenKeyBoard];
    [OtherModel playSound:soundID];
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:^{
        /*
         返回首页，再议
         */
            AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
            [app.menu showRootController:YES];
            [app removeImages];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
