//
//  WeChatViewController.m
//  MsmChat
//
//  Created by 高晓东 on 16/8/8.
//  Copyright © 2016年 mengxx. All rights reserved.
//

#import "WeChatViewController.h"
#import "XDDownMenuView.h"
#import "XDContactsSearchResultController.h"
#import "GloabalDefines.h"
#import "XDContactsTableViewCell.h"

@interface WeChatViewController () <UISearchBarDelegate>
//下拉小菜单
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) XDDownMenuView *menuView;

//SearchBar
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) UISearchController *searchController;

@end

@implementation WeChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self setupSearchBar];
    [self createDownMenu];
}

///设置搜索框
- (void)setupSearchBar{
    //点击searchBar 的搜索背景
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:[XDContactsSearchResultController new]];
    self.searchController.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.95];
    
    //设置searchBar
    UISearchBar *bar = self.searchController.searchBar;
    bar.barStyle = UIBarStyleDefault;
    bar.translucent = YES;
    bar.placeholder = @"搜索";
    bar.barTintColor = Global_mainBackgroundColor;
    bar.tintColor = Global_tintColor;
    UIImageView *view = [[[bar.subviews objectAtIndex:0] subviews] firstObject];
    view.layer.borderColor = Global_mainBackgroundColor.CGColor;
    view.layer.borderWidth = 1;
    
    bar.layer.borderColor = [UIColor redColor].CGColor;
    bar.showsBookmarkButton = YES;
    [bar setImage:[UIImage imageNamed:@"VoiceSearchStartBtn"] forSearchBarIcon:UISearchBarIconBookmark state:UIControlStateNormal];
    bar.delegate = self;
    CGRect rect = bar.frame;
    rect.size.height = 44;
    bar.frame = rect;
    
    //将搜索框添加到tableView头视图
    self.tableView.tableHeaderView = bar;
    self.tableView.rowHeight = [XDContactsTableViewCell fixedHeight];
    self.tableView.sectionIndexColor = [UIColor lightGrayColor];
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];

}

///小菜单判断
-(void)changeColor{
    //判断 弹出收回小菜单
    if (self.menuView.hidden) {
        self.menuView.hidden = NO;
        self.coverView.hidden = NO;
    }else
    {
        self.menuView.hidden = YES;
        self.coverView.hidden = YES;
    }

}
///小菜单
- (void)createDownMenu
{
    //添加右上加号按钮
    UIBarButtonItem *button = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(changeColor)];
    self.navigationItem.rightBarButtonItem = button;
    
    //屏幕的宽度
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    //计算ableView的frame
    CGFloat ViewW = 145;
    CGFloat ViewH = 200;
    CGFloat ViewX = screenWidth - ViewW - 5;
    CGFloat ViewY = 70;
    
    XDDownMenuView *menuView = [[XDDownMenuView alloc]initWithFrame:CGRectMake(ViewX, ViewY, ViewW, ViewH)];
    [self.view addSubview:menuView];
    self.menuView = menuView;
    
    menuView.backgroundColor = [UIColor clearColor];
    self.menuView.hidden = YES;
    
}

#pragma mark - tableView delegate and datasoure
//行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}
//高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *st = @"st";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:st];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:st];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.menuView.hidden = YES;
}
///判断小菜单打开还是关闭
- (IBAction)menuClick:(id)sender {
    
    if (self.menuView.hidden) {
        self.menuView.hidden = NO;
    }else
    {
        self.menuView.hidden = YES;
    }

}
#pragma mark - UISearchBarDelegate
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar
{
    
}
@end
