//
//  MultiTabView.h
//  PanGu
//
//  Created by 吴肖利 on 2018/10/19.
//  Copyright © 2018 Security Pacific Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MultiTabType) {
    MultiTabMallType,//理财商城
    MultiTabAssetPos,//持仓
    MultiTabPacificInstitute,//太平洋研究
};
@class MultiTabTitlesView;
@interface MultiTabView : UIView

//标签滚动视图
@property (nonatomic, strong) MultiTabTitlesView *titlesView;
//列表滚动视图
@property (nonatomic, strong) UIScrollView *scrollView;


/**
 自定义多页签view(包含scrollView)

 @param frame frame
 @param titleArr 标题数据
 @param defaultIdx 默认选择下标
 @return 自定义多页签view(包含scrollView)
 */
- (instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr defaultIdx:(NSInteger)defaultIdx multiTabType:(MultiTabType)multiTabType clickBlock:(void(^)(NSInteger index))clickBlock;

- (instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr childArr:(NSArray *)childArr defaultIdx:(NSInteger)defaultIdx multiTabType:(MultiTabType)multiTabType clickBlock:(void(^)(NSInteger index))clickBlock;

@end

@interface MultiTabTitlesView : UIScrollView<UIScrollViewDelegate>

/**
 自定义多页签view(self宽，且均分)
 
 @param frame frame
 @param titleArr 标题数据
 @param defaultIdx 默认选择下标
 @param selectedTabBlock 当前选中的tab的回调
 @return 自定义多标签view
 */
- (instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr defaultIdx:(NSInteger)defaultIdx multiTabType:(MultiTabType)multiTabType selectedTabBlock:(void(^)(NSInteger selectedIdx,UIButton *selectedButton))selectedTabBlock;


/**
 title的点击事件

 @param sender 被点击的对象
 */
- (void)clickEvent:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
