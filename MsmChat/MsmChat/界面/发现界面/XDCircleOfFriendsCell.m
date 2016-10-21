//
//  XDCircleOfFriends.m
//  MsmChat
//
//  Created by 高晓东 on 16/9/18.
//  Copyright © 2016年 mengxx. All rights reserved.
//

#import "XDCircleOfFriends.h"
#import "XDCircleOfFriendsCellModel.h"

const CGFloat contentLabelFontSize = 15;
CGFloat maxContentLabelHeight = 0; // 根据具体font而定

NSString *const kSDTimeLineCellOperationButtonClickedNotification = @"SDTimeLineCellOperationButtonClickedNotification";

@implementation XDCircleOfFriendsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
