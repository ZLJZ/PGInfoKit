//
//  InformationMainViewController.m
//  PanGu
//
//  Created by 吴肖利 on 16/9/5.
//  Copyright © 2016年 Security Pacific Corporation. All rights reserved.
//

#import "InformationMainViewController.h"
#import "UIView+XMGExtension.h"
#import "EditColumnViewController.h"
#import "InfoImportantNewsViewController.h"
#import "InfoReadingViewController.h"
#import "InfoTagViewController.h"
#import "InfoHeaderDefine.h"
#import "PacificInstituteViewController.h"


@interface InformationMainViewController ()<UIScrollViewDelegate>
{
    BOOL _isExist;
}
/** 标签栏底部指示器*/
@property (nonatomic, weak) UIView *indicatorView;
/** 当前选中的按钮*/
@property (nonatomic, weak) UIButton *selectedButton;
/** 顶部的标签*/
@property (nonatomic, strong) UIScrollView *titlesView;
/** UIScrollView*/
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic) BOOL isEdit;

@end

@implementation InformationMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestInfoColumn];
    _isExist = NO;
    _isEdit = NO;
    [self customUI];
    [self createEditCommon];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self shutdownNavigationBarShadow];
}

- (void)requestInfoColumn {
    [NetworkRequest getRequestUrlString:[UrlManager getInfoClassListURL] params:nil success:^(id responseObject) {
        //
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:3 error:nil];
        P_Log(@"--成功:%@",dic);
        NSString *codeStr = dic[@"code"];
        if (![codeStr isKindOfClass:[NSString class]]) return;
        
        if (![codeStr isEqualToString:@"200"]) return;
        
        NSMutableArray *classArr = [[NSMutableArray alloc]init];
        for (NSDictionary *subDic in dic[@"data"]) {
            NSArray *arr = @[subDic[@"classname"]?subDic[@"classname"]:@"",subDic[@"classno"]?subDic[@"classno"]:@"",subDic[@"status"]?subDic[@"status"]:@""];
            [classArr addObject:arr];
        }
        NSArray *editColumnArr = [InfoCalculate queryNewEditColumnUserDefaults];
        BOOL isDiff = [InfoCalculate filterArr:editColumnArr[0] andArr2:classArr];
        if (isDiff) {
            //编辑栏目更新
            [InfoCalculate updateNewEditColumnUserDafaults:classArr];
            [self removeView];
            [self createEditCommon];
        }

    } failure:^(NSError *error) {
        //
    }];
    
}

- (void)leftAction {
    [super leftAction];

    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"infoImportantNews"];
    NSMutableArray *readingArr = [NSKeyedUnarchiver unarchiveObjectWithData:data];

    if (readingArr.count >= 3 && _isListInfo == YES) {
        if (_readingDataSourceBlock) {
            _readingDataSourceBlock([readingArr subarrayWithRange:NSMakeRange(0, 3)]);
        }
    }
}

- (void)createEditCommon {
    //初始化子控制器
    [self createChildViewControllers];
    //设置顶部标签栏
    [self createTitlesView];
    //底部的scrollview
    [self createScrollView];
}

- (void)customUI {
    [self addRightBtWithTitle:@"编辑" color:TXSakuraColor(CommonNavigationTitleColor) font:15 offSet:0];
    self.navigationItem.title = @"资讯";
}

- (void)rightAction {
    EditColumnViewController *editColumnVC = [[EditColumnViewController alloc]init];
    editColumnVC.EditBlock = ^(BOOL isEdit){
        _isEdit = isEdit;
        [self removeView];
        _isEdit = isEdit;
        [self createEditCommon];
    };
    [self.navigationController pushViewController:editColumnVC animated:YES];
}

- (void)removeView {
    for (UIViewController *vc in self.childViewControllers) {
        [vc willMoveToParentViewController:nil];
        [vc removeFromParentViewController];
    }
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
}

