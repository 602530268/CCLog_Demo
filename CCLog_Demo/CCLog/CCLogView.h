//
//  CCLogView.h
//  Test_1
//
//  Created by double on 2017/4/25.
//  Copyright © 2017年 double. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCLogView : UIView

@property(nonatomic,strong) UITextView *logTextView;
@property(nonatomic,strong) UIButton *cleanBtn;

- (void)cc_show;
- (void)cc_hidden;

- (void)logWith:(NSString *)text;

@end
