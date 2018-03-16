//
//  ShiJianXiangQingViewController.m
//  WZKPonyBiJi
//
//  Created by 王正魁 on 15-5-4.
//  Copyright (c) 2015年 psylife. All rights reserved.
//

#import "ShiJianXiangQingViewController.h"
#import "ImagesCollectionViewCell.h"
#import "Most.h"
@interface ShiJianXiangQingViewController ()
{
    MPMoviePlayerController* mp;
}
@property (strong, nonatomic) IBOutlet UICollectionView *collectionForImage;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollerViewBig;
@property (strong, nonatomic) IBOutlet UILabel *neirongLabel;
@property(strong,nonatomic)NSArray* arrayForImage;
@property(strong,nonatomic)NSArray* arrayForPlay;

@end

@implementation ShiJianXiangQingViewController
-(void)viewWillDisappear:(BOOL)animated
{

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
 
    [self shuju];
    [self.collectionForImage registerNib:[UINib nibWithNibName:@"ImagesCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"collectionCellID"];
    
    CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    layout.minimumColumnSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    self.collectionForImage.collectionViewLayout = layout;
    [self buju];
    
    CGRect rect = self.scrollerViewBig.frame;
    rect.size.height = self.view.frame.size.height-self.scrollerViewBig.frame.origin.y;
    self.scrollerViewBig.frame = rect;
}
-(NSString* )pathForImageFiler
{
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    NSString* path1 = [NSString stringWithFormat:@"%@%@/%@/%@",[def objectForKey:@"name"],[def objectForKey:@"pwd"],self.stringLeiBie,self.stringTitle];
   return  [[Most getPathForDocument] stringByAppendingPathComponent:path1];
}
-(void)shuju
{
    NSArray* array = [LeiBieDao getTimeTableName:nil withName:self.stringTitle];
    LeiBie* let = [array lastObject];
    self.neirongLabel.text = [NSString stringWithFormat:@"%@\n时间：%@",self.stringNeiRong,let.timess];
    self.titleLabel.text = self.stringTitle;

    NSString* path = [self pathForImageFiler];
    NSArray* arrayAllForShiJianWenJianJia = [Most loadFileForArrayWithPath:path];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@", @".png"];
    NSPredicate *predicatep = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@", @".MOV"];
    self.arrayForPlay = [arrayAllForShiJianWenJianJia filteredArrayUsingPredicate:predicatep];
    self.arrayForImage = [arrayAllForShiJianWenJianJia filteredArrayUsingPredicate:predicate];
}
-(void)buju
{
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:16]};
    CGRect rects = [self.neirongLabel.text boundingRectWithSize:CGSizeMake(278, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    
    CGRect rectL = self.neirongLabel.frame;
    rectL.size.height = rects.size.height;
    self.neirongLabel.frame = rectL;
    
    
   
    [self performSelectorInBackground:@selector(collectionViewHead) withObject:nil];
  
}
-(void)collectionViewHead
{
    CGFloat heihtScorller = 0;
    for (int i = 0; i < (self.arrayForImage.count); i++) {
        NSString* path = [self pathForImageFiler];
        NSString* imageName = [NSString stringWithFormat:@"%@/%@",path,[self.arrayForImage objectAtIndex:i]];
        UIImage* iamge = [UIImage imageWithContentsOfFile:imageName];
        CGFloat with = 258/2;
       CGFloat bili = with/iamge.size.width;
        CGFloat height = iamge.size.height*bili;
        heihtScorller = heihtScorller + height;
    }
    [self performSelectorOnMainThread:@selector(shuaXinShuJu:) withObject:[NSNumber numberWithFloat:heihtScorller] waitUntilDone:YES];
}
-(void)shuaXinShuJu:(NSNumber *)num
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    
    if (self.arrayForPlay.count >0) {
        NSString* path = [self pathForImageFiler];
        NSString* imageName = [NSString stringWithFormat:@"%@/%@",path,[self.arrayForPlay firstObject]];
        
        NSURL *fileUrl =[NSURL fileURLWithPath:imageName];
        mp = [[MPMoviePlayerController alloc] initWithContentURL:fileUrl];
//        CGFloat fl = self.collectionForImage.frame.origin.y+ [num integerValue]+10;
        //        CGFloat fl = self.collectionForImage.frame.origin.y+[num integerValue]+10;
        mp.controlStyle = MPMovieControlStyleDefault;
        mp.view.frame = CGRectMake(56-30,self.neirongLabel.frame.origin.y+self.neirongLabel.frame.size.height+5 , 208+60, 162+30);
        [mp play];
        [self.scrollerViewBig addSubview:mp.view];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(movieFinishedCallback:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:nil];
        //        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bofang)];
        //        [mp.view addGestureRecognizer:tap];
        
    }
    
    
    CGRect rectI =  self.collectionForImage.frame;
    rectI.origin.y = mp.view.frame.origin.y+mp.view.frame.size.height+5;
    rectI.size.height = [num floatValue];
    self.collectionForImage.frame  = rectI;
    
    CGFloat fl = self.collectionForImage.frame.origin.y+self.collectionForImage.frame.size.height;
    if (fl<=0) {
        fl = 0;
    }
    

    self.scrollerViewBig.contentSize = CGSizeMake(0, fl);
    
    
    
    
    [self.collectionForImage reloadData];
}
-(void)bofang
{
    
}
-(void)movieFinishedCallback:(NSNotification *)aNotification
{
   
    [mp play];
   
    
}
#pragma mark UICollectionView的设置
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.arrayForImage.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString* string  = @"collectionCellID";
    ImagesCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:string forIndexPath:indexPath];
    NSString* path = [self pathForImageFiler];
    cell.imageAdd.contentMode = UIViewContentModeScaleToFill;
    NSString* imageName = [NSString stringWithFormat:@"%@/%@",path,[self.arrayForImage objectAtIndex:indexPath.item]];
    NSURL* url = [NSURL fileURLWithPath:imageName];
    [cell.imageAdd sd_setImageWithURL:url];
    
    return cell;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* path = [self pathForImageFiler];
    NSString* imageName = [NSString stringWithFormat:@"%@/%@",path,[self.arrayForImage objectAtIndex:indexPath.item]];
    UIImage* iamge = [UIImage imageWithContentsOfFile:imageName];
    
    
    CGFloat with = 258/2;
    CGFloat bili = with/iamge.size.width;
    CGFloat height = iamge.size.height*bili;
    
    return CGSizeMake(with, height);
}
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(5, 5, 5, 5);
//}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [OtherModel playSound:soundID];
    BigImageViewController* big = [[BigImageViewController alloc] init];
    ImagesCollectionViewCell* cell = (ImagesCollectionViewCell* )[collectionView cellForItemAtIndexPath:indexPath];
    big.image_ = cell.imageAdd.image;
    big.transitioningDelegate = self;
    [self presentViewController:big animated:YES completion:^{
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backButton:(id)sender {
    [OtherModel playSound:soundID];
    [mp stop];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
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
