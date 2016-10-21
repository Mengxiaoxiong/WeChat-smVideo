//
//  MyViewController.m
//  MsmChat
//
//  Created by 高晓东 on 16/8/8.
//  Copyright © 2016年 mengxx. All rights reserved.
//

#import "MyViewController.h"
#import "XDSettingItem.h"
#import "XDGroupItem.h"
#import "MyTableViewCell.h"
@interface MyViewController ()
@property (strong, nonatomic) NSMutableArray * groups;/**< 组数组 描述TableView有多少组 */
@end

@implementation MyViewController

//让groups进行懒加载
-(NSMutableArray *)groups {
    if (!_groups) {
        _groups = [[NSMutableArray alloc]init];
    }
    return _groups;
}
-(instancetype)init {
    /***设置tableView的样式***/
    return [self initWithStyle:(UITableViewStyleGrouped)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view from its nib.
    [self setGroups1];

}

-(void)setGroups1 {
    // 创建组模型
    XDGroupItem *group = [[XDGroupItem alloc]init];
    // 创建行模型
    XDSettingItem *item = [XDSettingItem itemWithtitle:@"凄清肆水丶" :@"9.jpg"];
    // 保存行模型数组
    group.items = @[item];
    // 把组模型保存到groups数组
    [self.groups addObject:group];
    [self setGroups2];
}
-(void)setGroups2 {
    // 创建组模型
    XDGroupItem *group = [[XDGroupItem alloc]init];
    // 创建行模型
    XDSettingItem *item = [XDSettingItem itemWithtitle:@"相册" :@"ff_IconShowAlbum"];
    XDSettingItem *item1 = [XDSettingItem itemWithtitle:@"收藏" :@"MoreMyFavorites"];
    XDSettingItem *item2 = [XDSettingItem itemWithtitle:@"钱包" :@"MoreMyBankCard"];
    XDSettingItem *item3 = [XDSettingItem itemWithtitle:@"卡包" :@"MyCardPackageIcon"];
    // 保存行模型数组
    group.items = @[item,item1,item2,item3];
    // 把组模型保存到groups数组
    [self.groups addObject:group];
    [self setGroups3];

}
-(void)setGroups3 {
    // 创建组模型
    XDGroupItem *group = [[XDGroupItem alloc]init];
    // 创建行模型
    XDSettingItem *item = [XDSettingItem itemWithtitle:@"表情" :@"MoreExpressionShops"];
    // 保存行模型数组
    group.items = @[item];
    // 把组模型保存到groups数组
    [self.groups addObject:group];
    [self setGroups4];
}
-(void)setGroups4 {
    // 创建组模型
    XDGroupItem *group = [[XDGroupItem alloc]init];
    // 创建行模型
    XDSettingItem *item = [XDSettingItem itemWithtitle:@"设置" :@"MoreSetting"];
    // 保存行模型数组
    group.items = @[item];
    // 把组模型保存到groups数组
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
 * 返回每行高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 80;
    }else {
        return 44;
    }
}
/**
 *  返回每一行Cell的代理方法
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 1 初始化Cell
    // 1.1 设置Cell的重用标识
    static NSString *ID = @"cell";
    static NSString *ID1 = @"cell1";

    // 1.2 去缓存池中取Cell
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:ID];
    // 1.3 若取不到便创建一个带重用标识的Cell
    if (cell == nil) {
        if (indexPath.section == 0) {
            cell  = [[MyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        } else {
            cell1 = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID1];
        }
    }
    //如果是第一行,输出自定制cell
    if (indexPath.section == 0) {
        // 设置Cell右边的小箭头
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        // 2 设置数据
        // 2.1 取出组模型
        XDGroupItem *group = self.groups[indexPath.section];
        // 2.2 根据组模型取出行（Cell）模型
        XDSettingItem *item = group.items[indexPath.row];
        // 2.3 根据行模型的数据赋值
        //设置圆角
        cell.textLabel.text = item.title;
        cell.imageView.layer.cornerRadius = 8;
        cell.imageView.layer.masksToBounds = YES;
        
        cell.imageView.image = [UIImage imageNamed:item.image];
        return cell;
    }else {
        // 设置Cell右边的小箭头
        cell1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        // 2 设置数据
        // 2.1 取出组模型
        XDGroupItem *group = self.groups[indexPath.section];
        // 2.2 根据组模型取出行（Cell）模型
        XDSettingItem *item = group.items[indexPath.row];
        // 2.3 根据行模型的数据赋值
        //设置圆角
        cell1.textLabel.text = item.title;
        cell1.imageView.layer.cornerRadius = 8;
        cell1.imageView.layer.masksToBounds = YES;
        
        cell1.imageView.image = [UIImage imageNamed:item.image];
        return cell1;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                NSLog(@"个人信息");
            }
            break;
        case 1:
            if (indexPath.row == 0) {
                NSLog(@"相册");
            }else if (indexPath.row == 1) {
                NSLog(@"收藏");
            }else if (indexPath.row == 2) {
                NSLog(@"钱包");
            }else if (indexPath.row == 3) {
                NSLog(@"卡包");
            }
            break;
        case 2:
            NSLog(@"表情");
            break;
        case 3:
            NSLog(@"设置");
            break;
        default:
            break;
    }
    
}

@end
