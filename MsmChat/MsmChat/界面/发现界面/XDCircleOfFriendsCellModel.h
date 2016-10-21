//
//  XDCircleOfFriendsModel.h
//  MsmChat
//
//  Created by 高晓东 on 16/9/18.
//  Copyright © 2016年 mengxx. All rights reserved.
//

#import <Foundation/Foundation.h>
/***朋友圈Model***/

@class XDCircleOfFriendsCellLikeItemModel, XDCircleOfFriendsCellCommentItemModel;

/***朋友圈cell Model***/
@interface XDCircleOfFriendsCellModel : NSObject
///图片名称
@property (nonatomic, copy) NSString *iconName;
///名字
@property (nonatomic, copy) NSString *name;
///内容
@property (nonatomic, copy) NSString *msgContent;
///图片名称
@property (nonatomic, strong) NSArray *picNamesArray;
///喜欢
@property (nonatomic, assign, getter = isLiked) BOOL liked;

@property (nonatomic, strong) NSArray<XDCircleOfFriendsCellLikeItemModel *> *likeItemsArray;
@property (nonatomic, strong) NSArray<XDCircleOfFriendsCellCommentItemModel *> *commentItemsArray;
///开盘
@property (nonatomic, assign) BOOL isOpening;
///应该显示But
@property (nonatomic, assign, readonly) BOOL shouldShowMoreButton;

@end

/***朋友圈cell喜欢项目***/
@interface XDCircleOfFriendsCellLikeItemModel : NSObject
///用户名
@property (nonatomic, copy) NSString *userName;
///用户ID
@property (nonatomic, copy) NSString *userId;
///属性内容
@property (nonatomic, copy) NSAttributedString *attributedContent;

@end

/***朋友圈cell注释项目***/
@interface XDCircleOfFriendsCellCommentItemModel : NSObject
///注释字符串
@property (nonatomic, copy) NSString *commentString;
///第一个用户名
@property (nonatomic, copy) NSString *firstUserName;
///第一个用户ID
@property (nonatomic, copy) NSString *firstUserId;

///第二个用户名
@property (nonatomic, copy) NSString *secondUserName;
///第二个用户ID
@property (nonatomic, copy) NSString *secondUserId;
///属性内容
@property (nonatomic, copy) NSAttributedString *attributedContent;

@end