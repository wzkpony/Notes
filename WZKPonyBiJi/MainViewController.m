//
//  MainViewController.m
//  WZKPonyBiJi
//
//  Created by 王正魁 on 15-3-14.
//  Copyright (c) 2015年 psylife. All rights reserved.
//

#import "MainViewController.h"
#import "test1.h"
#import "AppDelegate.h"
#import "WZKTViewController.h"
#import "LoginViewController.h"
#import "NSURLConnection+WZKConnection.h"
#import "AddEvenViewController.h"
#import "EvenForLeiBieTableViewCell.h"
#import "ShiJianXiangQingViewController.h"
@interface MainViewController ()
{
    NSString* tady;
}
@property(nonatomic,strong) test1* t;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UIButton *kuaiJieButton;
@property (strong, nonatomic) IBOutlet UILabel *labelNoNeiRong;

@end

@implementation MainViewController
@synthesize keys;
-(void)addlogin
{
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    NSString* name = [def objectForKey:@"name"];
    NSString* pwd = [def objectForKey:@"pwd"];
    if (([name isEqualToString:@""])||(name == nil)||(([pwd isEqualToString:@""])||(pwd == nil))) {
        LoginViewController* login = [[LoginViewController alloc] init];
        login.transitioningDelegate = self;
        AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
        
        [app.menu presentViewController:login animated:YES completion:^{
            
        }];
        return;
    }
    
}
- (IBAction)buttonChuangJian:(id)sender {
    [OtherModel playSound:soundID];
    self.kuaiJieButton.alpha = 1.0;
    [self performSelector:@selector(alphaButton) withObject:self afterDelay:2];
    AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    //            [app.menu showRootController:YES];
    AddEvenViewController* even = [[AddEvenViewController alloc] init];
    even.transitioningDelegate = self;
    [app.menu presentViewController:even animated:YES completion:^{
    }];
    
}
-(void)alphaButton
{
    self.kuaiJieButton.alpha = 0.5;
}
-(void)shezhibutton
{
    self.kuaiJieButton.clipsToBounds = YES;
    self.kuaiJieButton.layer.cornerRadius = self.kuaiJieButton.frame.size.width/2.0;
    self.kuaiJieButton.bounds = CGRectZero;
    [UIView animateWithDuration:0.5 delay:0.3 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.kuaiJieButton.bounds = CGRectMake(0, 0, 50, 50);
    } completion:^(BOOL finished) {
        
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    [self shezhibutton];
    [self aniamgeton];
//    CGRect rect = self.tableview.frame;
//    rect.size.height = self.view.frame.size.height-self.tableview.frame.origin.y-44;
//    self.tableview.frame = rect;
////
//    CGRect rectk = self.kuaiJieButton.frame;
//    rectk.origin.y = heights-70-44;
//    self.kuaiJieButton.frame = rectk;
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    if ([self.keys count]==0) {
        self.labelNoNeiRong.hidden = NO;
//        tableView.hidden = YES;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    else
    {
         self.labelNoNeiRong.hidden = YES;
         tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//        tableView.hidden = NO;
    }
    return [self.keys count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* string = @"evencellid";
    EvenForLeiBieTableViewCell* cell = ( EvenForLeiBieTableViewCell* )[tableView dequeueReusableCellWithIdentifier:string];
    if (cell == nil) {
        NSArray* array = [[NSBundle mainBundle] loadNibNamed:@"EvenForLeiBieTableViewCell" owner:self options:nil];
        if ([array count] != 0) {
            cell = [array firstObject];
        }
        
    }
    LeiBie* lb = [self.keys objectAtIndex:indexPath.row];
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    NSString* filename = [NSString stringWithFormat:@"%@%@/%@/%@",[def objectForKey:@"name"],[def objectForKey:@"pwd"],lb.leibie,lb.name];
    
    NSMutableArray* array = [Most selectFileWithPath:[Most getSandBoxPathWithName:filename] WithNameForType:@"txt"];//到事件文件夹
    NSString* stringpaht = @"";
    if (array.count>0) {
        stringpaht = [NSString stringWithFormat:@"%@",[array lastObject]];//到事件文件夹里的txt文件
    }
    
    NSURL* url = [[NSURL alloc]initFileURLWithPath: stringpaht];
    NSString* context = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    cell.evenContext.text = context;
    cell.evenName.text = lb.name;
    cell.evenTime.text = lb.timess;
    
    NSArray* arrayi = [Most selectFileWithPath:[Most getSandBoxPathWithName:filename] WithNameForType:@"png"];
    NSArray* arraym = [Most selectFileWithPath:[Most getSandBoxPathWithName:filename] WithNameForType:@"MOV"];
    if ((arrayi.count>0)||(arraym.count>0)) {
        //显示
        cell.Labelgengduo.hidden = NO;
        cell.imageForImage.hidden = NO;
    }
    else
    {
        //隐藏
        cell.Labelgengduo.hidden = YES;
        cell.imageForImage.hidden = YES;
    }
    [cell buju];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LeiBie* lb = [self.keys objectAtIndex:indexPath.row];
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    NSString* filename = [NSString stringWithFormat:@"%@%@/%@/%@",[def objectForKey:@"name"],[def objectForKey:@"pwd"],lb.leibie,lb.name];
    
    NSMutableArray* array = [Most selectFileWithPath:[Most getSandBoxPathWithName:filename] WithNameForType:@"txt"];
    NSString* stringpaht = @"";
    if (array.count>0) {
        
        stringpaht = [NSString stringWithFormat:@"%@",[array lastObject]];//到事件文件夹里的txt文件
    }
    NSURL* url = [[NSURL alloc]initFileURLWithPath: stringpaht];
    NSString* context = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    CGFloat fh = [Most getHeightWithString:context WithFontSize:14];
    
    return fh+21*2+20;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [OtherModel playSound:soundID];
    ShiJianXiangQingViewController* shijian = [[ShiJianXiangQingViewController alloc] init];
    
    LeiBie* lb = [self.keys objectAtIndex:indexPath.row];
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    NSString* filename = [NSString stringWithFormat:@"%@%@/%@/%@",[def objectForKey:@"name"],[def objectForKey:@"pwd"],lb.leibie,lb.name];//(用户名密码/类别/事件名字)
    
    NSMutableArray* array = [Most selectFileWithPath:[Most getSandBoxPathWithName:filename] WithNameForType:@"txt"];//到事件文件夹
    NSString* stringpaht = [NSString stringWithFormat:@"%@",[array lastObject]];//到事件文件夹里的txt文件
    
    NSURL* url = [[NSURL alloc]initFileURLWithPath: stringpaht];
    NSString* context = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    shijian.stringNeiRong = context;
    shijian.stringTitle = lb.name;
    shijian.stringLeiBie = lb.leibie;
    shijian.transitioningDelegate = self;
    AppDelegate * app = [UIApplication sharedApplication].delegate;
    [app.menu presentViewController:shijian animated:YES completion:^{
        
    }];
}
#pragma mark 过去
- (IBAction)guoqu:(id)sender {
    [OtherModel playSound:soundID];
      [self shezhibutton];
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    NSString* name = [def objectForKey:@"name"];
    self.keys = [LeiBieDao getQianTimesNameWithNStringTableName:@"shijan" withUsers:name withLeiBieName:nil withTime:nil];
    [self.tableview reloadData];
    UIButton* button1 = (UIButton* )[self.view viewWithTag:101];
    UIButton* button2 = (UIButton* )[self.view viewWithTag:102];
    UIButton* button0 = (UIButton* )[self.view viewWithTag:100];
    [self buttonForOne:button2 withTwo:button0 withThree:button1];

}
-(void)shenguin
{
    [OtherModel playSound:soundID];
}
-(void)viewDidDisappear:(BOOL)animated
{
//    AppDelegate * app = [UIApplication sharedApplication].delegate;
  
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.tableview reloadData];
    [self tableview ];
}
-(void)viewDidAppear:(BOOL)animated
{
    [self performSelector:@selector(addlogin) withObject:self afterDelay:0.0];

}
-(void)aniamgeton
{
    self.t = [test1 new];
    tady = [Most getTimeForSystemWithDate];
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    NSString* name = [def objectForKey:@"name"];
    self.keys = [LeiBieDao getTimesNameWithNStringTableName:@"shijan" withUsers:name withLeiBieName:nil withTime:tady];
    [self.tableview reloadData];
}
#pragma mark 未来
- (IBAction)buttonSelect:(UIButton *)sender {
    [OtherModel playSound:soundID];
//    WZKTViewController* next = [[WZKTViewController alloc] init];
//    next.transitioningDelegate = self;
//    [self presentViewController:next animated:YES completion:^{
//        
//    }];
    [self shezhibutton];
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    NSString* name = [def objectForKey:@"name"];
    self.keys = [LeiBieDao getWeiLaiTimesNameWithNStringTableName:@"shijan" withUsers:name withLeiBieName:nil withTime:nil];
    [self.tableview reloadData];
    
    UIButton* button1 = (UIButton* )[self.view viewWithTag:101];
     UIButton* button2 = (UIButton* )[self.view viewWithTag:102];
     UIButton* button0 = (UIButton* )[self.view viewWithTag:100];
    [self buttonForOne:button1 withTwo:button2 withThree:button0];
}
-(void)buttonForOne:(UIButton*)button0 withTwo:(UIButton*)button1 withThree:(UIButton*)button2
{
    [button1 setTitleColor:[UIColor colorWithRed:24.0/255 green:90.0/255 blue:224.0/255 alpha:1] forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor colorWithRed:24.0/255 green:90.0/255 blue:224.0/255 alpha:1] forState:UIControlStateNormal];
    
    
    [button0 setTitleColor:[UIColor colorWithRed:61.0/255 green:211.0/255 blue:78.0/255 alpha:1] forState:UIControlStateNormal];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonPerson:(id)sender {
    [OtherModel playSound:soundID];

    AppDelegate * app = [UIApplication sharedApplication].delegate;
    [app.menu showLeftController:YES];
}
- (IBAction)buttonTixing:(id)sender {
    [OtherModel playSound:soundID];
    AppDelegate * app = [UIApplication sharedApplication].delegate;
    [app.menu showRightController:YES];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}

-(id<xieyidelegate>)addtest
{
    [self.t firstMethod];
    [self.t secondMethod];
    return self.t;
    
}
#pragma mark 现在
- (IBAction)buttonTest:(id)sender {
    [OtherModel playSound:soundID];
    [self aniamgeton];
    [self shezhibutton];
    UIButton* button1 = (UIButton* )[self.view viewWithTag:101];
    UIButton* button2 = (UIButton* )[self.view viewWithTag:102];
    UIButton* button0 = (UIButton* )[self.view viewWithTag:100];
    [self buttonForOne:button0 withTwo:button2 withThree:button1];
    
}




@end
