//
//  BaseViewController.m
//  PanGu
//
//  Created by 陈伟平 on 16/6/2.
//  Copyright © 2016年 陈伟平. All rights reserved.
//

#import "BaseViewController.h"
#import "PGInfo.h"


@interface BaseViewController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _emptyType = 100;
    self.view.sakura.backgroundColor(CommonGlobalBackColor);
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationItem.title = self.title;
    self.navigationController.navigationBar.sakura.backgroundImage(CommonNavigationBackColor, UIBarMetricsDefault);
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:TXSakuraColor(CommonNavigationTitleColor)};

    
    //监听状态栏高度改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(StatusBarFrameWillChangeNotification:) name:UIApplicationWillChangeStatusBarFrameNotification object:nil];
    if (iOS7orLater) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;//关闭系统侧滑返回新特性
    }
}

- (void)shutdownNavigationBarShadow
{
    self.navigationController.navigationBar.layer.shadowColor = COLOR_WHITE.CGColor;
    self.navigationController.navigationBar.layer.shadowOffset = CGSizeZero;
    self.navigationController.navigationBar.layer.shadowOpacity = 0.0;
}

//弹出普通菊花
- (void)showLoadingView {
    [self showLoadingViewIsFillMask:NO];
}

- (void)showLoadingViewIsFillMask:(BOOL)isFillMask {
    
    if (self.hud) {
        [self.hud hideAnimated:YES];
    } 
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] init];
    hud.label.text = @"加载中...";
    hud.label.font = [UIFont systemFontOfSize:14];
    hud.bezelView.backgroundColor = [ToolHelper colorWithHex:@"#000000" alpha:0.8];
    hud.contentColor = COLOR_WHITE;
    hud.offset = CGPointMake(hud.offset.x, -NAV_HEIGHT);
    hud.removeFromSuperViewOnHide = YES;
    hud.minSize = CGSizeMake(100, 100);
    self.hud = hud;
    [self.view addSubview:hud];
    [self.view bringSubviewToFront:hud];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.hud showAnimated:YES];
    });
}

//弹出普通菊花 加 蒙版
- (void)showLoadingViewFillMask {
    [self showLoadingViewIsFillMask:YES];
}

- (void)showCurrentLoadingView:(NSString *_Nonnull)text {
    MBProgressHUD *hud = [[MBProgressHUD alloc] init];
    hud.label.text = text;
    hud.label.font = [UIFont systemFontOfSize:14];
    hud.bezelView.backgroundColor = [ToolHelper colorWithHex:@"#000000" alpha:0.8];
    hud.contentColor = COLOR_WHITE;
    hud.offset = CGPointMake(hud.offset.x, -NAV_HEIGHT);
    hud.minSize = CGSizeMake(100, 100);
    hud.removeFromSuperViewOnHide = YES;
    self.hud = hud;
    [self.view addSubview:hud];
    [self.view bringSubviewToFront:hud];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.hud showAnimated:YES];
    });
}

//隐藏普通菊花
- (void)hideLoadingView {
//    [self.view sendSubviewToBack:self.hud];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.hud hideAnimated:YES];
    });
}

//监听状态栏高度改变
-(void)StatusBarFrameWillChangeNotification:(NSNotification *)notification{
  //监听是否需要改变导航栏的高度问题
}


- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage getImageWithColor:COLOR_BLUE] forBarMetrics:(UIBarMetricsDefault)];
}

#pragma mark 界面篇
/**
 *  导航栏左右按钮
 *
 *  @param x 用来设置item偏移量(正值向左偏，负值向右偏),无特殊需求可传0;
 */
- (void)addLeftBtWithImage:(NSString *)imageName offSet:(CGFloat)x {
    
    if (imageName.length != 0) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 40, 44);
        [button setImage:ImageNamed(imageName) forState:UIControlStateNormal];
        [button setImageEdgeInsets:UIEdgeInsetsMake(13.5, -31, 13.5,0)];
        [button addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
        self.navigationItem.leftBarButtonItem = item;
    }else {
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.hidesBackButton = YES;
    }
}

