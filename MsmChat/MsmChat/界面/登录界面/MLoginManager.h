//
//  MLoginManager.h
//  MsmChat
//
//  Created by 孟晓雄 on 16/7/18.
//  Copyright © 2016年 mengxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MLoginManager : NSObject
SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(MLoginManager);
-(void)judgeCondition:(UIWindow *)window;
@end
