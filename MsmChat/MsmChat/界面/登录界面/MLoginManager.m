//
//  MLoginManager.m
//  MsmChat
//
//  Created by 孟晓雄 on 16/7/18.
//  Copyright © 2016年 mengxx. All rights reserved.
//

#import "MLoginManager.h"
#import "MLoginViewController.h"
#import "AppDelegate.h"
#import "XDAppFrameTabBarController.h"
#import "IMConstants.h"
@implementation MLoginManager

SYNTHESIZE_SINGLETON_FOR_CLASS(MLoginManager);

#pragma mark - 初始化配置
-(void)judgeCondition:(UIWindow *)window{
    [self loginJudgement];
}

- (void)loginJudgement{
    if (Client_Version_Type == 2) {//测试版
        [self gotoWeChatMainView];
    }else if(Client_Version_Type == 0)//正式版
        
    {
        //判断是否首次进入新版本
        if([[NSUserDefaults standardUserDefaults] boolForKey:@"isNewLaunch"]){
            [self showLeadPage];//加载-引导页
        }else{
            [self swichLogin];//登录
        }
    }
}
//登录选择器
- (void)swichLogin{
   /**此处写跳转登录的代码**/
    
}

#pragma mark - 跳转微信
/** 跳转仿微信的首页 **/
-(void)gotoWeChatMainView{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    delegate.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    delegate.window.rootViewController = [XDAppFrameTabBarController new];
    [delegate.window makeKeyAndVisible];
    [self setupNavBar];
}
/** 设置导航颜色 **/
-(void)setupNavBar {
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    UINavigationBar *bar = [UINavigationBar appearance];
    CGFloat rgb = 0.1;
    bar.barTintColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:1];
    bar.tintColor = [UIColor whiteColor];
    bar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
}
#pragma mark -
/** 加载-引导页 **/
-(void)showLeadPage{
    
}
@end
