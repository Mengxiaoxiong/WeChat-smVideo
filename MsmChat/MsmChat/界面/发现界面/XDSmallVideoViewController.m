//
//  XDSmallVideoViewController.m
//  MsmChat
//
//  Created by 高晓东 on 16/9/30.
//  Copyright © 2016年 mengxx. All rights reserved.
//

#import "XDSmallVideoViewController.h"
#import "SDShortVideoController.h"
#import "SDShortVideoProgressView.h"
#import "UIView+SDAutoLayout.h"

#define kHomeTableViewControllerCellId @"HomeTableViewController"
#define kHomeObserveKeyPath @"contentOffset"
#define kCraticalProgressHeight 80

const CGFloat kHomeTableViewAnimationDuration = 0.25;

@interface XDSmallVideoViewController ()
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, strong) SDShortVideoController *shortVideoController;

@end

@implementation XDSmallVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //隐藏self.View
    [self.view setHidden:YES];
    self.shortVideoController = [SDShortVideoController new];
    //添加子视图
    [self.view.superview insertSubview:self.shortVideoController.view atIndex:0];
    _top = self.navigationController.tabBarController.tabBar.top;
    self.navigationController.tabBarController.tabBar.top = 735;
    
    //显示拍照按钮
    [self.shortVideoController show];
    
}
//懒加载
-(SDShortVideoController *)shortVideoController {
    if (_shortVideoController == nil) {
        NSLog(@"为空,创建");
        SDShortVideoController  *shortVideoController = [SDShortVideoController new];
        return shortVideoController;
    }
    
    return _shortVideoController;
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //返回时还原
    [self.shortVideoController hidde];
    self.navigationController.tabBarController.tabBar.top = self.top;
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
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
