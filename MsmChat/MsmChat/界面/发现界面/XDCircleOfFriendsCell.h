//
//  XDCircleOfFriends.h
//  MsmChat
//
//  Created by 高晓东 on 16/9/18.
//  Copyright © 2016年 mengxx. All rights reserved.
//

#import <UIKit/UIKit.h>
/***朋友圈自定制Cell***/
//自定制cell代理
@protocol XDCircleOfFriendsDelegate <NSObject>
///朋友圈按钮
- (void)didClickLikeButtonInCell:(UITableViewCell *)cell;
///评论按钮
- (void)didClickcCommentButtonInCell:(UITableViewCell *)cell;

@end

@class XDCircleOfFriendsCellModel;

@interface XDCircleOfFriendsCell : UITableViewCell

@property (nonatomic, weak) id<XDCircleOfFriendsDelegate> delegate;

@property (nonatomic, strong) XDCircleOfFriendsCellModel *model;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, copy) void (^moreButtonClickedBlock)(NSIndexPath *indexPath);

@property (nonatomic, copy) void (^didClickCommentLabelBlock)(NSString *commentId, CGRect rectInWindow, NSIndexPath *indexPath);

@end
