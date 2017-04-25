//
//  UIWindow+CCLog.m
//  Test_1
//
//  Created by double on 2017/4/25.
//  Copyright © 2017年 double. All rights reserved.
//

#import "UIWindow+CCLog.h"
#import "CClogManager.h"

@implementation UIWindow (CCLog)

#pragma mark--------检测手机摇晃------
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    if (event.type == UIEventSubtypeMotionShake) {
        NSLog(@"摇晃手机...");
        [CClogManager showCCLogView];
    }
}

@end
