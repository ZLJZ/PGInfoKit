//
//  InfoReadingViewController.m
//  PanGu
//
//  Created by 张琦 on 2017/7/11.
//  Copyright © 2017年 Security Pacific Corporation. All rights reserved.
//

#import "InfoReadingViewController.h"
#import "InfoReadingTableViewCell.h"
#import "InfoDetailViewController.h"
#import "InfoCalculate.h"
#import "NetworkRequest.h"
#import "InfoReadingModel.h"
#import "PGInfo.h"


@interface InfoReadingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger offset;//偏移量
    BOOL isHeadRefresh;//是否是下拉刷新
}

@property (nonatomic, strong) UITableView *tableView;//列表
@property (nonatomic, strong) NSMutableArray *dataSource;//数据源
@property (nonatomic, strong) UIButton *backTopButton;//回到顶部按钮
@property (nonatomic, strong) NSArray *tempDataSource;//temp数据源

@end

@implementation InfoReadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = [[NSMutableArray alloc]init];
    _tempDataSource = [[NSArray alloc]init];

    [self createTableView];
    [self refreshHeaderData];
    [self refreshFooterData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self shutdownNavigationBarShadow];
}

- (void)refreshHeaderData {
    _tableView.mj_header = [PanGuRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestDataOperation:)];
    [_tableView.mj_header beginRefreshing];
}

- (void)refreshFooterData {
    _tableView.mj_footer = [PanGuRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestDataOperation:)];
}

- (void)requestDataOperation:(id)obj {
    if ([obj isKindOfClass:[PanGuRefreshHeader class]]) {
        offset = 1;
        isHeadRefresh = YES;
    }
    
    if ([obj isKindOfClass:[PanGuRefreshFooter class]]) {
        if ((_dataSource.count % 15 < 15 && _dataSource.count % 15 > 0) || _dataSource.count == 0) {
            [_tableView.mj_footer setState:MJRefreshStateNoMoreData];
            return;
        }
        isHeadRefresh = NO;
        offset ++ ;
        
    }
    [self requestData];
}

- (void)requestData {
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:kString_Format(@"%ld",(long)offset) forKey:@"page"];
    [param setValue:@"15" forKey:@"limit"];
    
    [NetworkRequest getRequestUrlString:[UrlManager getInfoStreamingURL] params:param success:^(id responseObject) {
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:3 error:nil];
        P_Log(@"--成功:%@",dic);
        NSString *codeStr = dic[@"code"];
        if (![codeStr isKindOfClass:[NSString class]]) {
            [self reloadPublicEmptyData:_dataSource emptyType:EMPTY_TYPE_NETWORK_ERROR scrollView:_tableView isHeadRefresh:isHeadRefresh error:nil];
            return;
        }

        if (![codeStr isEqualToString:@"200"]) {
            [self reloadPublicEmptyData:_dataSource emptyType:EMPTY_TYPE_NETWORK_ERROR scrollView:_tableView isHeadRefresh:isHeadRefresh error:nil];
            return;
        }

        if ([dic[@"data"] count] == 0) {
            [self reloadPublicEmptyData:_dataSource emptyType:EMPTY_TYPE_NO_DATA scrollView:_tableView isHeadRefresh:isHeadRefresh error:nil];
            return;
        } else {
            if (isHeadRefresh) [_dataSource removeAllObjects];
        }
        
        __block NSString *str;
        if (isHeadRefresh == YES) {
            str = @"";
        } else {
            InfoReadingModel *tempModel = _tempDataSource.lastObject;
            str = tempModel.date;
        }
        
        [dic[@"data"] enumerateObjectsUsingBlock:^(NSArray *  _Nonnull subArr, NSUInteger idx, BOOL * _Nonnull stop) {
            //
            [subArr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull subDic, NSUInteger idx, BOOL * _Nonnull stop) {
                //
                InfoReadingModel *model = [[InfoReadingModel alloc]init];
                [model setValuesForKeysWithDictionary:subDic];
                model.digest = [model.digest stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                if (idx == 0 && ![str isEqualToString:model.date]) {
                    model.isFirst = YES;
                }
                [_dataSource addObject:model];
                
            }];
        }];
        _tempDataSource = _dataSource.mutableCopy;
        
        [_tableView reloadData];
    } failure:^(NSError *error) {
        [self reloadPublicEmptyData:_dataSource emptyType:error.code == NetworkErrorCode ? EMPTY_TYPE_NO_NETWORK: EMPTY_TYPE_NETWORK_ERROR scrollView:_tableView isHeadRefresh:isHeadRefresh error:error];
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        
    }];
    
}

