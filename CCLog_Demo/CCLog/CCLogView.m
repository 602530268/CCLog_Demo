//
//  CCLogView.m
//  Test_1
//
//  Created by double on 2017/4/25.
//  Copyright © 2017年 double. All rights reserved.
//

#import "CCLogView.h"

const NSInteger maxTextLength = 10000;  //超过10000字符就去掉前面的

@implementation CCLogView

#pragma mark - 接口方法实现
- (void)cc_show {
    
    if (!_cleanBtn) {
        [self createUI];
    }
    
    self.hidden = !self.hidden;
    if (!self.hidden) {
        //将view放到最高层
        UIView *window = [UIApplication sharedApplication].keyWindow;
        [window bringSubviewToFront:self];
        
        //滚到最底部
        CGPoint off = _logTextView.contentOffset;
        if (off.y > _logTextView.contentSize.height) {
            off.y = _logTextView.contentSize.height - _logTextView.bounds.size.height + _logTextView.contentInset.bottom;
            [_logTextView setContentOffset:off animated:NO];
        }
        
    }
}

- (void)cc_hidden {
    self.hidden = YES;
}

- (void)logWith:(NSString *)text {
    NSMutableString *log = [[NSMutableString alloc] initWithString:self.logTextView.text];
    [log appendString:@"\n"];
    [log appendString:text];
    
    self.logTextView.text = (log.length > maxTextLength) ? [log substringFromIndex:log.length - maxTextLength] : log;
    self.cleanBtn.hidden = NO;
}

#pragma mark - 交互事件
- (void)cleanBtnEvent {
    self.logTextView.text = @"";
}

#pragma mark - UI
- (void)createUI {
    
    /*子控件*/
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 64)];
    navView.backgroundColor = [UIColor whiteColor];
    [self addSubview:navView];
    
    self.cleanBtn.hidden = NO;
    self.logTextView.hidden = NO;
}

#pragma mark - 懒加载
- (UIButton *)cleanBtn {
    if (!_cleanBtn) {
        _cleanBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width - 70, 32-20, 50, 40)];
        [_cleanBtn setTitle:@"clean" forState:UIControlStateNormal];
        [_cleanBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_cleanBtn addTarget:self action:@selector(cleanBtnEvent) forControlEvents:UIControlEventTouchUpInside];
        _cleanBtn.layer.borderColor = [UIColor blueColor].CGColor;
        _cleanBtn.layer.borderWidth = 1.0f;
        _cleanBtn.layer.cornerRadius = 5.0;
        _cleanBtn.layer.masksToBounds = YES;
        [self addSubview:_cleanBtn];
    }
    return _cleanBtn;
}

- (UITextView *)logTextView {
    if (!_logTextView) {
        _logTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 64, self.bounds.size.width, self.bounds.size.height - 64)];
        _logTextView.backgroundColor = [UIColor lightGrayColor];
        _logTextView.textColor = [UIColor redColor];
        _logTextView.text = @"log日志:";
        _logTextView.editable = NO;
        [self addSubview:_logTextView];
    }
    return _logTextView;
}



@end
