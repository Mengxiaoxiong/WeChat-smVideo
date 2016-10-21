//
//  XDPromptBox.h
//  XDImagePickerDemo
//
//  Created by 高晓东 on 16/10/3.
//  Copyright © 2016年 GXD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XDPromptBoxCell.h"
/***提示框代理***/
@protocol XDPromptBoxDelegate <NSObject>

@optional
-(void)didSelectIndex:(NSInteger)index;

@end
/***提示框View***/
@interface XDPromptBox : UIView {
    UITableView *view;
    NSArray *listdata;
}
//初始化方式列表
-(id)initWithlist:(NSArray *)list height:(CGFloat)height;
//显示在浏览
- (void)showInView:(UIViewController *)Sview;
//调用
- (void)tappedCancel;

@property(nonatomic,assign) id <XDPromptBoxDelegate> delegate;

@end
