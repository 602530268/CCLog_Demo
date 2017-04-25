//
//  CClogManager.h
//  Test_1
//
//  Created by double on 2017/4/25.
//  Copyright © 2017年 double. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CCLog(...) printf("%s %d行: %s\n",__FUNCTION__,__LINE__,[[NSString stringWithFormat:__VA_ARGS__] UTF8String]);   \
[CClogManager logEnable] == YES ? [CClogManager writeLogWith:[NSString stringWithFormat:__VA_ARGS__]] : 0;


@interface CClogManager : NSObject

//+ (CClogManager *)shareInstance;

//log开关
+ (void)ccLogEnable:(BOOL)logEnable;

//展示logView
+ (void)showCCLogView;

//获取开关状态
+ (BOOL)logEnable;

//写入log
+ (void)writeLogWith:(NSString *)text;

@end