-(void)createChildViewControllers {
    _isExist = NO;
    _titleArray = [[NSMutableArray alloc]init];
    NSArray *arr = [InfoCalculate queryNewEditColumnUserDefaults];
    
    if (arr.count != 0) {
        for (NSInteger i = 0; i < [arr[0] count]; i ++ ) {
            BOOL selectState = [[arr[1] objectAtIndex:i] boolValue];
            if (selectState == YES) {
                [_titleArray addObject:arr[0][i]];
            }
        }
    }
    
    if (_titleArray.count == 0) {
        _titleArray = @[@[@"要闻",@"1"],
                        @[@"直播",@"2"],
                        @[@"独家研报",@"3"],
                        @[@"红珊瑚资讯",@"4"]
                        ].mutableCopy;
    }
    
    
    for (NSInteger i = 0; i < _titleArray.count; i ++ ) {
        if (i == _jumpType && [_titleArray[i][1] isEqualToString:kString_Format(@"%zd",_jumpType + 1)]) {
            _isExist = YES;
        }
        if ([_titleArray[i][1] isEqualToString:@"1"]) {
            InfoImportantNewsViewController *vc = [[InfoImportantNewsViewController alloc]init];
            vc.title = _titleArray[i][0];
            [self addChildViewController:vc];
            
        } else if ([_titleArray[i][1] isEqualToString:@"2"]) {
            InfoReadingViewController *vc = [[InfoReadingViewController alloc]init];
            vc.title = _titleArray[i][0];
            [self addChildViewController:vc];
        } else if ([_titleArray[i][1] isEqualToString:@"3"]) {
            PacificInstituteViewController *vc = [[PacificInstituteViewController alloc]initWithType:PacificInstituteTypeInfoNest];
            vc.title = _titleArray[i][0];
            [self addChildViewController:vc];
        } else {
            //
            InfoTagViewController *viewController = [[InfoTagViewController alloc]init];
            viewController.title = _titleArray[i][0];
            viewController.classno = _titleArray[i][1];
            [self addChildViewController:viewController];
        }
    }
}

-(void)createScrollView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth, kScreenHeight - NAV_HEIGHT - 40)];
    self.scrollView.sakura.backgroundColor(CommonGlobalBackColor);
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width * self.childViewControllers.count, 0);
    self.scrollView.pagingEnabled = YES;
    [self.view insertSubview:self.scrollView atIndex:0];
    
    self.scrollView.contentOffset = CGPointMake((_isEdit || !_isExist) ? 0 : kScreenWidth * _jumpType, 0);
    [self scrollViewDidEndScrollingAnimation:self.scrollView];
}

-(void)createTitlesView {
    UIView *backView = [UIView adddView:CGRectMake(0, 0, kScreenWidth, 40) backColor:CommonPageLabelBackColor1 superView:self.view];
    backView.layer.shadowColor = COLOR_LIGHTGRAY.CGColor;
    backView.layer.shadowOffset = CGSizeMake(0, 4);
    backView.layer.shadowOpacity = 0.1;
    
    NSInteger count = self.childViewControllers.count;
    self.titlesView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    self.titlesView.sakura.backgroundColor(CommonListContentContentBackColor);
    self.titlesView.bounces = NO;
    self.titlesView.showsHorizontalScrollIndicator = NO;
    self.titlesView.showsVerticalScrollIndicator = NO;
    [backView addSubview:self.titlesView];
    
    self.indicatorView = [UIView adddView:CGRectMake(0, self.titlesView.height - 6, 20, 2) backColor:CommonPageLabelLineColor2 superView:self.titlesView];
    
    CGFloat totalWidth = 0;
    for (int i = 0; i < count; i ++ ) {
        UIViewController *vc = self.childViewControllers[i];
        CGSize size = [ToolHelper sizeForNoticeTitle:vc.title font:[UIFont systemFontOfSize:14]];
        CGFloat width = size.width + 4 * KSINGLELINE_WIDTH;
        totalWidth = totalWidth + width;
    }
    
    CGFloat disX = 0;
    CGFloat space = 0;
    if (totalWidth + (count-1) * 30 + 20 <= kScreenWidth) {
        if (count == 2) {
            disX = (kScreenWidth - totalWidth)/4;
            space = (kScreenWidth - totalWidth)/2;
        } else {
            disX = 20;
            space = (kScreenWidth - totalWidth - 40)/(count-1);
        }
    } else {
        disX = 20;
        space = 30;
    }
    
    self.titlesView.contentSize = CGSizeMake(disX + totalWidth + space * (count -1 ) + 20, 40);

    for (int i = 0; i < count; i++) {
        UIViewController *vc = self.childViewControllers[i];
        CGSize size = [ToolHelper sizeForNoticeTitle:vc.title font:[UIFont systemFontOfSize:14]];
        UIButton *button = [UIButton addBtn:CGRectMake(disX, 0, size.width + 4 * KSINGLELINE_WIDTH, self.titlesView.height) UIFont:[UIFont systemFontOfSize:14] title:vc.title titleColor:CommonPageLabelUnTextColor2 backColor:nil superView:self.titlesView];
        button.sakura.titleColor(CommonPageLabelTextColor2,UIControlStateDisabled);
        disX = button.width + disX + space;
        button.tag = i;
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 2) {
            UILabel *label = [UILabel addLabel:CGRectMake(button.width - 8, 0, 25, 11) text:@"推荐" textColor:COLOR_WHITE UIFont:[UIFont systemFontOfSize:10] aligment:NSTextAlignmentCenter backColor:COLOR_YELLOW superView:button];
            label.layer.cornerRadius = 5;
            label.layer.masksToBounds = YES;
        }
         
        
        if (i == ((_isEdit || !_isExist)?0:_jumpType)) {
            button.enabled = NO;
            self.selectedButton = button;
            self.indicatorView.width = 20;
            self.indicatorView.centerX = button.centerX;
        }
    }
    [self.titlesView bringSubviewToFront:self.indicatorView];
}

