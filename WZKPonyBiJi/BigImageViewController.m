//
//  BigImageViewController.m
//  WZKPonyBiJi
//
//  Created by 王正魁 on 15-3-31.
//  Copyright (c) 2015年 psylife. All rights reserved.
//

#import "BigImageViewController.h"
#define withs [UIScreen mainScreen].bounds.size.width
#define heights [UIScreen mainScreen].bounds.size.height
@interface BigImageViewController ()
@property (strong, nonatomic) IBOutlet UIScrollView *scrollerViewS;

@end

@implementation BigImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.images.image = self.image_;
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
    [self.images addGestureRecognizer:tap];
    
    _scrollerViewS.userInteractionEnabled = YES;
    _scrollerViewS.multipleTouchEnabled=YES;
    _scrollerViewS.showsHorizontalScrollIndicator=NO;
    _scrollerViewS.showsVerticalScrollIndicator=NO;
    _scrollerViewS.delegate = self;                                   //实现Scrollview的代理，需要在.h 文件中添加
    _scrollerViewS.zoomScale=1.0;
    _scrollerViewS.minimumZoomScale=1;
    _scrollerViewS.maximumZoomScale=2.0;
    
//    CGFloat with = withs;
//    CGFloat bili = with/self.images.image.size.width;
//    CGFloat height = self.images.image.size.height*bili;
//    CGRect rect = self.images.bounds;
//    rect.size = CGSizeMake(with, height);
//    self.images.bounds = rect;
//    self.images.center = self.view.center;
}
-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    
//    if (scrollView ==self.scrollerViewS) {
//        CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
//        (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
//        CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
//        (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
//        UIImageView *imgView=(UIImageView *)[self.scrollerViewS viewWithTag:(10)];
//        imgView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
//                                     scrollView.contentSize.height * 0.5 + offsetY);
//    }
    
    
    
    
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    
    return self.images;
}
-(void)back
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
//
- (BOOL)prefersStatusBarHidden//for iOS7.0
{
    return YES;
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
