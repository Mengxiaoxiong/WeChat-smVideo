//
//  XDSettingItem.m
//  MsmChat
//
//  Created by 高晓东 on 16/8/22.
//  Copyright © 2016年 mengxx. All rights reserved.
//

#import "XDSettingItem.h"

@implementation XDSettingItem

//+ (instancetype)itemWithtitle:(NSString *)title{
//
//    XDSettingItem *item = [[XDSettingItem alloc]init];
//    
//    item.title = title;
//    
//    return item;
//}

+(instancetype)itemWithtitle:(NSString *)title :(NSString *)image {
    XDSettingItem *item = [[XDSettingItem alloc]init];
    item.title = title;
    item.image = image;
    
    return item;
}

@end
