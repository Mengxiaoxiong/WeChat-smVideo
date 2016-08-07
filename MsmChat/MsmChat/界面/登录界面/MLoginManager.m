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
@implementation MLoginManager
-(void)judgeCondition:(UIWindow *)window{
    [self loginJudgement];
}
- (void) loginJudgement
{
    NSLog(@"test");
    //判断是否首次进入新版本
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"isNewLaunch"]){
//        [self showLeadPage];//加载-引导页
    }else{
        [self swichLogin];//登录
    }
}
//登录选择器
- (void)swichLogin{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    MLoginViewController *loginView = [[MLoginViewController alloc] init];

    delegate.window.rootViewController = loginView;
}
@end
