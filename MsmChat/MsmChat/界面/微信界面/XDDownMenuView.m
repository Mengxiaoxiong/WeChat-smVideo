//
//  XDDownMenuView.m
//  MsmChat
//
//  Created by 高晓东 on 16/8/15.
//  Copyright © 2016年 mengxx. All rights reserved.
//

#import "XDDownMenuView.h"
#import "GloabalDefines.h"
@interface XDDownMenuView ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *dataArray;
@property (strong, nonatomic) NSArray * groups;
@end

@implementation XDDownMenuView

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]init];
        
        [self addSubview:_tableView];
        _tableView.backgroundColor = [UIColor redColor];
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        self.tableView.frame = CGRectMake(0, JHMargin, self.bounds.size.width, self.bounds.size.height - JHMargin);
        self.tableView.layer.cornerRadius = 3;
        self.tableView.clipsToBounds = YES;
        //关闭上下滑动
        self.tableView.scrollEnabled = NO;
        self.dataArray = @[@"发起群聊",
                           @"添加朋友",
                           @"扫一扫",
                           @"收付款"];
        self.groups = @[@"contacts_add_newmessage",@"contacts_add_friend",@"contacts_add_scan",@"barbuttonicon_more"];
      
    }
    return self;
}
#pragma mark tableView相关
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"idx";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor Global_drawRect];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.imageView.image = [UIImage imageNamed:self.groups[indexPath.row]];
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                NSLog(@"发起群聊");
                break;
            case 1:
                NSLog(@"添加朋友");
                break;
            case 2:
                NSLog(@"扫一扫");
                break;
            case 3:
                NSLog(@"收付款");
            
                break;
            default:
                break;
        }
        
    }
}
- (void)drawRect:(CGRect)rect
{
    // 背景色
    [[UIColor Global_drawRect] set];
    // 获取视图
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    // 开始绘制
    CGContextBeginPath(contextRef);
    CGContextMoveToPoint(contextRef, self.bounds.size.width - 40, self.tableView.frame.origin.y);
    CGContextAddLineToPoint(contextRef, self.bounds.size.width - 20, self.tableView.frame.origin.y);
    CGContextAddLineToPoint(contextRef, self.bounds.size.width - 20 * 1.5, self.tableView.frame.origin.y - 10);
    // 结束绘制
    CGContextClosePath(contextRef);
    // 填充色
    [[UIColor Global_drawRect] setFill];
    // 边框颜色
    [[UIColor Global_drawRect] setStroke];
    // 绘制路径
    CGContextDrawPath(contextRef, kCGPathFillStroke);
    
}



@end
