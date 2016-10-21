//
//  XDCommentsActionMenuView.h
//  MsmChat
//
//  Created by 高晓东 on 16/9/24.
//  Copyright © 2016年 mengxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XDCommentsActionMenuView : UIView
@property (nonatomic, assign, getter = isShowing) BOOL show;

@property (nonatomic, copy) void (^likeButtonClickedOperation)();///按钮单击操作
@property (nonatomic, copy) void (^commentButtonClickedOperation)();///注释按钮单击操作
@end
