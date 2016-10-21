//
//  XDImagePicker.m
//  XDImagePickerDemo
//
//  Created by 高晓东 on 16/10/3.
//  Copyright © 2016年 GXD. All rights reserved.
//

#import "XDImagePicker.h"
#import "XDPromptBox.h"
#import "XDSmallVideoViewController.h"

@interface XDImagePicker ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,XDPromptBoxDelegate>

@end

@implementation XDImagePicker
{
    UIViewController *_screenController;
    NSArray *_pickList;
    PickCallback _callback;
    BOOL _animated;
}


+(instancetype)shareInstance {
    static XDImagePicker *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[XDImagePicker alloc] init];
        //设置数据
        instance->_pickList = [instance avaiablePickerSheetModel];
    });
    return instance;
}
/**
 * 设置数据
 **/
-(NSArray *)avaiablePickerSheetModel{
    XDPromptBoxModel *Model_0 = [[XDPromptBoxModel alloc]init];
    Model_0.title = @"小视频";
    XDPromptBoxModel *Model_1 = [[XDPromptBoxModel alloc]init];
    Model_1.title = @"拍照";
    XDPromptBoxModel *Model_2 = [[XDPromptBoxModel alloc]init];
    Model_2.title = @"从手机相册选择";
    XDPromptBoxModel *Model_3 = [[XDPromptBoxModel alloc]init];
    Model_3.title = @"取消";
    
    return   @[Model_0,Model_1,Model_2,Model_3];
}

/**
 * 展示照片选择器
 **/
-(void)showWithController:(UIViewController *)controller finished:(PickCallback)callback animated:(BOOL)animated {
    //控制器不能为零
    NSAssert(controller != nil, @"Controller can not be nil !");
    _screenController = controller;
    _callback = callback;
    _animated = animated;
    XDPromptBox *sheet = [[XDPromptBox alloc]initWithlist:_pickList height:330];
    sheet.delegate = self;
    [sheet showInView:controller];
}

-(void)didSelectIndex:(NSInteger)index{
    if (index == 0) {
        //自定制录制小视频
//        XDSmallVideoViewController *small = [XDSmallVideoViewController new];
//        [_screenController presentViewController:small animated:_animated completion:^{}];
//        XDSmallVideoViewController *sma = [XDSmallVideoViewController new];
//        [_screenController presentViewController:sma animated:YES completion:nil];
        NSLog(@"小视频");
    }else if (index == 1){
        //拍照[self openCamera:self];
       [self openCamera];
        NSLog(@"拍照");
    }else if (index == 2){
        [self openPhotoLibrary];
        NSLog(@"手机相册选取");
    }
}

#pragma mark - 打开相机
-(void)openCamera{
    
    NSUInteger sourceType = 0;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    
    sourceType = UIImagePickerControllerSourceTypeCamera; //照相机
    
    UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
    //    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    //        pickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
    //        //pickerImage.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    //        pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
    //
    //    }
    pickerImage.sourceType = sourceType;
    pickerImage.delegate = self;
    pickerImage.allowsEditing = YES;
    [_screenController presentViewController:pickerImage animated:_animated completion:^{}];
}
#pragma mark 打开相册
- (void)openPhotoLibrary{
    NSUInteger sourceType = 0;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
        
    }
    
    UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        //pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerImage.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
        
    }
    pickerImage.sourceType = sourceType;
    pickerImage.delegate = self;
    pickerImage.allowsEditing = YES;
    [_screenController presentViewController:pickerImage animated:_animated completion:^{}];
}
#pragma mark - Imagepicker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:_animated completion:^{
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        if (_callback) {
            _callback(image);
        }
    }];
}

@end
