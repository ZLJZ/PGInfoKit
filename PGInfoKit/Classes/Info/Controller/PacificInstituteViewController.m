//
//  PacificInstituteViewController.m
//  PanGu
//  
//  Created by 吴肖利 on 2018/12/12.
//  Copyright © 2018 Security Pacific Corporation. All rights reserved.
//

#import "PacificInstituteViewController.h"
#import "SDCycleScrollView.h"
#import "MultiTabView.h"
#import "PacificInstituteTableViewCell.h"
#import "InfoDetailViewController.h"
#import "InfoHeaderDefine.h"
#import "PanGuMallHeader.h"

@interface PacificInstituteViewController ()<SDCycleScrollViewDelegate>

//轮播图
@property (nonatomic, strong) SDCycleScrollView *scrollView;

@property (nonatomic, strong) MultiTabView *multiTabView;

@property (nonatomic, strong) NSArray *titleArr;

@property (nonatomic, strong) NSMutableArray *childArr;

@property (nonatomic, assign) PacificInstituteType type;

@property (nonatomic, strong) NSMutableArray *adData;

@property (nonatomic, assign) NSInteger tabIndex;

@end

@implementation PacificInstituteViewController

- (instancetype)initWithType:(PacificInstituteType)type {
    if (self = [super init]) {
        self.type = type;
        if (self.type == PacificInstituteTypeInfoNest) {
            self.title = @"太平洋研究";
        } else if (self.type == PacificInstituteTypeSudoku) {
            self.title = @"独家研报";
        }
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.type == PacificInstituteTypeInfoNest) {
        [self shutdownNavigationBarShadow];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.childArr = @[].mutableCopy;
    self.adData = @[].mutableCopy;
    self.tabIndex = 0;
    for (NSInteger i = 0 ;i < self.titleArr.count ; i ++) {
        PacificInstituteListViewController *vc = [[PacificInstituteListViewController alloc]initWithType:self.type curIdx:i];
        [self addChildViewController:vc];
        [self.childArr addObject:vc];
    }
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.multiTabView];
    [self loadAdData];
}


#pragma mark  请求广告接口
- (void)loadAdData {
    uWeakSelf
//    [InfoDataManager requestAdDataWithPosition:@"L11" key:kAdPositionResponseTop responseBlock:^(NSArray * _Nonnull data, NSArray * _Nonnull urlData) {
//        if (data.count != 0) {
//            weakSelf.adData = data.mutableCopy;
//            weakSelf.scrollView.height = 100;
//            weakSelf.multiTabView.top = weakSelf.scrollView.bottom;
//            weakSelf.multiTabView.height = kScreenHeight - NAV_HEIGHT - self.scrollView.bottom - (self.type == PacificInstituteTypeInfoNest ? 40 : 0);
//            weakSelf.multiTabView.scrollView.height = weakSelf.multiTabView.height - 40;
//            weakSelf.scrollView.imageURLStringsGroup = urlData;
//
//            [weakSelf.childArr enumerateObjectsUsingBlock:^(PacificInstituteListViewController *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                obj.tableView.height = weakSelf.multiTabView.scrollView.height;
//            }];
//        }
//    }];
}



- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
//    [PanGuMallPushManager mallPushAdWithModel:self.adData[index] vc:[ToolHelper getCurrentVC]];
}

- (SDCycleScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, 0) delegate:self placeholderImage:ImageNamed(@"mallimageloading")];
        _scrollView.currentPageDotColor = COLOR_RED;
        _scrollView.pageDotColor = COLOR_BACK;
        _scrollView.backgroundImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _scrollView;
}

- (MultiTabView *)multiTabView {
    if (!_multiTabView) {
        uWeakSelf
        _multiTabView = [[MultiTabView alloc]initWithFrame:CGRectMake(0, self.scrollView.bottom, kScreenWidth, kScreenHeight - NAV_HEIGHT - self.scrollView.height - (self.type == PacificInstituteTypeInfoNest ? 40 : 0)) titleArr:self.titleArr childArr:self.childArr defaultIdx:0 multiTabType:MultiTabPacificInstitute clickBlock:^(NSInteger index) {
            weakSelf.tabIndex = index;
            
        }];
    }
    return _multiTabView;
}