//添加右上角纯图片按钮
- (void)addRightBtWithImage:(NSString *)imageName offSet:(CGFloat)x {
    
    if (imageName.length != 0) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:ImageNamed(imageName) forState:UIControlStateNormal];
        [button addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
        self.navigationItem.rightBarButtonItem = item;
    }else {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

/**
 *  添加右上角两张图片
 *
 *  @param firstImageName 第一张图片;
 *
 *  @param secondImageName 第二张图片;
 */
- (void)addRightBtTwoWithImage:(NSString *)firstImageName secondImageName:(NSString *)secondImageName{
    
    UIBarButtonItem *item0 = [[UIBarButtonItem alloc] initWithImage:ImageNamed(firstImageName) style:UIBarButtonItemStylePlain target:self action:@selector(firstRightAction)];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithImage:ImageNamed(secondImageName) style:UIBarButtonItemStylePlain target:self action:@selector(secondRightAction)];

    self.navigationItem.rightBarButtonItems = @[item0,item1];
}
/**
 *第一个触发事件
 **/
- (void)firstRightAction {
}
/**
 *第二个触发事件
 **/
- (void)secondRightAction {
}

//添加右上角纯文字按钮
- (void)addRightBtWithTitle:(NSString *)title color:(UIColor *)color font:(CGFloat)font offSet:(CGFloat)x {
    
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
//    [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font], NSForegroundColorAttributeName:color} forState:UIControlStateNormal];
//    [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font], NSForegroundColorAttributeName:color} forState:UIControlStateHighlighted];
//
//    self.navigationItem.rightBarButtonItem = item;
}

/**************************点击事件方法**************************************/
//左边点击方法
- (void)leftAction {
    [[HttpRequest getInstance] cancel];
    NSMutableArray *arr = self.navigationController.viewControllers.mutableCopy;
    [arr removeLastObject];
    [arr enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(UIViewController *viewController, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [self.navigationController popToViewController:viewController animated:YES];
        
        *stop = YES;
    }];
    
}

//右边点击方法
- (void)rightAction {
    // 空实现, 由子类重载
}

#pragma mark - UIViewController Overrides
//确定状态栏的类型
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}


//释放
-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"\r\nchenhua %@ dealloc\r\n",[self class]);
}

#pragma mark - DZNEmptyDataSetSource Methods
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text =@"";// @"No Application Found";
    return [[NSAttributedString alloc] initWithString:text attributes:nil];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    
    NSMutableAttributedString *attributedString;
    
    switch (_emptyType) {
        case EMPTY_TYPE_NO_DATA:
        {
            attributedString = [[NSMutableAttributedString alloc]initWithString:@"没有相应的查询信息" attributes:@{NSForegroundColorAttributeName:COLOR_DESCRIPTION,NSFontAttributeName:[UIFont systemFontOfSize:14]}];
        }
            break;
        case EMPTY_TYPE_NETWORK_ERROR:
        {
            attributedString = [[NSMutableAttributedString alloc]initWithString:@"居然出错了！生无可恋！" attributes:@{NSForegroundColorAttributeName:COLOR_DESCRIPTION,NSFontAttributeName:[UIFont systemFontOfSize:14]}];
        }
            break;
        case EMPTY_TYPE_NO_NETWORK:
        {
            attributedString = [[NSMutableAttributedString alloc]initWithString:@"网不给力，别让财富飞走\n请您及时修复网络～" attributes:@{NSForegroundColorAttributeName:COLOR_DESCRIPTION,NSFontAttributeName:[UIFont systemFontOfSize:14]}];
        }
            break;
            
        default:
            break;
    }
    
    return attributedString;
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    NSAttributedString *attributedString;
    switch (_emptyType) {
        
        case EMPTY_TYPE_NO_DATA:
        {
            
        }
            break;
        case EMPTY_TYPE_NETWORK_ERROR:
        {
            attributedString = [[NSAttributedString alloc]initWithString:@"点此刷新" attributes:@{NSForegroundColorAttributeName:COLOR_BLUE,NSFontAttributeName:[UIFont systemFontOfSize:16]}];
        }
            break;
        case EMPTY_TYPE_NO_NETWORK:
        {
            attributedString = [[NSAttributedString alloc]initWithString:@"点此刷新" attributes:@{NSForegroundColorAttributeName:COLOR_BLUE,NSFontAttributeName:[UIFont systemFontOfSize:16]}];
        }
            break;
            
        default:
            break;
    }
    
   
    return attributedString;
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return COLOR_WHITE;
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return 0;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *imageName = @"";
    switch (_emptyType) {
        
        case EMPTY_TYPE_NO_DATA: {
            imageName = @"public_nodata";
        }
            break;
        case EMPTY_TYPE_NETWORK_ERROR: {
            imageName = @"public_networkerror";
        }
            break;
        case EMPTY_TYPE_NO_NETWORK: {
            imageName = @"public_list_nonetwork";
        }
            break;
        default:
            break;
    }
    return ImageNamed(imageName);
}

