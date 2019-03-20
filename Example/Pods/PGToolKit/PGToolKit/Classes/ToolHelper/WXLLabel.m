//
//  WXLLabel.m
//  PanGu
//
//  Created by 张琦 on 2017/10/20.
//  Copyright © 2017年 Security Pacific Corporation. All rights reserved.
//

#import "WXLLabel.h"

@implementation WXLLabel

- (instancetype)init {
    if (self = [super init]) {
        _textInsets = UIEdgeInsetsZero;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _textInsets = UIEdgeInsetsZero;
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, _textInsets)];
}

@end
