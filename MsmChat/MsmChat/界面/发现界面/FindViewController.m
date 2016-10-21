
//
//  FindViewController.m
//  MsmChat
//
//  Created by 高晓东 on 16/8/8.
//  Copyright © 2016年 mengxx. All rights reserved.
//

#import "FindViewController.h"
#import "XDSettingItem.h"
#import "XDGroupItem.h"
#import "XDTimeLineTableViewController.h"
#import "GloabalDefines.h"
@interface FindViewController ()

@property (strong, nonatomic) NSMutableArray * groups;/**< 组数组 描述TableView有多少组 */

@end

@implementation FindViewController

/** groups 数据懒加载*/
- (NSMutableArray *)groups
{
    if (!_groups) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}
- (instancetype)init{
    // 设置tableView的分组样式为Group样式
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setGroup1];
}

- (void)setGroup1{
    // 创建组模型
    XDGroupItem *group = [[XDGroupItem alloc]init];
    // 创建行模型
    XDSettingItem *item = [XDSettingItem itemWithtitle:@"朋友圈" :@"ff_IconShowAlbum"];
    // 保存行模型数组
    group.items = @[item];
    
    // 把组模型保存到groups数组
    [self.groups addObject:group];
    [self setGroup2];
}

- (void)setGroup2{
    
    XDGroupItem *group = [[XDGroupItem alloc]init];

    XDSettingItem *item = [XDSettingItem itemWithtitle:@"扫一扫" :@"ff_IconQRCode"];
    XDSettingItem *item1 = [XDSettingItem itemWithtitle:@"摇一摇" :@"ff_IconShake"];

    group.items = @[item,item1];
    
    [self.groups addObject:group];
    [self setGroup3];
}

- (void)setGroup3{
    
    XDGroupItem *group = [[XDGroupItem alloc]init];
    XDSettingItem *item = [XDSettingItem itemWithtitle:@"附近的人" :@"ff_IconLocationService"];

    group.items = @[item];
    
    [self.groups addObject:group];
    [self setGroup4];
}

-(void)setGroup4{
   
    XDGroupItem *group = [[XDGroupItem alloc]init];
    
    XDSettingItem *item = [XDSettingItem itemWithtitle:@"购物" :@"CreditCard_ShoppingBag"];
    XDSettingItem *item1 = [XDSettingItem itemWithtitle:@"游戏" :@"MoreGame"];
    
    group.items = @[item,item1];
    [self.groups addObject:group];
}


#pragma mark - tableView delegate and datasoure

/**
 *  返回有多少组的代理方法
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.groups.count;
}
/**
 *  返回每组有多少行的代理方法
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    XDGroupItem *group = self.groups[section];
    return group.items.count;
}

/**
 *  返回每一行Cell的代理方法
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 1 初始化Cell
    // 1.1 设置Cell的重用标识
    static NSString *ID = @"cell";
    // 1.2 去缓存池中取Cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 1.3 若取不到便创建一个带重用标识的Cell
    if (cell == nil) {
        cell  = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    // 设置Cell右边的小箭头
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // 2 设置数据
    // 2.1 取出组模型
    XDGroupItem *group = self.groups[indexPath.section];
    // 2.2 根据组模型取出行（Cell）模型
    XDSettingItem *item = group.items[indexPath.row];
    
    // 2.3 根据行模型的数据赋值
    cell.textLabel.text = item.title;
    
    cell.imageView.image = [UIImage imageNamed:item.image];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
            //跳转朋友圈
            if (indexPath.row == 0) {
                XDTimeLineTableViewController *timeline = [[XDTimeLineTableViewController alloc]init];
                timeline.view.backgroundColor = [UIColor whiteColor];
                timeline.title = @"朋友圈";
                //隐藏标签控制器
                if (self) {
                    self.tabBarController.tabBar.hidden = YES;
                } else {
                    self.tabBarController.tabBar.hidden = NO;
                }
                [self.navigationController pushViewController:timeline animated:YES];
            }
            break;
        case 1:
            if (indexPath.row == 0) {
                NSLog(@"扫一扫");
            }else {
                NSLog(@"摇一摇");
            }
            break;
        
        case 2:
            NSLog(@"附近的人");
            break;
        case 3:
            if (indexPath.row == 0) {
                NSLog(@"购物");
            }else {
                NSLog(@"游戏");
            }
            break;
            
        default:
            break;
    }
    
}


@end
