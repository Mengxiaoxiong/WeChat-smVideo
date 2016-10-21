//
//  XDSettingItem.h
//  MsmChat
//
//  Created by 高晓东 on 16/8/22.
//  Copyright © 2016年 mengxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XDSettingItem : NSObject

@property (strong, nonatomic) NSString * title;/**< 标题 */
@property (strong, nonatomic) NSString * image;/**< 标题头像*/
+ (instancetype)itemWithtitle:(NSString *)title :(NSString *)image;/**< 设置标题值 类方法 */

@end
