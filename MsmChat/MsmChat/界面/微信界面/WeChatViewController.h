//
//  WeChatViewController.h
//  MsmChat
//
//  Created by 高晓东 on 16/8/8.
//  Copyright © 2016年 mengxx. All rights reserved.
//

#import <UIKit/UIKit.h>
///微信界面
@interface WeChatViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;




@end
