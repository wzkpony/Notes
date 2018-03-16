//
//  SheZhiViewController.m
//  WZKPonyBiJi
//
//  Created by 王正魁 on 15/7/17.
//  Copyright (c) 2015年 psylife. All rights reserved.
//

#import "SheZhiViewController.h"

@interface SheZhiViewController ()
{
    NSArray* arraySoundName;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISwitch *switch_;

@end

@implementation SheZhiViewController
- (IBAction)back:(id)sender {
    [OtherModel playSound:soundID];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)kaiguan:(id)sender {
    UISwitch* witch = (UISwitch *)sender;
    if (witch.on == YES) {
        [[NSUserDefaults standardUserDefaults] setValue:@"yes" forKey:@"tapSound"];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setValue:@"no" forKey:@"tapSound"];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
//    [def objectForKey:@"soundName"];
    arraySoundName = @[@"提示音1",@"提示音2",@"提示音3",@"提示音4",@"提示音5",@"提示音6",@"提示音7",@"提示音8",@"提示音9",@"提示音10",@"提示音11",@"提示音12"];
    
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    if ([[def objectForKey:@"tapSound"] isEqualToString:@"yes"]) {
        self.switch_.on = YES;
    }
//    CGRect rect = self.tableView.frame;
//    rect.size.height = self.view.frame.size.height-self.tableView.frame.origin.y;
//    self.tableView.frame = rect;
    NSLog(@"%@",NSStringFromCGRect(self.view.frame));
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arraySoundName.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellid = @"cellid";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.textLabel.text = [arraySoundName objectAtIndex:indexPath.row];
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"sound"] isEqualToString:[arraySoundName objectAtIndex:indexPath.row]])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSUserDefaults standardUserDefaults]setValue:[arraySoundName objectAtIndex:indexPath.row] forKey:@"sound"];
    
    [[NSUserDefaults standardUserDefaults]setValue:[NSNumber numberWithInteger:indexPath.row+1] forKey:@"soundName"];
    [tableView reloadData];
    
    NSString* soundName = [NSString stringWithFormat:@"%d",indexPath.row+1];
    OtherModel* other = [OtherModel sharedController];
    [other playMusicForProductWithName:soundName WithType:@"caf"];
    [other playBigin];
    
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
