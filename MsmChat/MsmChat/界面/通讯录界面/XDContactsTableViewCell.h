//
//  XDContactsTableViewCell.h
//  MsmChat
//
//  Created by 高晓东 on 16/8/21.
//  Copyright © 2016年 mengxx. All rights reserved.
//

#import <UIKit/UIKit.h>
//自定制cell
@class XDContactModel;

@interface XDContactsTableViewCell : UITableViewCell

@property (nonatomic, strong) XDContactModel *model;

///cell高度
+ (CGFloat)fixedHeight;

@end
