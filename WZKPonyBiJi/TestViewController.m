//
//  TestViewController.m
//  WZKPonyBiJi
//
//  Created by 王正魁 on 15-3-19.
//  Copyright (c) 2015年 psylife. All rights reserved.
//

#import "TestViewController.h"
#import "AppDelegate.h"
#import "AddEvenViewController.h"
#import "Most.h"
#import "Photo.h"
#import "LeiBieXiangQingViewController.h"
@interface TestViewController ()
{
    NSArray* arrayImage;
}
@property (strong, nonatomic) IBOutlet UIView *addleibieview;
@property (strong, nonatomic) IBOutlet UITableView *tableViews;
@property (strong, nonatomic) IBOutlet UILabel *labelName;
@property (strong, nonatomic) IBOutlet UILabel *labelNumForEven;
@property (strong, nonatomic) IBOutlet UIButton *buttonAddEven;
@property(nonatomic,strong)UIImageView* imagev;
@property (strong, nonatomic) IBOutlet UITextField *leibienametext;
@end

@implementation TestViewController
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.leibienametext) {
        [self.leibienametext resignFirstResponder];
        [UIView animateWithDuration:0.35 animations:^{
            CGRect rect =  self.addleibieview.frame;
            rect.origin.y = rect.origin.y + 40;
            self.addleibieview.frame = rect;
        } completion:^(BOOL finished) {
            
        }];
        return YES;
    }
    return NO;
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.leibienametext) {
        [UIView animateWithDuration:0.35 animations:^{
            CGRect rect =   self.addleibieview.frame;
            rect.origin.y = rect.origin.y - 40;
            self.addleibieview.frame = rect;
        } completion:^(BOOL finished) {
            
        }];
        return YES;
    }
    return NO;
}
-(BOOL)牛逼
{
    
    NSString* type = @"/:%$@!*^http＊&％¥＃@！";
    return [type rangeOfString:self.leibienametext.text].location == NSNotFound;
    
}
- (IBAction)addleibieok:(id)sender {
    [OtherModel playSound:soundID];
    if ([self.leibienametext.text isEqualToString:@""]||(self.leibienametext.text == nil)){
        return;
    }
//    if ([self.leibienametext.text containsString:@"/"]||[self.leibienametext.text containsString:@":"]||[self.leibienametext.text containsString:@"："]||[self.leibienametext.text containsString:@"@"]||[self.leibienametext.text containsString:@"%"]||[self.leibienametext.text containsString:@"http"]) {
    NSLog(@"%d",[self 牛逼]);
    if (([self.leibienametext.text rangeOfString:@"/"].location != NSNotFound)||([self.leibienametext.text rangeOfString:@":"].location != NSNotFound)||([self.leibienametext.text rangeOfString:@"："].location != NSNotFound)||([self.leibienametext.text rangeOfString:@"@"].location != NSNotFound)||([self.leibienametext.text rangeOfString:@"%"].location != NSNotFound)||([self.leibienametext.text rangeOfString:@"http"].location != NSNotFound)) {
     
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"不能含有特殊字符" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    NSString* username = [def objectForKey:@"name"];
    NSArray* arraylei = [LeiBieDao getChongNameWithNStringTableName:@"leibie" withName:self.leibienametext.text withUsers:username withLeiBieName:nil];
    if (arraylei.count > 0) {
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"类别名字已经存在，请起新的名字" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
        return ;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.addleibieview.center = CGPointMake(withs/2, heights+self.addleibieview.frame.size.height);
    } completion:^(BOOL finished) {
        
        
        [self.addleibieview removeFromSuperview];
        [self.imagev removeFromSuperview];
       
        NSString* filename = [NSString stringWithFormat:@"%@%@",[def objectForKey:@"name"],[def objectForKey:@"pwd"]];
        
        [Most creatFolderWithName:[NSString stringWithFormat:@"%@/%@",filename,self.leibienametext.text]];
        AppDelegate* app = [UIApplication sharedApplication].delegate;
        app.leibeis = self.leibienametext.text;
        [LeiBieDao insertWithName:app.leibeis withTime:[Most getTimeForSystemWithDate] withTableName:@"leibie" withUserName:[def objectForKey:@"name"] withShiJianXiaDeLeiBieName:nil withTiXing:@""];
        [self viewWillAppear:YES];
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self performSelectorInBackground:@selector(relodeshuju) withObject:self];
}
- (IBAction)addLeiBie:(id)sender {
    [OtherModel playSound:soundID];
    Photo* p = [Photo sharedController];
    AppDelegate* app = [UIApplication sharedApplication].delegate;
    UIImage* image1 = [p jiping:app.menu.view];
//    UIImage* image2 = [p blurryImage:image1 withBlurLevel:0.2];
    UIImage* image2 = [p applyBlurRadius:15 toImage:image1];
//    UIImageWriteToSavedPhotosAlbum(image2, nil, nil, nil);
    self.imagev = [[UIImageView alloc] initWithImage:image2];
   
    self.imagev.contentMode = UIViewContentModeScaleToFill;
    self.imagev.clipsToBounds = YES;
    self.imagev.frame = CGRectMake(0, 0, withs, heights);
    self.imagev.userInteractionEnabled = YES;
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectImage)];
    [self.imagev addGestureRecognizer:tap];
    app.menu.view.clipsToBounds = YES;
    [app.menu.view addSubview:self.imagev];
    [app.menu.view addSubview:self.addleibieview];
    self.addleibieview.bounds = CGRectMake(0, 0, self.addleibieview.frame.size.width, self.addleibieview.frame.size.height);
    self.addleibieview.center = CGPointMake(withs/2, -self.addleibieview.frame.size.height);
    [UIView animateWithDuration:0.3 animations:^{
         self.addleibieview.center = CGPointMake(withs/2, heights/2);
    }];
 
}
-(IBAction)selectImage
{
    [OtherModel playSound:soundID];
    [UIView animateWithDuration:0.3 animations:^{
        self.addleibieview.center = CGPointMake(withs/2, heights+self.addleibieview.frame.size.height);
    } completion:^(BOOL finished) {
        [self.addleibieview removeFromSuperview];
        [self.imagev removeFromSuperview];

    }];
}
-(void)viewDidDisappear:(BOOL)animated
{
    arrayImage = nil;
}
-(void)relodeshuju
{
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
   
    arrayImage = [LeiBieDao getLeiBieXiaDeNameWithNStringTableName:@"leibie" withUsers:[def objectForKey:@"name"] withLeiBieName:nil];
    [self performSelectorOnMainThread:@selector(tableRelode) withObject:self waitUntilDone:NO];
}
-(void)tableRelode
{
    self.labelNumForEven.text = [NSString stringWithFormat:@"%lu",(unsigned long)[arrayImage count]];
    [self.tableViews reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.buttonAddEven.clipsToBounds = YES;
    self.buttonAddEven.layer.cornerRadius = 35;
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];

    self.labelName.text = [def objectForKey:@"name"];
    
    CGRect rect = self.tableViews.frame;
    rect.size.height = self.view.frame.size.height-self.tableViews.frame.origin.y;
    self.tableViews.frame = rect;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayImage count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* string = @"cellid";
    TestTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:string];
    if (cell == nil) {
        NSArray* array = [[NSBundle mainBundle] loadNibNamed:@"TestTableViewCell" owner:self options:nil];
        if ([array count] != 0) {
             cell = [array firstObject];
        }
       
    }
    LeiBie* leibeis = [arrayImage objectAtIndex:indexPath.row];
    
    cell.label.numberOfLines = -1;
    cell.label.lineBreakMode = NSLineBreakByWordWrapping;
    cell.label.text = leibeis.name;
    cell.labelTime.text = [NSString stringWithFormat:@"时间：%@",leibeis.timess];
    [cell.WZKButton addTarget:self action:@selector(buttonselect:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat fh = 0;
    if (arrayImage.count>0) {
        LeiBie* leibeis = [arrayImage objectAtIndex:indexPath.row];
        fh = [Most getHeightWithString:leibeis.name WithFontSize:15];
    }
    
  
    
    
    return fh+21*2+30;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [OtherModel playSound:soundID];
    
    AppDelegate * app = [UIApplication sharedApplication].delegate;
    LeiBieXiangQingViewController* even = [[LeiBieXiangQingViewController alloc] init];
    LeiBie* lb = [arrayImage objectAtIndex:indexPath.row];
    even.typeName = lb.name;//事件名字
    [app.menu setRootController:even animated:YES];
}
-(void)buttonselect:(UIButton*)button
{
      [OtherModel playSound:soundID];
   
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
