//
//  XDDownMenuView.m
//  MsmChat
//
//  Created by 高晓东 on 16/8/15.
//  Copyright © 2016年 mengxx. All rights reserved.
//

#define JHMargin 10
#import "XDDownMenuView.h"
#import "XDDownMenuView.h"

@interface XDDownMenuView ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic, strong)NSArray *dataArray;

@end

@implementation XDDownMenuView

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]init];
        
        [self addSubview:_tableView];
        _tableView.backgroundColor = [UIColor blackColor];
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
    cell.backgroundColor = [UIColor blackColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}

- (void)drawRect:(CGRect)rect
{
    // 背景色
    [[UIColor blackColor] set];
    
    // 获取视图
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    // 开始绘制
    CGContextBeginPath(contextRef);
    
    CGContextMoveToPoint(contextRef, self.bounds.size.width - 40, self.tableView.frame.origin.y);
    CGContextAddLineToPoint(contextRef, self.bounds.size.width - 20, self.tableView.frame.origin.y);
    CGContextAddLineToPoint(contextRef, self.bounds.size.width - 20 * 1.5, self.tableView.frame.origin.y - JHMargin);
    // 结束绘制
    CGContextClosePath(contextRef);
    // 填充色
    [[UIColor blackColor] setFill];
    // 边框颜色
    [[UIColor blackColor] setStroke];
    // 绘制路径
    CGContextDrawPath(contextRef, kCGPathFillStroke);
    
}



@end
