//
//  XDImagePicker.h
//  XDImagePickerDemo
//
//  Created by 高晓东 on 16/10/3.
//  Copyright © 2016年 GXD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 *  选择完图片回调
 */
typedef void (^PickCallback)(UIImage * image);

/***图片选择器***/
@interface XDImagePicker : NSObject


/**
 *   单列  共享实例
 **/
+(instancetype)shareInstance;
/**
 *   展示照片选择器
 *
 *  @param controller 当前控制器
 *  @param callback   回调方法
 *  @param animated   动画
 */
-(void)showWithController:(UIViewController *)controller finished:(PickCallback)callback animated: (BOOL)animated;
@end
