//
//  BaseViewController.h
//  PanGu
//
//  Created by 陈伟平 on 16/6/2.
//  Copyright © 2016年 陈伟平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+EmptyDataSet.h"

typedef NS_ENUM(NSUInteger, EMPTY_TYPE) {
    EMPTY_TYPE_NO_DATA,
    EMPTY_TYPE_NETWORK_ERROR,
    EMPTY_TYPE_NO_NETWORK,
    EMPTY_TYPE_UNDEFINED = 777,
};

@class RootViewController;
@interface BaseViewController : UIViewController <DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, assign) EMPTY_TYPE emptyType;//背景空图片类型

@property (nonatomic, assign) BOOL isSingleColumn;

- (void)shutdownNavigationBarShadow;

/**
 列表极端状态处理方法

 @param dataSource      需要清空的数据源
 @param emptyType       极端状态类型
 @param scrollView      当前所操作的scrollView
 @param isHeadRefresh   是否是下拉刷新
 @param error           错误信息

 */
- (void)reloadPublicEmptyData:(NSMutableArray *_Nonnull)dataSource
                    emptyType:(EMPTY_TYPE)emptyType
                    scrollView:(UIScrollView *_Nonnull)scrollView
                isHeadRefresh:(BOOL)isHeadRefresh error:(NSError *_Nullable) error;
/**
 点击刷新按钮

 @param scrollView      当前所操作的scrollView
 @param button          点击刷新按钮
 */
- (void)emptyDataSet:(UIScrollView *_Nonnull)scrollView
        didTapButton:(UIButton *_Nonnull)button;

/**显示提示信息为"加载中"的指示框*/
- (void)showLoadingView;
/**显示提示信息为"加载中"的指示框 有蒙版*/
- (void)showLoadingViewFillMask;

/**自定义提示信息提示框, 需要手动调用 - (void)hideLoadingView;*/
- (void)showCurrentLoadingView:(NSString *_Nonnull)text;

/**隐藏提示信息为"加载中"的指示框*/
- (void)hideLoadingView;

//添加左上角纯图片按钮
- (void)addLeftBtWithImage:(NSString *_Nonnull)imageName offSet:(CGFloat)x;
//添加右上角纯图片按钮
- (void)addRightBtWithImage:(NSString *_Nonnull)imageName offSet:(CGFloat)x;

//添加右上角两张图片
- (void)addRightBtTwoWithImage:(NSString *_Nonnull)firstImageName secondImageName:(NSString *_Nonnull)secondImageName;

//添加右上角纯文字按钮
- (void)addRightBtWithTitle:(NSString *_Nonnull)title color:(UIColor *_Nonnull)color font:(CGFloat)font offSet:(CGFloat)x;

/**************************点击事件方法**************************************/
//左边点击方法
- (void)leftAction;
//右边点击方法
- (void)rightAction;
//第一个的响应按钮方法
- (void)firstRightAction;
//第二个的响应按钮方法
- (void)secondRightAction;

/**************************监听方法**************************************/
//监听状态栏高度改变
-(void)StatusBarFrameWillChangeNotification:(NSNotification *_Nonnull)notification;

- (void)pushViewController:(nonnull BaseViewController *)viewController
                      from:(nonnull BaseViewController *)fromViewController
                     trade:(BOOL)isTrade;

- (void)reloadPublicHQEmptyData:(NSMutableArray *)dataSource emptyType:(EMPTY_TYPE)emptyType scrollView:(UIScrollView *)scrollView isHeadRefresh:(BOOL)isHeadRefresh;
@end
