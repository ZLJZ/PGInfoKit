//
//  InfoTagViewController.m
//  PanGu
//
//  Created by 张琦 on 2017/7/20.
//  Copyright © 2017年 Security Pacific Corporation. All rights reserved.
//

#import "InfoTagViewController.h"
#import "HQNewsModel.h"
#import "InfoTagTableViewCell.h"
#import "InfoDetailViewController.h"
//#import "HQAboutDetailViewController.h"
#import "InfoHeaderDefine.h"
#import "PGInfo.h"


@interface InfoTagViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger offset;//偏移量
    BOOL isHeadRefresh;//是否是下拉刷新
}
@property (nonatomic, strong) UITableView *tableView;//列表

@property (nonatomic, strong) NSMutableArray *dataSource;//数据源

@property (nonatomic, strong) UIView *headView;


@end

@implementation InfoTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = [[NSMutableArray alloc]init];
    
    [self createTableView];
    [self refreshHeaderData];
    [self refreshFooterData];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self shutdownNavigationBarShadow];
}

-(UIView *)headView {
    if (!_headView) {
        NSString *imageName = @"";
        NSString *digestStr = @"";
        NSString *nameStr = @"";
        
        if ([self.classno isEqualToString:@"3"]) {
            imageName = @"pacificStudy";
            digestStr = @"专业研究员深入分析";
            nameStr = @"太平洋研究";
        } else if ([self.classno isEqualToString:@"4"]) {
            imageName = @"redCoral";
            digestStr = @"太平洋至尊投顾服务";
            nameStr = @"红珊瑚资讯";
        }
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 69)];
        _headView.sakura.backgroundColor(CommonGlobalBackColor);
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
        backView.sakura.backgroundColor(CommonListContentContentBackColor);
        [_headView addSubview:backView];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 65, 64)];
        imageView.image = ImageNamed(imageName);
        imageView.contentMode = UIViewContentModeCenter;
        [backView addSubview:imageView];
        
        UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.right + 16, 9, 130, 28)];
        topLabel.sakura.textColor(CommonListContentTextColor);
        topLabel.font = [UIFont boldSystemFontOfSize:20];
        topLabel.text = nameStr;
        [backView addSubview:topLabel];
        MyAttributedStringBuilder *builder = [[MyAttributedStringBuilder alloc]initWithString:topLabel.text];
        [[builder range:NSMakeRange(3, 2)] setFont:[UIFont systemFontOfSize:20]];
        topLabel.attributedText = builder.commit;
        
        UILabel *bottomLabel = [[UILabel alloc]initWithFrame:CGRectMake(topLabel.left, backView.height - 7 - 20, topLabel.width, 20)];
        bottomLabel.sakura.textColor(CommonListContentTextColor);
        bottomLabel.font = [UIFont systemFontOfSize:14];
        bottomLabel.text = digestStr;
        [backView addSubview:bottomLabel];
        
        UILabel *rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 20 - 69, (backView.height - 20)/2.0, 69, 20)];
        rightLabel.text = @"独家资讯";
        rightLabel.font = [UIFont systemFontOfSize:12];
        rightLabel.sakura.textColor(CommonPageLabelTextColor1);
        rightLabel.layer.sakura.borderColor(CommonPageLabelTextColor1);
        rightLabel.layer.borderWidth = KSINGLELINE_WIDTH;
        rightLabel.layer.cornerRadius = 10;
        rightLabel.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:rightLabel];
    }
    return _headView;
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
    if (_managementno.length != 0) {
        
    }else{
        NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
        [param setValue:kString_Format(@"%ld",(long)offset) forKey:@"page"];
        [param setValue:@"15" forKey:@"limit"];
        [param setValue:_classno forKey:@"classno"];
        
        [NetworkRequest getRequestUrlString:[UrlManager getInfoHkstocksURL] params:param success:^(id responseObject) {
            [_tableView.mj_header endRefreshing];
            [_tableView.mj_footer endRefreshing];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:3 error:nil];
            P_Log(@"--成功:%@",dic);
            NSString *codeStr = dic[@"code"];
            if (![codeStr isKindOfClass:[NSString class]]) {
                [self reloadPublicEmptyData:_dataSource emptyType:EMPTY_TYPE_NETWORK_ERROR scrollView:_tableView isHeadRefresh:isHeadRefresh error:nil];
                _tableView.tableHeaderView = [UIView new];
                return;
            }
            if (![codeStr isEqualToString:@"200"]) {
                [self reloadPublicEmptyData:_dataSource emptyType:EMPTY_TYPE_NETWORK_ERROR scrollView:_tableView isHeadRefresh:isHeadRefresh error:nil];
                _tableView.tableHeaderView = [UIView new];
                return;
            }
            
            NSArray *dicArr = dic[@"data"];
            if (dicArr.count == 0) {
                [self reloadPublicEmptyData:_dataSource emptyType:EMPTY_TYPE_NO_DATA scrollView:_tableView isHeadRefresh:isHeadRefresh error:nil];
                _tableView.tableHeaderView = [UIView new];
                return;
            } else {
                if (isHeadRefresh) [_dataSource removeAllObjects];
            }
            
            for (NSDictionary *subDic in dicArr) {
                InfoReadingModel *model = [[InfoReadingModel alloc]init];
                [model setValuesForKeysWithDictionary:subDic];
                [_dataSource addObject:model];
                
            }
            if ([self.classno isEqualToString:@"3"] || [self.classno isEqualToString:@"4"]) {
                _tableView.tableHeaderView = self.headView;
            }
            [_tableView reloadData];
        } failure:^(NSError *error) {
            [_tableView.mj_header endRefreshing];
            [_tableView.mj_footer endRefreshing];
            _tableView.tableHeaderView = [UIView new];
            [self reloadPublicEmptyData:_dataSource emptyType:error.code == NetworkErrorCode ? EMPTY_TYPE_NO_NETWORK: EMPTY_TYPE_NETWORK_ERROR scrollView:_tableView isHeadRefresh:isHeadRefresh error:error];
        }];
    }
}

