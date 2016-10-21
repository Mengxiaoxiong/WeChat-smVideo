//
//  XDContactsSearchResultController.m
//  MsmChat
//
//  Created by 高晓东 on 16/8/21.
//  Copyright © 2016年 mengxx. All rights reserved.
//

#import "XDContactsSearchResultController.h"

@interface XDContactsSearchResultController ()
@property (nonatomic,strong) NSMutableString *aStr;
@end
typedef void (^myBlock)();

@implementation XDContactsSearchResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

-(UIButton *)aBtn{
    if (!_aBtn) {
        _aBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_aBtn setFrame:CGRectMake(0, 0, 50, 50)];
        [_aBtn setBackgroundColor:[UIColor redColor]];
        [self.view addSubview:self.aBtn];
    }
    return _aBtn;
}


@end
