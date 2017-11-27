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
{
    BOOL autoScroll;  //textView自动滚动
}

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
        
        autoScroll = YES; //默认自动滚动
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
    self.stopScrollBtn.hidden = NO;
    
    _logTextView.layoutManager.allowsNonContiguousLayout = autoScroll;
    if (autoScroll) {
        [_logTextView scrollRangeToVisible:NSMakeRange(_logTextView.text.length, 1)];
    }
}

#pragma mark - 交互事件
- (void)cleanBtnEvent {
    self.logTextView.text = @"log日志:";
}

- (void)stopScrollBtnEvent {
    autoScroll = !autoScroll;
}

#pragma mark - UI
- (void)createUI {
    
    /*子控件*/
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 64)];
    navView.backgroundColor = [UIColor whiteColor];
    [self addSubview:navView];
}

#pragma mark - 懒加载
- (UIButton *)cleanBtn {
    if (!_cleanBtn) {
        _cleanBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width - 70, 44-20, 50, 38)];
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

- (UIButton *)stopScrollBtn {
    if (!_stopScrollBtn) {
        _stopScrollBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width - 130, 44-20, 50, 38)];
        [_stopScrollBtn setTitle:@"scroll" forState:UIControlStateNormal];
        [_stopScrollBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_stopScrollBtn addTarget:self action:@selector(stopScrollBtnEvent) forControlEvents:UIControlEventTouchUpInside];
        _stopScrollBtn.layer.borderColor = [UIColor blueColor].CGColor;
        _stopScrollBtn.layer.borderWidth = 1.0f;
        _stopScrollBtn.layer.cornerRadius = 5.0;
        _stopScrollBtn.layer.masksToBounds = YES;
        [self addSubview:_stopScrollBtn];
    }
    return _stopScrollBtn;
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
