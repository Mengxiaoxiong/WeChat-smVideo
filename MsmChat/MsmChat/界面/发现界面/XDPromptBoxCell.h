//
//  XDPromptBoxCell.h
//  XDImagePickerDemo
//
//  Created by 高晓东 on 16/10/3.
//  Copyright © 2016年 GXD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XDPromptBoxModel.h"
/**
 * 自定制cell
 **/
//自定义颜色rgba
#define ColorWithRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/1.0] //<<< 用10进制表示颜色，例如（255,255,255）黑色

//屏幕尺寸 kScreenWidth:屏幕宽度    kScreenHeight：屏幕高度
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface XDPromptBoxCell : UITableViewCell
{
    UIImageView *leftView;
    UILabel *InfoLabel;
    XDPromptBoxModel *cellData;
    UIView *backgroundView;
}

-(void)setData:(XDPromptBoxModel *)dicData;
@end
