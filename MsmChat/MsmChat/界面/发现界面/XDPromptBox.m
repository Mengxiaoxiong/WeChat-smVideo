//
//  XDPromptBox.m
//  XDImagePickerDemo
//
//  Created by 高晓东 on 16/10/3.
//  Copyright © 2016年 GXD. All rights reserved.
//

#import "XDPromptBox.h"
#import "XDTimeLineTableViewController.h"
#define KNavitionBarHeight 64
@interface XDPromptBox()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
/**
 *  是否透明
 */
@property (nonatomic, assign) BOOL isTranslucent;
@end

@implementation XDPromptBox

-(id)initWithlist:(NSArray *)list height:(CGFloat)height{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, -64, kScreenWidth, kScreenHeight);
        self.backgroundColor = ColorWithRGBA(0, 0, 0, .7);
        view = [[UITableView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 49 * [list count] + 7) style:UITableViewStylePlain];
        view.dataSource = self;
        view.delegate = self;
        view.separatorStyle = NO;
        listdata = list;
        view.scrollEnabled = NO;
        [self addSubview:view];
    }
    return self;
}

-(void)showInView:(UIViewController *)Sview{
    if (Sview == nil) {
        
    }else{
        self.isTranslucent = !Sview.navigationController.navigationBar.isTranslucent && Sview.navigationController.navigationBar;
        [Sview.view addSubview:self];
    }
    [self animeData];
}

-(void)animeData{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
    [self addGestureRecognizer:tap];
    tap.delegate = self;
    CGFloat orginY = kScreenHeight - view.frame.size.height;
    if (self.isTranslucent) {
        orginY -= KNavitionBarHeight;
    }
    [UIView animateWithDuration:.25 animations:^{
        self.backgroundColor = ColorWithRGBA(0, 0, 0, .7);
        [UIView animateWithDuration:.25 animations:^{
            [view setFrame:CGRectMake(view.frame.origin.x, orginY, view.frame.size.width, view.frame.size.height)];
        } completion:^(BOOL finished) {
            
        }];
    } completion:^(BOOL finished) {
        
    }];
    
}
//点击消失
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if([touch.view isKindOfClass:[self class]]){
        
        return YES;
    }
    
    return NO;
}

-(void)tappedCancel{
    [UIView animateWithDuration:.25 animations:^{
        /**
         *  此处添加通知使键盘能够滑动
         **/
        //创建一个消息对象
        NSNotification * notice = [NSNotification notificationWithName:@"123" object:nil userInfo:@{@"1":@"123"}];
        //发送消息
        [[NSNotificationCenter defaultCenter]postNotification:notice];
        
        
        [view setFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 0)];
        [view setAlpha:0];
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [listdata count]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    if(indexPath.row == listdata.count-1){
        UITableViewCell*  cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"gap"];
        cell.contentView.backgroundColor = ColorWithRGBA(214, 214, 221,1);
        return cell;
    }else {
        
        XDPromptBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if(cell==nil){
            
            cell = [[XDPromptBoxCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        if (indexPath.row == listdata.count) {
            [cell setData:[listdata objectAtIndex:listdata.count-1]];
        }else {
            [cell setData:[listdata objectAtIndex:indexPath.row]];
        }
        
        return cell;
    }
    // Configure the cell...
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self tappedCancel];
    if(_delegate!=nil && [_delegate respondsToSelector:@selector(didSelectIndex:)]){
        [_delegate didSelectIndex:indexPath.row];
        
        return;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == listdata.count-1){
        return 7;
    }else{
        return 49;
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
