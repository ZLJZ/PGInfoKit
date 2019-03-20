//
//  LoopScrollView.h
//  PanGu
//
//  Created by 张琦 on 2017/7/10.
//  Copyright © 2017年 Security Pacific Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>


@class LoopScrollView;

@protocol LoopScrollViewDataSource <NSObject>

@required
- (NSArray *) loopScroll:(LoopScrollView *)carouselView;
- (UIView *) loopScroll:(LoopScrollView *)carouselView carouselFrame:(CGRect)frame data:(NSArray *)data viewForItemAtIndex:(NSInteger)index;

@end

@class LoopScrollView;

@protocol LoopScrollViewDelegate <NSObject>

/*
 *  此方法为 用于轮播的点击方法
 */
@optional
- (void)loopScroll:(LoopScrollView *)zzcarouselView didSelectItemAtIndex:(NSInteger)index;


@end
@interface LoopScrollView : UIView

/*
 *   设置自动滚动时间
 */
@property (nonatomic, assign) CGFloat carouseScrollTimeInterval;
@property (strong, nonatomic) UIScrollView *coreView;
@property (nonatomic, weak) id <LoopScrollViewDataSource> dataSource;
@property (nonatomic, weak) id <LoopScrollViewDelegate> delegate;

/*
 *   重载数据
 */
-(void)reloadData;

@end