#pragma mark 便签栏按钮点击
-(void)titleClick:(UIButton *)button {
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    [UIView animateWithDuration:0.01 animations:^{
        self.indicatorView.centerX = self.selectedButton.centerX;
    }];
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = button.tag * self.scrollView.width;
    [self.scrollView setContentOffset:offset animated:YES];
    
    NSInteger count = self.childViewControllers.count;
    CGFloat totalWidth = 0;
    for (int i = 0; i < count; i ++ ) {
        UIViewController *vc = self.childViewControllers[i];
        CGSize size = [ToolHelper sizeForNoticeTitle:vc.title font:[UIFont systemFontOfSize:14]];
        CGFloat width = size.width + 4 * KSINGLELINE_WIDTH;
        totalWidth = totalWidth + width;
    }
    if (!(totalWidth + (count-1) * 30 + 20 <= kScreenWidth)) {
        if (button.center.x > (kScreenWidth/2) && button.center.x < (self.titlesView.contentSize.width - (kScreenWidth/2))) {
            self.titlesView.contentOffset = CGPointMake(button.center.x - (kScreenWidth / 2), 0);
        }else if (button.center.x <= (kScreenWidth/2)) {
            self.titlesView.contentOffset = CGPointMake(0, 0);
        }else {
            self.titlesView.contentOffset = CGPointMake(self.titlesView.contentSize.width - kScreenWidth, 0);
        }
    }
}

#pragma mark -UIScrollViewDelegate
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;
    vc.view.height = scrollView.height;
    [scrollView addSubview:vc.view];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    NSInteger count = self.childViewControllers.count;
    CGFloat totalWidth = 0;
    for (int i = 0; i < count; i ++ ) {
        UIViewController *vc = self.childViewControllers[i];
        CGSize size = [ToolHelper sizeForNoticeTitle:vc.title font:[UIFont systemFontOfSize:14]];
        CGFloat width = size.width + 4 * KSINGLELINE_WIDTH;
        totalWidth = totalWidth + width;
    }
    if (!(totalWidth + (count-1) * 30 + 20 <= kScreenWidth)) {
        UIButton *button = self.titlesView.subviews[index];
        if (button.center.x > (kScreenWidth/2) && button.center.x < (self.titlesView.contentSize.width - (kScreenWidth/2))) {
            self.titlesView.contentOffset = CGPointMake(button.center.x - (kScreenWidth / 2), 0);
        }else if (button.center.x <= (kScreenWidth/2)) {
            self.titlesView.contentOffset = CGPointMake(0, 0);
        }else {
            self.titlesView.contentOffset = CGPointMake(self.titlesView.contentSize.width - kScreenWidth, 0);
        }
    }    
    [self titleClick:self.titlesView.subviews[index]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
