//
//  WeChatViewController.m
//  MsmChat
//
//  Created by 高晓东 on 16/8/8.
//  Copyright © 2016年 mengxx. All rights reserved.
//

#import "WeChatViewController.h"
#import "XDDownMenuView.h"
#import "FZHPopView.h"
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

static CGFloat viewOffset = 64;
@interface WeChatViewController () <UISearchBarDelegate, FZHPopViewDelegate>
//下拉小菜单
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) XDDownMenuView *menuView;

//SearchBar
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) FZHPopView *popView;
@property (nonatomic, strong) NSMutableArray *titleArray;

@end

@implementation WeChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self setupSearchBar];
    [self setupPopView];
    [self createDownMenu];
    self.titleArray = [NSMutableArray arrayWithObjects:@"friend",@"article",@"number", nil];
    

    
   
}

///设置SearchBar
- (void)setupSearchBar{
    
    self.searchBar = [[UISearchBar alloc]init];
    self.searchBar.frame = CGRectMake(0, viewOffset, SCREEN_WIDTH, 40);
    //设置圆角
//    self.searchBar.layer.cornerRadius = 3;
//    self.searchBar.layer.masksToBounds = YES;
    self.searchBar.delegate = self;
    //隐藏边框
//    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.searchBar.placeholder = @"搜索";
    CGFloat rgb = 0.3;
    self.searchBar.barTintColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:1];
    [self.view addSubview:self.searchBar];
//    self.tableView.tableHeaderView = self.searchBar;
    
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

- (IBAction)menuClick:(id)sender {
    
    if (self.menuView.hidden) {
        self.menuView.hidden = NO;
    }else
    {
        self.menuView.hidden = YES;
    }

}

#pragma mark SearchBar Delegate

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [UIView animateWithDuration:0.5 animations:^{
        
        //1.
        self.navigationController.navigationBar.transform = CGAffineTransformMakeTranslation(0, -viewOffset);
        self.searchBar.transform = CGAffineTransformMakeTranslation(0, -viewOffset);
        
        //2.
        self.searchBar.showsCancelButton = YES;
        [self setupCancelButton];
        
        [self.popView showThePopViewWithArray:self.titleArray];
        
    }];
}
- (void)setupPopView{
    self.popView = [[FZHPopView alloc]init];
    self.popView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    self.popView.fzhPopViewDelegate = self;
    [self.view addSubview:self.popView];
}

- (void)setupCancelButton{
    
    UIButton *cancelButton = [self.searchBar valueForKey:@"_cancelButton"];
    [cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelButtonClickEvent) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)cancelButtonClickEvent{
    
    [UIView animateWithDuration:0.5 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        //1.
        self.navigationController.navigationBar.transform = CGAffineTransformIdentity;
        self.searchBar.transform = CGAffineTransformIdentity;
        //2.
        self.searchBar.showsCancelButton = NO;
        [self.searchBar endEditing:YES];
        //3.
        [self.popView dismissThePopView];
    }];
    
    self.searchBar.placeholder = @"搜索";
    [self.searchBar setImage:[UIImage imageNamed:@"search"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
}

#pragma mark -FZHPopViewDelegate
-(void)getTheButtonTitleWithButton:(UIButton *)button{
    self.searchBar.placeholder = button.titleLabel.text;
    [self.searchBar setImage:[UIImage imageNamed:@"common"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    [self.popView dismissThePopView];
}

@end
