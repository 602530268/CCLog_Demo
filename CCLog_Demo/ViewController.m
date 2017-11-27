//
//  ViewController.m
//  CCLog_Demo
//
//  Created by double on 2017/4/25.
//  Copyright © 2017年 double. All rights reserved.
//

#import "ViewController.h"
#import "CClogManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //哪里开启和关闭都可以
    [CClogManager ccLogEnable:YES];
    
    /*
     在模拟器中运行时，可以通过
     [Hardware]-[Shake Gesture]
     来模拟摇晃动作
     */
    
    [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        CCLog(@"................");
        NSInteger num = arc4random() % 101;
        CCLog(@"%ld",num);
        
        CCLogOnly(@"only...");
    }];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    CCLog(@"%@",[self arcStr]); //CClog里面内容都会保存,如果enable是NO的话就只有打印功能
}

//产生随机字符串
- (NSString *)arcStr
{
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef s = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    return (__bridge_transfer NSString *)s;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