-(void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    [super emptyDataSet:scrollView didTapButton:button];
    [self refreshHeaderData];
}


- (UIButton *)backTopButton {
    if (!_backTopButton) {
        _backTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backTopButton.frame = CGRectMake(kScreenWidth - 11 - 35, kScreenHeight - NAV_HEIGHT - 40 - 35 - 11, 35, 35);
        [_backTopButton setBackgroundImage:ImageNamed(@"backTop") forState:UIControlStateNormal];
        _backTopButton.hidden = YES;
        [_backTopButton addTarget:self action:@selector(clickBackTop) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_backTopButton];
        [self.view bringSubviewToFront:_backTopButton];
    }
    return _backTopButton;
}

- (void)clickBackTop {

    [_tableView setContentOffset:CGPointZero animated:YES];
    [self refreshHeaderData];
}

- (void)controlButtonIsHidden:(BOOL)isHidden {
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 4.f;
    [self.backTopButton.layer addAnimation:animation forKey:nil];
    self.backTopButton.hidden = isHidden;
}


- (void)createTableView {
    _tableView = [UITableView addTableViewFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-NAV_HEIGHT - 40) style:UITableViewStyleGrouped delegate:self emptyDelegate:self superView:self.view];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_dataSource.count == 0) {
        return 0;
    }
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InfoReadingTableViewCell *cell = [InfoReadingTableViewCell infoReadingTableViewCell:tableView];
    InfoReadingModel *model = _dataSource[indexPath.row];
    if (model.isFirst == YES) {
        cell.calendarImageView.image = ImageNamed(@"infoCalendar");
        cell.calendarImageView.frame = CGRectMake(26 - 11, 0, 22, 22);
        cell.calendarTopLabel.hidden = NO;
        cell.calendarBottomLabel.hidden = NO;
        cell.calendarTopLabel.text = [DateHelper dateNumberConvertEnglish:model.date];
        cell.calendarBottomLabel.text = [model.date substringFromIndex:8];
        cell.calendarTopLabel.frame = CGRectMake(0, 0, cell.calendarImageView.width, 5);
        cell.calendarBottomLabel.frame = CGRectMake(0, cell.calendarTopLabel.bottom, cell.calendarImageView.width, cell.calendarImageView.height - cell.calendarTopLabel.height);
    } else {
        cell.calendarImageView.image = ImageNamed(@"infoDot");
        cell.calendarImageView.frame = CGRectMake(26 - 5, 0, 10, 10);
        cell.calendarTopLabel.hidden = YES;
        cell.calendarBottomLabel.hidden = YES;
    }
    cell.dateLabel.text = [NSString stringWithFormat:@"%@ %@",model.date,model.time];
    cell.titleLabel.text = model.title;
    cell.contentLabel.text = model.digest;
    
    cell.dateLabel.top = cell.calendarImageView.centerY - 5;
    CGFloat titleLabelHeight = [InfoCalculate caculateHeight:cell.titleLabel lineSpace:5 fontSize:17 row:2];
    CGFloat contentLabelHeight = [InfoCalculate caculatePingFangLightHeight:cell.contentLabel lineSpace:5 fontSize:15];
    cell.titleLabel.frame = CGRectMake(cell.dateLabel.left, cell.dateLabel.bottom + 10, kScreenWidth - 15 - cell.dateLabel.left, titleLabelHeight);
    cell.contentLabel.frame = CGRectMake(cell.titleLabel.left, cell.titleLabel.bottom + 10, cell.titleLabel.width, contentLabelHeight);
    cell.bottomSingleView.frame = CGRectMake(26, cell.calendarImageView.bottom, KSINGLELINE_WIDTH, cell.contentLabel.bottom - cell.calendarImageView.bottom + 31);
    cell.cellHeight = cell.bottomSingleView.bottom;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    InfoReadingTableViewCell *cell = (InfoReadingTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.cellHeight;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 25)];
    headView.sakura.backgroundColor(CommonListContentContentBackColor);
    return headView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y > 0 && _dataSource.count > 0) {
        [self controlButtonIsHidden:NO];
    } else {
        [self controlButtonIsHidden:YES];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    InfoReadingModel *model = _dataSource[indexPath.row];
    InfoDetailViewController *vc = [[InfoDetailViewController alloc]initWithType:InfoDetailTypeOrdinary newsNo:model.newsno newsType:@""];
    [self pushViewController:vc from:self trade:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
