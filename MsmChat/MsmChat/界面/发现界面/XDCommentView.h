//
//  XDCommentView.h
//  MsmChat
//
//  Created by 高晓东 on 16/9/24.
//  Copyright © 2016年 mengxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GloabalDefines.h"
@interface XDCommentView : UIView
- (void)setupWithLikeItemsArray:(NSArray *)likeItemsArray commentItemsArray:(NSArray *)commentItemsArray;///设置项目数组
@property (nonatomic, copy) void (^didClickCommentLabelBlock)(NSString *commentId, CGRect rectInWindow);///并点击评论标签块
@end