#pragma mark - DZNEmptyDataSetDelegate Methods
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    switch (_emptyType) {
        case EMPTY_TYPE_NO_DATA: {
            return NO;
        }
            break;
        case EMPTY_TYPE_NETWORK_ERROR: {
            return YES;
        }
            break;
        case EMPTY_TYPE_NO_NETWORK: {
            return YES;
        }
            break;
        default:
            return NO;
            break;
    }
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    self.emptyType = EMPTY_TYPE_UNDEFINED;
    [scrollView reloadEmptyDataSet];
}

//列表极端状态处理方法
- (void)reloadPublicEmptyData:(NSMutableArray *)dataSource emptyType:(EMPTY_TYPE)emptyType scrollView:(UIScrollView *)scrollView isHeadRefresh:(BOOL)isHeadRefresh error:(NSError *) error {

    if (!isHeadRefresh) {
        if (dataSource.count != 0) {
            if (emptyType == EMPTY_TYPE_NO_NETWORK) {

            }
            
            if (emptyType != EMPTY_TYPE_NO_DATA) {
                if (error) {
                    if (error.code != NetworkErrorCode) {
                        ERROR_LOADING(error)
                    }
                } else {
                    [DLLoading DLToolTipInWindow:@"连接失败"];
                }
                
            }
        }
        return;
    }
    if (emptyType == EMPTY_TYPE_NO_NETWORK) {

    }
    self.emptyType = emptyType;
    [scrollView reloadEmptyDataSet];

    if ([scrollView isKindOfClass:[UITableView class]]) {
        if ([dataSource isKindOfClass:[NSMutableArray class]]) {
            [dataSource removeAllObjects];
        }
        [(UITableView *)scrollView reloadData];
    } else if ([scrollView isKindOfClass:[UICollectionView class]]) {
        if ([dataSource isKindOfClass:[NSMutableArray class]]) {
            [dataSource removeAllObjects];
        }
        [(UICollectionView *)scrollView reloadData];
    } else if ([scrollView isKindOfClass:[UIWebView class]]) {
        [(UIWebView *)scrollView reload];
    } else if ([scrollView isKindOfClass:[WKWebView class]]) {
        [(WKWebView *)scrollView reload];
    }
}

- (void)pushViewController:(nonnull BaseViewController *)viewController from:(nonnull BaseViewController *)fromViewController trade:(BOOL)isTrade {
    P_Log(@"%@", [NSString stringWithFormat:@"push ===== %@",NSStringFromClass([viewController class])]);
    [fromViewController.navigationController pushViewController:viewController animated:YES];
}

- (void)reloadPublicHQEmptyData:(NSMutableArray *)dataSource emptyType:(EMPTY_TYPE)emptyType scrollView:(UIScrollView *)scrollView isHeadRefresh:(BOOL)isHeadRefresh {
    
    if (dataSource.count != 0) return;
    if (emptyType == EMPTY_TYPE_NO_NETWORK) {
        
    }
    
    self.emptyType = emptyType;
    [scrollView reloadEmptyDataSet];
    
    if ([scrollView isKindOfClass:[UITableView class]]) {
        if ([dataSource isKindOfClass:[NSMutableArray class]]) {
            [dataSource removeAllObjects];
        }
        [(UITableView *)scrollView reloadData];
    } else if ([scrollView isKindOfClass:[UICollectionView class]]) {
        if ([dataSource isKindOfClass:[NSMutableArray class]]) {
            [dataSource removeAllObjects];
        }
        [(UICollectionView *)scrollView reloadData];
    } else if ([scrollView isKindOfClass:[UIWebView class]]) {
        [(UIWebView *)scrollView reload];
    } else if ([scrollView isKindOfClass:[WKWebView class]]) {
        [(WKWebView *)scrollView reload];
    }
}
@end
