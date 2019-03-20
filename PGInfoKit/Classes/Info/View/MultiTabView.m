//
//  MultiTabView.m
//  PanGu
//
//  Created by 吴肖利 on 2018/10/19.
//  Copyright © 2018 Security Pacific Corporation. All rights reserved.
//

#import "MultiTabView.h"
#import "PGInfo.h"

@interface MultiTabView ()<UIScrollViewDelegate>
//分割view
@property (nonatomic, strong) UIView *separatorView;
//数据源
@property (nonatomic, strong) NSArray *titleArr;
//默认选中标签下标
@property (nonatomic, assign) NSInteger defaultIdx;
//页面类型
@property (nonatomic, assign) MultiTabType multiTabType;
//标签点击事件回调
@property (nonatomic, copy) void(^clickBlock)(NSInteger index);

@property (nonatomic, strong) NSArray *childArr;


@end
@implementation MultiTabView

- (instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr defaultIdx:(NSInteger)defaultIdx multiTabType:(MultiTabType)multiTabType clickBlock:(void(^)(NSInteger index))clickBlock {
    if (self = [super initWithFrame:frame]) {
        self.multiTabType = multiTabType;
        self.sakura.backgroundColor(CommonListContentContentBackColor);
        self.clickBlock = clickBlock;
        self.titleArr = [titleArr copy];
        self.defaultIdx = defaultIdx;
        [self addSubview:self.titlesView];
//        [self addSubview:self.separatorView];
        [self scrollViewDidEndScrollingAnimation:self.scrollView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr childArr:(NSArray *)childArr defaultIdx:(NSInteger)defaultIdx multiTabType:(MultiTabType)multiTabType clickBlock:(void(^)(NSInteger index))clickBlock {
    if (self = [super initWithFrame:frame]) {
        self.childArr = childArr;
        self.multiTabType = multiTabType;
        self.sakura.backgroundColor(CommonListContentContentBackColor);
        self.clickBlock = clickBlock;
        self.titleArr = [titleArr copy];
        self.defaultIdx = defaultIdx;
        [self addSubview:self.titlesView];
        //        [self addSubview:self.separatorView];
        [self scrollViewDidEndScrollingAnimation:self.scrollView];
    }
    return self;
}

#pragma mark  UIScrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    
    UIViewController *vc;
    if (self.multiTabType == MultiTabPacificInstitute) {
        NSInteger index = scrollView.contentOffset.x / scrollView.width;
        vc = self.childArr[index];
    } else {
        
//        if (self.multiTabType == MultiTabAssetPos) {
//            if (self.clickBlock) {
//                self.clickBlock(index);
//            }
//        }
//
//        vc = [ToolHelper getCurrentVC].childViewControllers[index];
    }
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;
    vc.view.height = scrollView.height;
    [scrollView addSubview:vc.view];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self.titlesView clickEvent:[self viewWithTag:10000 + index]];
    if (self.clickBlock) {
        self.clickBlock(index);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.multiTabType == MultiTabAssetPos) {
//        [[ToolHelper getCurrentVC].childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            if ([obj isKindOfClass:[AssetPosListViewController class]]) {
//                if (idx == 0 || idx == 3) {
//                    [((AssetPosListViewController *)obj).topView.choiceView hidden];
//                }
//            }
//        }];

    }
}

#pragma mark  lazy

- (MultiTabTitlesView *)titlesView {
    if (!_titlesView) {
        uWeakSelf
        _titlesView = [[MultiTabTitlesView alloc]initWithFrame:CGRectMake(self.left, 0, self.width, 40) titleArr:self.titleArr defaultIdx:self.defaultIdx multiTabType:self.multiTabType selectedTabBlock:^(NSInteger selectedIdx, UIButton * _Nonnull selectedButton) {
            
            CGPoint offset = weakSelf.scrollView.contentOffset;
            offset.x = selectedIdx * weakSelf.scrollView.width;
            [weakSelf.scrollView setContentOffset:offset animated:YES];
            if (weakSelf.clickBlock) {
                weakSelf.clickBlock(selectedIdx);
            }
        }];
    }
    return _titlesView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        CGFloat top = (self.multiTabType == MultiTabAssetPos || self.multiTabType == MultiTabPacificInstitute) ? self.titlesView.bottom : self.separatorView.bottom;
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(self.left, top, self.width, self.height - top)];
        _scrollView.delegate = self;
        _scrollView.sakura.backgroundColor(CommonGlobalBackColor);
        _scrollView.contentSize = CGSizeMake(_scrollView.width * self.childArr.count, 0);
        _scrollView.contentOffset = CGPointMake(self.defaultIdx * _scrollView.width, 0);
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self insertSubview:_scrollView atIndex:0];
    }
    return _scrollView;
}

