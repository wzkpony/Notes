//
//  LoginViewController.m
//  WZKPonyBiJi
//
//  Created by 王正魁 on 15-3-31.
//  Copyright (c) 2015年 psylife. All rights reserved.
//

#import "LoginViewController.h"
#import "Most.h"
@interface LoginViewController ()
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *pwd;

@end

@implementation LoginViewController

- (IBAction)loginBegin:(id)sender {
    if (([self.name.text isEqualToString:@""])||(self.name.text == nil)) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入用户名" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    else if (([self.pwd.text isEqualToString:@""])||(self.pwd.text == nil))
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    NSString* stringFileName = [NSString stringWithFormat:@"%@%@",self.name.text,self.pwd.text];
    [Most creatFolderWithName:stringFileName];
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    [def setObject:self.name.text forKey:@"name"];
    [def setObject:self.pwd.text forKey:@"pwd"];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(quxiao)];
    [self.view addGestureRecognizer:tap];
}
-(void)quxiao
{
    [self.name resignFirstResponder];
    [self.pwd resignFirstResponder];
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
