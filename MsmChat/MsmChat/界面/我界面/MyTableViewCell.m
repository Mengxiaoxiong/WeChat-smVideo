//
//  MyTableViewCell.m
//  MsmChat
//
//  Created by 高晓东 on 16/9/17.
//  Copyright © 2016年 mengxx. All rights reserved.
//

#import "MyTableViewCell.h"
#import "GloabalDefines.h"
@implementation MyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
     
    // Configure the view for the selected state
}
//重写cell image内容
- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.bounds =CGRectMake(10,10,60,60);
    self.imageView.frame =CGRectMake(10,10,60,60);
    self.imageView.contentMode =UIViewContentModeScaleAspectFit;
    CGRect tmpFrame = self.textLabel.frame;
    tmpFrame.origin = CGPointMake(80, -10);
    self.textLabel.frame = tmpFrame;
    tmpFrame = self.detailTextLabel.frame;
    tmpFrame.origin.x = 46;
    self.detailTextLabel.frame = tmpFrame;
    //第一行尾缀二维码图
    UIImageView *QRcode = [[UIImageView alloc]init];
    QRcode.image = [UIImage imageNamed:@"ScanQRCode"];
    QRcode.frame = CGRectMake(SCREEN_WIDTH - 60, 25, 30, 30);
    [self addSubview:QRcode];  
    
}
@end
