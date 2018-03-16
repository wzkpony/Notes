//
//  ViewController.m
//  WZKPonyBiJi
//
//  Created by 王正魁 on 15-3-14.
//  Copyright (c) 2015年 psylife. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}
- (IBAction)buttonLogin:(UIButton *)sender {
    MainViewController* main = [[MainViewController alloc] init];
    [self.navigationController pushViewController:main animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonSelect:(UIButton *)sender {
    MainViewController* main = [[MainViewController alloc] init];
    [self.navigationController pushViewController:main animated:YES];
}
@end
