//
//  HeadSrcollView.m
//  粒子效果
//
//  Created by 祁继宇 on 16/6/2.
//  Copyright © 2016年 Qi Jiyu. All rights reserved.
//

#import "HeadSrcollView.h"
//#import "POP.h"

#define LabelWidth 60
#define LabelHeight 35
#define LineHeight 2

@implementation HeadSrcollView 

- (id)initHeadSrcollView:(NSArray * _Nonnull)dataArray {
    if (self = [super init]) {
        
        self.showsHorizontalScrollIndicator = NO;
        self.backgroundColor = [UIColor whiteColor];
        self.bounces = NO;
        // 定制 SrcoolView
        [self customHeadSrcoolView:dataArray];
        // 添加底部线 (这方法有毒)
//        [self createBorderLine];
    }
    return self;
}

- (void)createBorderLine {
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, self.height-KSINGLELINE_WIDTH)];
    [path addLineToPoint:CGPointMake(self.width, self.height-KSINGLELINE_WIDTH)];
    layer.path = path.CGPath;
    layer.strokeColor = [UIColor blackColor].CGColor;
    layer.fillColor = [UIColor blackColor].CGColor;
    [self.layer addSublayer:layer];

//    [self addSubview:borderLine];
//    borderLine.backgroundColor = [UIColor blackColor];
}

- (void)customHeadSrcoolView:(NSArray * _Nonnull)dataArray {
    
    // 创建视图
    NSInteger arrCount = dataArray.count;
    self.contentSize = CGSizeMake(LabelWidth * arrCount, 0);
    
    CGSize size = [dataArray[0] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    __block UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, LabelHeight - LineHeight, size.width, LineHeight)];
    lineView.backgroundColor = [UIColor colorWithRed:1.000 green:0.400 blue:0.400 alpha:1.000];
    lineView.tag = 995520;
    [self addSubview:lineView];
    
    for (NSInteger index = 0; index < arrCount; index++) {
        @autoreleasepool {
            __block UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(LabelWidth * index, 0, LabelWidth, LabelHeight - LineHeight);
            [self addSubview:btn];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
            if (index == 0) {
                lineView.center = CGPointMake(btn.center.x, lineView.center.y);
                CGAffineTransform transform = CGAffineTransformScale(btn.titleLabel.transform, 1.1, 1.1);
                btn.transform = transform;
                btn.selected = YES;
            }
            [btn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
            [btn setTitleColor:[UIColor colorWithRed:1.000 green:0.400 blue:0.400 alpha:1.000] forState:(UIControlStateSelected)];
            [btn setTitle:dataArray[index] forState:(UIControlStateNormal)];

            [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:(UIControlEventTouchUpInside)];
        }
    }
}

- (void)buttonClicked:(UIButton *)btn {
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *tempBtn = (UIButton *)view;
            tempBtn.selected = NO;
            CGAffineTransform transform = CGAffineTransformScale(btn.titleLabel.transform, 1, 1);
            tempBtn.transform = transform;
        }
    }
    btn.selected = YES;
    
    CGAffineTransform transform = CGAffineTransformScale(btn.titleLabel.transform, 1.1, 1.1);
    // 使ScrollView 滚动
    [UIView animateWithDuration:0.3 animations:^{
        if (btn.center.x > (kScreenWidth/2) && btn.center.x < (self.contentSize.width - (kScreenWidth/2))) {
            self.contentOffset = CGPointMake(btn.center.x - (kScreenWidth / 2), 0);
        }else if (btn.center.x <= (kScreenWidth/2)) {
            self.contentOffset = CGPointMake(0, 0);
        }else {
            self.contentOffset = CGPointMake(self.contentSize.width - kScreenWidth, 0);
        }
        // label.text 字体放大
        btn.transform = transform;
    }];
    
    // lineView 的动画
    UIView *lineView = (UIView *)[self viewWithTag:995520];
    CASpringAnimation *layerScaleAnimation = [CASpringAnimation animationWithKeyPath:@"position.x"];
    layerScaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(btn.center.x, lineView.frame.origin.y)];
//    layerScaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(btn.center.x, lineView.mj_y)];
    layerScaleAnimation.stiffness = 6;
    [lineView.layer addAnimation:layerScaleAnimation forKey:@"layerScaleAnimation"];
//    [lineView.layer pop_addAnimation:layerScaleAnimation forKey:@"layerScaleAnimation"];
}

@end