-(void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    [super emptyDataSet:scrollView didTapButton:button];
    [self refreshHeaderData];
}

- (void)createTableView {
    _tableView = [UITableView addTableViewFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-NAV_HEIGHT - 40) style:UITableViewStyleGrouped delegate:self emptyDelegate:self superView:self.view];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    InfoTagTableViewCell *cell = [InfoTagTableViewCell infoTagTableView:tableView];
    InfoReadingModel *model = _dataSource[indexPath.row];
    cell.titleLabel.text = model.title;
    CGFloat titleLabelHeight = [InfoCalculate caculateHeight:cell.titleLabel lineSpace:5 fontSize:17 row:2];
    cell.titleLabel.frame = CGRectMake(15, 15, kScreenWidth - 30, titleLabelHeight);
    cell.dateLabel.text = [DateHelper dateStrWithTotalStr:model.time];
    cell.dateLabel.frame = CGRectMake(15, cell.titleLabel.bottom + 10, 150, 14);
    cell.cellHeight = cell.dateLabel.bottom + 15;
    cell.singleView.frame = CGRectMake(15, cell.cellHeight - KSINGLELINE_WIDTH, kScreenWidth - 15, KSINGLELINE_WIDTH);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    InfoTagTableViewCell *cell = (InfoTagTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_managementno.length > 0) {
//        InfoReadingModel *model = _dataSource[indexPath.row];
//        HQAboutDetailViewController *vc = [[HQAboutDetailViewController alloc] initWithNewsNo:model.newsno title:@"公告详情"];
//        [self pushViewController:vc from:self trade:NO];
//        return;
    }
    InfoReadingModel *model = _dataSource[indexPath.row];
    InfoDetailViewController *vc = [[InfoDetailViewController alloc]initWithType:([self.classno isEqualToString:@"3"] || [self.classno isEqualToString:@"4"]) ? InfoDetailTypeDefault : InfoDetailTypeOrdinary newsNo:model.newsno newsType:[self.title isEqualToString:@"负面"] ? @"1" : self.classno];
    [self pushViewController:vc from:self trade:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
