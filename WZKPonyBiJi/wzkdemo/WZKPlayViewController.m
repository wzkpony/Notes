//
//  WZKPlayViewController.m
//  LTSYActionDemo
//
//  Created by 王正魁 on 14-7-23.
//  Copyright (c) 2014年 Psylife. All rights reserved.
//

#import "WZKPlayViewController.h"

@interface WZKPlayViewController ()
@property (strong, nonatomic) IBOutlet UIButton *buttonDone;

@end

@implementation WZKPlayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (self.type != YES) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(movieFinishedCallback:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:nil];

    }
    
    [self.buttonDone addTarget:self action:@selector(movieFinishedCallback:) forControlEvents:UIControlEventTouchUpInside];
    [self playMovies:self.stringWithUrl];

}
-(void)playMovies:(NSString*)obj
{
//    NSArray* array = [obj componentsSeparatedByString:@"."];
//    NSString* string = [[NSBundle mainBundle]pathForResource:[array objectAtIndex:0] ofType:[array objectAtIndex:1]];
     NSURL *fileUrl =[NSURL fileURLWithPath:obj];
    mp = [[MPMoviePlayerController alloc] initWithContentURL:fileUrl];
    
    mp.view.frame = CGRectMake(0, 0, withs, heights);
    [mp play];
    
    [self.view insertSubview:mp.view belowSubview:self.buttonDone];
}
-(void)movieFinishedCallback:(NSNotification *)aNotification
{
    if (self.type == YES) {
        if (self.block!=nil) {
            self.block();
        }
    }
    [mp stop];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
