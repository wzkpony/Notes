//
//  NextViewController.m
//  WZKPonyBiJi
//
//  Created by 王正魁 on 15-3-18.
//  Copyright (c) 2015年 psylife. All rights reserved.
//

#import "NextViewController.h"
#import "AddEvenViewController.h"
#import "AppDelegate.h"
#import "LeiBieDao.h"
#import "SheZhiViewController.h"
#define with [UIScreen mainScreen].bounds.size.width
#define heights [UIScreen mainScreen].bounds.size.height
@interface NextViewController ()
{
    int withForSegment;
}
@property (strong, nonatomic) IBOutlet UILabel *ShiJianTiXing;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segment;
@property (strong, nonatomic) IBOutlet UITableView *tableViewTiXing;
@property(strong,nonatomic)NSArray* arrayCode;
@end

@implementation NextViewController
-(void)viewDidAppear:(BOOL)animated
{
//    self.segment.center = CGPointMake(withForSegment, -30);
//    self.tableViewTiXing.frame = CGRectMake(47, 86, 256, 474);
//    self.ShiJianTiXing.frame = CGRectMake(47, 57, 181, 21);
//    AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;

//    app.menu.delegate = self;
    self.arrayCode = [LeiBieDao getAllTiXingNameWithNStringTableName:@"shijan" withTiXingFol:@"1"];
    [self.tableViewTiXing reloadData];
}
-(void)viewDidDisappear:(BOOL)animated
{
//    AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
//    
//    app.menu.delegate =  nil;
    self.arrayCode = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    withForSegment = with-140;
    self.tableViewTiXing.delegate = self;
    self.tableViewTiXing.dataSource = self;
    
    CGRect rect = self.tableViewTiXing.frame;
    rect.size.height = self.view.frame.size.height-self.tableViewTiXing.frame.origin.y;
    self.tableViewTiXing.frame = rect;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayCode.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellid = @"cellid";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    }
    
 
    
    LeiBie* leibie = [self.arrayCode objectAtIndex:indexPath.row];
    
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString* nowTime = [Most getTimeForSystemWithTimeAndDate];
    NSString* fuckTime = leibie.timess;
    NSDate *date1=[dateFormatter dateFromString:nowTime];
    NSDate *date2=[dateFormatter dateFromString:fuckTime];
    
    NSTimeInterval time=[date2 timeIntervalSinceDate:date1];
    if (time <= 0) {
        cell.textLabel.textColor = [UIColor grayColor];
        cell.detailTextLabel.text = @"已过期";
    }
    else
    {
        cell.textLabel.textColor = [UIColor blackColor];
         cell.detailTextLabel.text = [NSString stringWithFormat:@"正在倒计时"];
    }
    
    cell.textLabel.text = leibie.name;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShiJianXiangQingViewController* shijian = [[ShiJianXiangQingViewController alloc] init];
    
    LeiBie* lb = [self.arrayCode objectAtIndex:indexPath.row];
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
    [self presentViewController:shijian animated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)segmentShow
{
    [UIView animateWithDuration:0.5 delay:0.2 usingSpringWithDamping:0.5 initialSpringVelocity:0.8 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.segment.center = CGPointMake( self.segment.center.x, 97);
        self.tableViewTiXing.frame = CGRectMake(47, 167, self.tableViewTiXing.frame.size.width, heights-172);
        self.ShiJianTiXing.frame = CGRectMake(47, 138, 181, 21);
    } completion:^(BOOL finished) {
        
    }];
}
-(void)segmentHidden
{
    [UIView animateWithDuration:0.6 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:0.8 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.segment.center = CGPointMake(self.segment.center.x, -30);
        self.tableViewTiXing.frame = CGRectMake(47, 86, self.tableViewTiXing.frame.size.width, heights-172+81);
        self.ShiJianTiXing.frame = CGRectMake(47, 57, 181, 21);
    } completion:^(BOOL finished) {
        
    }];
}
- (IBAction)buttonSelecct:(id)sender {
    UIButton* button = (UIButton*)sender;
    if(self.segment.center.y<0){
        button.selected = NO;
    }
    if (button.selected == NO) {
        [self segmentShow];
    }
    else
    {
        [self segmentHidden];

    }
    button.selected = !button.selected;
   
}
- (IBAction)enditMore:(id)sender {
    [OtherModel playSound:soundID];
    UISegmentedControl* seg = (UISegmentedControl*)sender;
    
    switch (seg.selectedSegmentIndex) {
        case 0://添加事件
        {
            AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
//            [app.menu showRootController:YES];
            AddEvenViewController* even = [[AddEvenViewController alloc] init];
            even.transitioningDelegate = self;
            [app.menu presentViewController:even animated:YES completion:^{
            }];

            
            
        }
            break;
        case 1://编辑事件－－>设置
        {
            AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
            //            [app.menu showRootController:YES];
            SheZhiViewController* shezhi = [[SheZhiViewController alloc] init];
            shezhi.transitioningDelegate = self;
            [app.menu presentViewController:shezhi animated:YES completion:^{
            }];
        }
            break;
        case 2://设置-->暂时不要这个功能
        {
            
        }
            break;
            
        default:
            break;
    }
    
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (velocity.y<0) {
        [self segmentShow];
    }
    else
    {
        [self segmentHidden];
    }
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