- (NSArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[@"公司点评",@"行业追踪",@"投资策略",@"年度投策"];
    }
    return _titleArr;
}

@end

@interface PacificInstituteListViewController()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, assign) PacificInstituteType type;

@property (nonatomic, assign) NSInteger pageNo;

@property (nonatomic, assign) BOOL isHeadRefresh;

@property (nonatomic, assign) NSInteger curIdx;

@end
@implementation PacificInstituteListViewController

- (instancetype)initWithType:(PacificInstituteType)type curIdx:(NSInteger)curIdx {
    if (self = [super init]) {
        self.type = type;
        self.curIdx = curIdx;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataSource = @[].mutableCopy;
    
    /*测试数据
    for (NSInteger i = 0; i < 20; i ++) {
        InfoReadingModel *model = [[InfoReadingModel alloc]init];
        model.title = i == 3 || i == 7 || i == 11 ? @"巨力索具：第五届董事会第十次会议决议公告次会议决议公告会第十次会议决" : @"巨力索具：第五届董事会第十次会议决议公告";
        model.source = @"太平洋研究";
        model.time = @"2018-03-03 11:22:23";
        [self.dataSource addObject:model];
    }
    [self.tableView reloadData];
    */
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.type == PacificInstituteTypeInfoNest) {
        [self shutdownNavigationBarShadow];
    }
}

#pragma mark  请求列表接口
- (void)loadData {
    uWeakSelf
    [InfoDataManager requestTPYResearchDataByPageNo:self.pageNo pageSize:15 category:kString_Format(@"%ld",self.curIdx + 1) responseBlock:^(EMPTY_TYPE emptyType, NSError * _Nonnull error, NSArray * _Nonnull data) {
        
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        
        if (!error) {
            if (data.count == 0) {
                [weakSelf dealWithExp:emptyType];
            } else {
                if (weakSelf.isHeadRefresh) {
                    [weakSelf.dataSource removeAllObjects];
                }
                [weakSelf.dataSource addObjectsFromArray:data];
                [weakSelf.tableView reloadData];
            }
        } else {
            [weakSelf dealWithExp:emptyType];
        }
    }];
}

#pragma mark  接口异常处理
- (void)dealWithExp:(EMPTY_TYPE)emptyType {
    [self reloadPublicHQEmptyData:self.dataSource emptyType:emptyType scrollView:self.tableView isHeadRefresh:self.isHeadRefresh];
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    [super emptyDataSet:scrollView didTapButton:button];
    [self.tableView.mj_header beginRefreshing];
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView addTableViewFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - NAV_HEIGHT - 40 - (self.type == PacificInstituteTypeInfoNest ? 40 : 0)) style:UITableViewStyleGrouped delegate:self emptyDelegate:self superView:self.view];
        uWeakSelf
        _tableView.mj_header = [PanGuRefreshHeader headerWithRefreshingBlock:^{
            weakSelf.pageNo = 1;
            weakSelf.isHeadRefresh = YES;
            [weakSelf loadData];
        }];
        [_tableView.mj_header beginRefreshing];
        _tableView.mj_footer = [PanGuRefreshFooter footerWithRefreshingBlock:^{
            if ((weakSelf.dataSource.count % 15 < 15 && weakSelf.dataSource.count % 15 > 0) || weakSelf.dataSource.count == 0) {
                [weakSelf.tableView.mj_footer setState:MJRefreshStateNoMoreData];
                return;
            }
            weakSelf.pageNo++;
            weakSelf.isHeadRefresh = NO;
            [weakSelf loadData];
        }];
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InfoReadingModel *model = self.dataSource[indexPath.row];
    PacificInstituteTableViewCell *cell = [PacificInstituteTableViewCell initWithTableView:tableView];
    [cell configData:model type:InfoListTypePacificInstitute];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    InfoReadingModel *model = self.dataSource[indexPath.row];
    return model.height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    InfoReadingModel *model = self.dataSource[indexPath.row];
    InfoDetailViewController *vc = [[InfoDetailViewController alloc]initWithType:InfoDetailTypePacificInstitute newsNo:model.newsno newsType:@""];
    [self pushViewController:vc from:self trade:NO];
}

@end
