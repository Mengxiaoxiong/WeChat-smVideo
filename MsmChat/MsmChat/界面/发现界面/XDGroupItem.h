//
//  XDGroupItem.h
//  MsmChat
//
//  Created by 高晓东 on 16/8/22.
//  Copyright © 2016年 mengxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XDGroupItem : NSObject

/** 头部标题 */
@property (strong, nonatomic) NSString * headerTitle;

/** 尾部标题 */
@property (strong, nonatomic) NSString * footerTitle;

/** 组中的行数组 */
@property (strong, nonatomic) NSArray * items;

/** */

@end
