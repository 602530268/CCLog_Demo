//
//  CClogManager.m
//  Test_1
//
//  Created by double on 2017/4/25.
//  Copyright © 2017年 double. All rights reserved.
//

#import "CClogManager.h"
#import "CCLogView.h"

@interface CClogManager ()

@property(nonatomic,assign) BOOL enable;
@property(nonatomic,strong) CCLogView *ccLogView;

@end

@implementation CClogManager

+ (CClogManager *)shareInstance {
    static CClogManager *manager = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [[CClogManager alloc] init];
    });
    return manager;
}

+ (void)ccLogEnable:(BOOL)logEnable {
    [CClogManager shareInstance].enable = logEnable;
}

+ (void)showCCLogView {
    if ([CClogManager shareInstance].enable) {
        [[CClogManager shareInstance].ccLogView cc_show];
    }else {
        [[CClogManager shareInstance].ccLogView cc_hidden];
    }
}

+ (BOOL)logEnable {
    return [CClogManager shareInstance].enable;
}

+ (void)writeLogWith:(NSString *)text {
    [[CClogManager shareInstance].ccLogView logWith:text];
}

#pragma mark - 懒加载
- (CCLogView *)ccLogView {
    if (!_ccLogView) {
        
        UIView *window = [UIApplication sharedApplication].keyWindow;
        
        BOOL has = NO;
        for (UIView *subView in window.subviews) {
            if ([subView isKindOfClass:[self class]]) {
                has = YES;
                break;
            }
        }
        
        if (!has) {
            _ccLogView = [[CCLogView alloc] initWithFrame:window.bounds];
            _ccLogView.hidden = YES;
            [window addSubview:_ccLogView];
        }
    }
    return _ccLogView;
}

@end
