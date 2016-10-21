//
//  XDCircleOfFriendsModel.m
//  MsmChat
//
//  Created by 高晓东 on 16/9/18.
//  Copyright © 2016年 mengxx. All rights reserved.
//

#import "XDCircleOfFriendsCellModel.h"
#import <UIKit/UIKit.h>
///内容标签字体大小
extern const CGFloat contentLabelFontSize;
///最大Label高度
extern CGFloat maxContentLabelHeight;

@implementation XDCircleOfFriendsCellModel
{
    CGFloat _lastContentWidth;    ///最后内容宽度
}

@synthesize msgContent = _msgContent;

- (void)setMsgContent:(NSString *)msgContent {
    _msgContent = msgContent;
}

-(NSString *)msgContent {
    
    CGFloat contentW = [UIScreen mainScreen].bounds.size.width - 70;
    if (contentW != _lastContentWidth) {
        _lastContentWidth = contentW;
        CGRect textRect = [_msgContent boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:contentLabelFontSize]} context:nil];
        if (textRect.size.height > maxContentLabelHeight) {
            _shouldShowMoreButton = YES;
        } else {
            _shouldShowMoreButton = NO;
        }
    }
    
    return _msgContent;
}

- (void)setIsOpening:(BOOL)isOpening
{
    if (!_shouldShowMoreButton) {
        _isOpening = NO;
    } else {
        _isOpening = isOpening;
    }
}

@end


@implementation XDCircleOfFriendsCellLikeItemModel


@end

@implementation XDCircleOfFriendsCellCommentItemModel


@end