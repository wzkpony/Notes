//
//  LeiBieXiangQingViewController.m
//  WZKPonyBiJi
//
//  Created by 王正魁 on 15-4-1.
//  Copyright (c) 2015年 psylife. All rights reserved.
//

#import "LeiBieXiangQingViewController.h"
#import "Most.h"
#import "EvenForLeiBieTableViewCell.h"
#import "AppDelegate.h"
#import "AddEvenViewController.h"
#import "ShiJianXiangQingViewController.h"
@interface LeiBieXiangQingViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableViewS;
@property (strong, nonatomic) IBOutlet UILabel *labelTitle;
@property(strong,nonatomic)NSArray* arrayImage;
@property (strong, nonatomic) IBOutlet UIButton *kuaiJieButton;
@end

@implementation LeiBieXiangQingViewController
- (IBAction)shouZuoCe:(id)sender {
    [OtherModel playSound:soundID];
    
    AppDelegate * app = [UIApplication sharedApplication].delegate;
    [app.menu showLeftController:YES];
    
}
- (IBAction)buttonChuangJian:(id)sender {
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
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    //    NSString* filename = [NSString stringWithFormat:@"%@%@/       %@",[def objectForKey:@"name"],[def objectForKey:@"pwd"],self.typeName];
    //    _arrayImage = [Most loadFileForArrayWithPath:[Most getSandBoxPathWithName:filename]];
    _arrayImage = [LeiBieDao getLeiBieXiaDeNameWithNStringTableName:@"shijan" withUsers:[def objectForKey:@"name"] withLeiBieName:self.typeName];//self.typeName
    [self.tableViewS reloadData];
    self.labelTitle.text = self.typeName;
    
    CGRect rect = self.tableViewS.frame;
    rect.size.height = self.view.frame.size.height-self.tableViewS.frame.origin.y;
    self.tableViewS.frame = rect;
    
    CGRect rectk = self.kuaiJieButton.frame;
    rectk.origin.y = heights-70;
    self.kuaiJieButton.frame = rectk;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [self.tableViewS reloadData];
    
    self.kuaiJieButton.clipsToBounds = YES;
    self.kuaiJieButton.layer.cornerRadius = self.kuaiJieButton.frame.size.width/2.0;
    self.kuaiJieButton.bounds = CGRectZero;
    
    [UIView animateWithDuration:0.5 delay:0.3 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.kuaiJieButton.bounds = CGRectMake(0, 0, 50, 50);
    } completion:^(BOOL finished) {
        
    }];
}
- (IBAction)buttonGeRenZhongXin:(id)sender {
     [OtherModel playSound:soundID];
    AppDelegate * app = [UIApplication sharedApplication].delegate;
//    MainViewController* main = [[MainViewController alloc] init];
//    app.menu.pan.cancelsTouchesInView = NO;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.view.bounds;
        rect.size.height = 0;
        rect.size.width = 0;
        self.view.bounds = rect;
        self.view.alpha = 0.1;
        
    } completion:^(BOOL finished) {
        [app.menu setRootController:app.main animated:YES];
    }];
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arrayImage count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* string = @"evencellid";
    EvenForLeiBieTableViewCell* cell = ( EvenForLeiBieTableViewCell* )[tableView dequeueReusableCellWithIdentifier:string];
    if (cell == nil) {
        NSArray* array = [[NSBundle mainBundle] loadNibNamed:@"EvenForLeiBieTableViewCell" owner:self options:nil];
        if ([array count] != 0) {
            cell = [array firstObject];
        }
        
    }
    LeiBie* lb = [_arrayImage objectAtIndex:indexPath.row];
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    NSString* filename = [NSString stringWithFormat:@"%@%@/%@/%@",[def objectForKey:@"name"],[def objectForKey:@"pwd"],self.typeName,lb.name];

    NSMutableArray* array = [Most selectFileWithPath:[Most getSandBoxPathWithName:filename] WithNameForType:@"txt"];//到事件文件夹
    NSString* stringpaht = [NSString stringWithFormat:@"%@",[array lastObject]];//到事件文件夹里的txt文件

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
    LeiBie* lb = [_arrayImage objectAtIndex:indexPath.row];
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [OtherModel playSound:soundID];
    ShiJianXiangQingViewController* shijian = [[ShiJianXiangQingViewController alloc] init];
    
    LeiBie* lb = [_arrayImage objectAtIndex:indexPath.row];
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    NSString* filename = [NSString stringWithFormat:@"%@%@/%@/%@",[def objectForKey:@"name"],[def objectForKey:@"pwd"],self.typeName,lb.name];//(用户名密码/类别/事件名字)
    
    NSMutableArray* array = [Most selectFileWithPath:[Most getSandBoxPathWithName:filename] WithNameForType:@"txt"];//到事件文件夹
    NSString* stringpaht = [NSString stringWithFormat:@"%@",[array lastObject]];//到事件文件夹里的txt文件
    
    NSURL* url = [[NSURL alloc]initFileURLWithPath: stringpaht];
    NSString* context = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    shijian.stringNeiRong = context;
    shijian.stringTitle = lb.name;
    shijian.stringLeiBie = self.typeName;
    shijian.transitioningDelegate = self;
    AppDelegate * app = [UIApplication sharedApplication].delegate;
    [app.menu presentViewController:shijian animated:YES completion:^{
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
