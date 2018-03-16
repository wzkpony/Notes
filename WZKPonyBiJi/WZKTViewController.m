//
//  WZKTViewController.m
//  WZKPonyBiJi
//
//  Created by 王正魁 on 15-3-20.
//  Copyright (c) 2015年 psylife. All rights reserved.
//

#import "WZKTViewController.h"
#import "AppDelegate.h"
@interface WZKTViewController ()
@property(nonatomic,strong)UIView* backgroundView;
@property(nonatomic,strong)UILabel* textInfoLabel;
@end

@implementation WZKTViewController
-(void)viewWillAppear:(BOOL)animated
{
//    AppDelegate * app = [UIApplication sharedApplication].delegate;
//    [app.menu setEnableGesture:NO];
    self.view.bounds = [UIScreen mainScreen].bounds;
    self.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    /*//VFL
    self.backgroundView = [[UIView alloc] init];
    [self.backgroundView setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.backgroundView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.backgroundView];
    
    self.textInfoLabel = [[UILabel alloc] init];
    [self.textInfoLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.textInfoLabel.backgroundColor = [UIColor redColor];
    self.textInfoLabel.numberOfLines = 0;
    self.textInfoLabel.font = [UIFont systemFontOfSize:15];
    self.textInfoLabel.text = @"测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试";
    [self.view addSubview:self.textInfoLabel];
    
    NSDictionary *views = @{@"backgroundView":self.backgroundView, @"textInfoLabel":self.textInfoLabel};
    NSDictionary *metrics = @{@"LeftStep":@20, @"TopStep":@100, @"Width":@200, @"Height":@100, @"VStep":@20, @"HStep":@20};
    NSString *vLayoutString = @"V:|-TopStep-[backgroundView(==Width)]-VStep-[textInfoLabel(>=20)]";
    NSArray *vLayoutArray = [NSLayoutConstraint constraintsWithVisualFormat:vLayoutString options:0 metrics:metrics views:views];//metrics 和 views 相当于度量表（参考表）     vLayoutString是位置的约束
  
    
    
    NSString *hLayoutstring = @"H:|-LeftStep-[backgroundView(==Height)]-HStep-[textInfoLabel(==100)]";
    NSArray *hLayoutArray = [NSLayoutConstraint constraintsWithVisualFormat:hLayoutstring options:0 metrics:metrics views:views];
    
    
    [self.view addConstraints:vLayoutArray];
    [self.view addConstraints:hLayoutArray];
     */
}
-(void)viewDidDisappear:(BOOL)animated
{
//    AppDelegate * app = [UIApplication sharedApplication].delegate;
//    [app.menu setEnableGesture:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonBack:(id)sender {
    [OtherModel playSound:soundID];
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:^{
        
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