- (UIView *)separatorView {
    if (!_separatorView) {
        _separatorView = [UIView adddView:CGRectMake(self.left, self.titlesView.bottom, self.width, 5) backColor:CommonGlobalBackColor superView:self];
    }
    return _separatorView;
}

//- (void)setHeight:(CGFloat)height {
//    self.scrollView.height = height - 40;
//}

@end

@interface MultiTabTitlesView ()
//标题数据源
@property (nonatomic, strong) NSArray *titleArr;
//是否均分屏幕宽度
@property (nonatomic, assign) BOOL isAverage;
//默认选中索引的下标
@property (nonatomic, assign) NSInteger defaultIdx;
//类型
@property (nonatomic, assign) MultiTabType multiTabType;
//下划线
@property (nonatomic, strong) UIView *indictorView;
//当前选中tab的回调
@property (nonatomic, copy) void(^block)(NSInteger selectedIdx,UIButton *selectedButton);
//记录上一次点击的button
@property (nonatomic, strong) UIButton *lastSelectedButton;

@end
@implementation MultiTabTitlesView

- (instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr defaultIdx:(NSInteger)defaultIdx multiTabType:(MultiTabType)multiTabType selectedTabBlock:(void(^)(NSInteger selectedIdx,UIButton *selectedButton))selectedTabBlock {
    if (self = [super initWithFrame:frame]) {
        self.sakura.backgroundColor(CommonListContentContentBackColor);
        self.block = selectedTabBlock;
        self.titleArr = titleArr;
        self.defaultIdx = defaultIdx;
        self.multiTabType = multiTabType;
        self.delegate = self;
        self.bounces = NO;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = 0;
        [self addViews];
    }
    return self;
}

- (void)addViews {
    CGFloat buttonW = self.width/self.titleArr.count;
    self.contentSize = CGSizeMake(self.width, self.height);
    
    [self.titleArr enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:obj forState:UIControlStateNormal];
        [button setTitleColor:TXSakuraColor(CommonPageLabelUnTextColor1) forState:UIControlStateNormal];
        if (self.multiTabType == MultiTabMallType ||
            self.multiTabType == MultiTabAssetPos ||
            self.multiTabType == MultiTabPacificInstitute) {
            [button setTitleColor:TXSakuraColor(CommonPageLabelTextColor1) forState:UIControlStateSelected];
        } else {
            [button setTitleColor:TXSakuraColor(CommonPageLabelTextColor1) forState:UIControlStateSelected];
        }
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.frame = CGRectMake(buttonW * idx, 0, buttonW, self.height);
        [button addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 10000 + idx;
        [self addSubview:button];
        if (idx == self.defaultIdx) {
            if (self.multiTabType == MultiTabAssetPos ||
                self.multiTabType == MultiTabPacificInstitute) {
                CGSize size = [ToolHelper sizeForNoticeTitle:obj font:button.titleLabel.font];
                self.indictorView.width = size.width;
            }
            button.selected = YES;
            self.indictorView.centerX = button.centerX;
            self.lastSelectedButton = button;
        }
    }];
    
    if (self.multiTabType == MultiTabAssetPos ||
        self.multiTabType == MultiTabPacificInstitute) {
        [UIView adddView:CGRectMake(0, self.height - KSINGLELINE_WIDTH, kScreenWidth, KSINGLELINE_WIDTH) backColor:CommonSpaceLineUnfullColor superView:self];
    }
}

#pragma mark  点击事件
- (void)clickEvent:(UIButton *)sender {
    self.lastSelectedButton.selected = NO;
    sender.selected = YES;
    self.lastSelectedButton = sender;
    [UIView animateWithDuration:0.2 animations:^{
        if (self.multiTabType == MultiTabAssetPos ||
            self.multiTabType == MultiTabPacificInstitute) {
            CGSize size = [ToolHelper sizeForNoticeTitle:sender.titleLabel.text font:sender.titleLabel.font];
            self.indictorView.width = size.width;
        }
        self.indictorView.centerX = sender.centerX;
    }];
    if (self.block) {
        self.block(sender.tag - 10000, sender);
    }
}

#pragma mark  lazy
- (UIView *)indictorView {
    if (!_indictorView) {
        //距离底部4，高度为2，宽20
        _indictorView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 4 - 2, 20, 2)];
        if (self.multiTabType == MultiTabAssetPos ||
            self.multiTabType == MultiTabPacificInstitute) {
            _indictorView.top = self.height - 2;
        } else {
            _indictorView.top = self.height - 2 - 4;
        }
        
        if (self.multiTabType == MultiTabMallType ||
            self.multiTabType == MultiTabAssetPos ||
            self.multiTabType == MultiTabPacificInstitute) {
            _indictorView.sakura.backgroundColor(CommonPageLabelTextColor1);
        } else {
            _indictorView.sakura.backgroundColor(CommonPageLabelLineColor1);
        }
        [self addSubview:_indictorView];
    }
    return _indictorView;
}

@end

