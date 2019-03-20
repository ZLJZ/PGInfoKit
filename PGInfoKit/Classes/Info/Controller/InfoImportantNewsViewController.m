//
//  InfoImportantNewsViewController.m
//  PanGu
//
//  Created by 张琦 on 2017/7/10.
//  Copyright © 2017年 Security Pacific Corporation. All rights reserved.
//

#import "InfoImportantNewsViewController.h"
#import "InfoImportantNewsTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "NetworkRequest.h"
#import "InfoCalculate.h"
#import "InfoImportantNewsModel.h"
#import "InfoDetailViewController.h"

#import "UIImage+info.h"
#import "PGInfo.h"



#define ScrollPicHeight             180 * (kScreenWidth - 40) / 345.f   //轮播图图片高
#define SmallPicAspectRatio         12 / 9.f    //列表图片比例
#define BigPicAspectRatio           345 / 180.f     //轮播图图片比例
@interface InfoImportantNewsViewController ()<UITableViewDelegate,UITableViewDataSource,LoopScrollViewDelegate,LoopScrollViewDataSource>
{
    NSInteger offset;//偏移量
    BOOL isHeadRefresh;//是否是下拉刷新
    CGFloat scrollViewHeight;//scrollView高
}

@property (nonatomic, strong) UITableView *tableView;//列表
@property (nonatomic, strong) NSMutableArray *topDataSource;//轮播图数据源
@property (nonatomic, strong) NSMutableArray *bottomDataSource;//底部列表数据源
@property (nonatomic, strong) LoopScrollView *loopScrollView;//轮播图
@property (nonatomic, strong) NSMutableArray *imgArr;//轮播图图片数组
@property (nonatomic, strong) UIView *headView;//头视图



@end

@implementation InfoImportantNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _topDataSource = [[NSMutableArray alloc]init];
    _bottomDataSource = [[NSMutableArray alloc]init];
    scrollViewHeight = 40 + ScrollPicHeight + 34;
    
    [self createTableView];
    [self createHeadView];
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
        [self requestTopDataLimit:@"3" level:@"4"];
    }
    
    if ([obj isKindOfClass:[PanGuRefreshFooter class]]) {
        if ((_bottomDataSource.count % 10 < 10 && _bottomDataSource.count % 10 > 0 && _topDataSource.count == 0) || _bottomDataSource.count == 0) {
            [_tableView.mj_footer setState:MJRefreshStateNoMoreData];
            return;
        }
        isHeadRefresh = NO;
        offset ++ ;
        [self requestDataLimit:@"10" level:@"3"];

    }
}

- (void)requestTopDataLimit:(NSString *)limit level:(NSString *)level {
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:kString_Format(@"%ld",(long)offset) forKey:@"page"];
    [param setValue:limit forKey:@"limit"];
    [param setValue:level forKey:@"level"];
    
    [NetworkRequest getRequestUrlString:[UrlManager getInfoImportantURL] params:param success:^(id responseObject) {
        //
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:3 error:nil];
        P_Log(@"--成功:%@",dic);
        NSString *codeStr = dic[@"code"];
        if (![codeStr isKindOfClass:[NSString class]]) {
            P_Log(@"服务器返回code值不是字符串类型!");
            [self requestDataLimit:@"10" level:@"3"];
            return ;
        }
        
        if (![codeStr isEqualToString:@"200"]) {
            P_Log(@"服务器返回code值为%@",codeStr);
            [self requestDataLimit:@"10" level:@"3"];
            return ;
        }
        
        if (isHeadRefresh == YES) {
            if ([dic[@"data"] count] == 0) {
                [self requestDataLimit:@"10" level:@"3"];
                return ;
            } else {
                [_topDataSource removeAllObjects];
                
            }
            
        }
        
        for (NSDictionary *subDic in dic[@"data"]) {
            InfoImportantNewsModel *model = [[InfoImportantNewsModel alloc]init];
            [model setValuesForKeysWithDictionary:subDic];
            [_topDataSource addObject:model];
        }
        _headView.frame = CGRectMake(0, 0, kScreenWidth, 11 + scrollViewHeight);
        _headView.hidden = NO;

        [_loopScrollView reloadData];
        [self requestDataLimit:@"10" level:@"3"];
    } failure:^(NSError *error) {
        if (error.code == NetworkErrorCode) {
            [self reloadPublicEmptyData:_bottomDataSource emptyType:EMPTY_TYPE_NO_NETWORK scrollView:_tableView isHeadRefresh:isHeadRefresh error:nil];
        
            [self dealWithTop];
            [_tableView.mj_header endRefreshing];
            [_tableView.mj_footer endRefreshing];
             
        }else {
            
            [self requestDataLimit:@"10" level:@"3"];
        }
    }];
}

- (void)requestDataLimit:(NSString *)limit level:(NSString *)level {
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:kString_Format(@"%ld",(long)offset) forKey:@"page"];
    [param setValue:limit forKey:@"limit"];
    [param setValue:level forKey:@"level"];
    
    [NetworkRequest getRequestUrlString:[UrlManager getInfoImportantURL] params:param success:^(id responseObject) {
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:3 error:nil];
        P_Log(@"--成功:%@",dic);
        NSString *codeStr = dic[@"code"];
        if (![codeStr isKindOfClass:[NSString class]]) {
            [self dealWithTop];
            [self reloadPublicEmptyData:_bottomDataSource emptyType:EMPTY_TYPE_NETWORK_ERROR scrollView:_tableView isHeadRefresh:isHeadRefresh error:nil];
            return ;
        }
        
        if (![codeStr isEqualToString:@"200"]) {
            [self dealWithTop];
            [self reloadPublicEmptyData:_bottomDataSource emptyType:EMPTY_TYPE_NETWORK_ERROR scrollView:_tableView isHeadRefresh:isHeadRefresh error:nil];
            return ;
        }
        
        if ([dic[@"data"] count] == 0) {
            [self dealWithTop];
                
            [self reloadPublicEmptyData:_bottomDataSource emptyType:EMPTY_TYPE_NO_DATA scrollView:_tableView isHeadRefresh:isHeadRefresh error:nil];
            return ;
        } else {
            if (isHeadRefresh) {
                [_bottomDataSource removeAllObjects];
            }
        }

        for (NSDictionary *subDic in dic[@"data"]) {
            InfoImportantNewsModel *model = [[InfoImportantNewsModel alloc]init];
            [model setValuesForKeysWithDictionary:subDic];
            [_bottomDataSource addObject:model];
        }
        
        //下拉刷新有必要存一下
        if (isHeadRefresh == YES) {
            [self tempDataSourceBlock:_bottomDataSource];
        }

        
        [_tableView reloadData];

    } failure:^(NSError *error) {
        [self dealWithTop];
        [self reloadPublicEmptyData:_bottomDataSource emptyType:error.code == NetworkErrorCode ? EMPTY_TYPE_NO_NETWORK: EMPTY_TYPE_NETWORK_ERROR scrollView:_tableView isHeadRefresh:isHeadRefresh error:error];
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    }];
}

- (void)dealWithTop {
    if (isHeadRefresh) {
        [_topDataSource removeAllObjects];
        _headView.hidden = YES;
        _headView.frame = CGRectZero;
    }
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    [super emptyDataSet:scrollView didTapButton:button];
    [self refreshHeaderData];
}

- (void)tempDataSourceBlock:(NSMutableArray *)tempDataSource {
    NSUserDefaults *readingDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:tempDataSource];
    [readingDefaults setValue:data forKey:@"infoImportantNews"];
    [readingDefaults synchronize];
}

- (void)createTableView {
    _tableView = [UITableView addTableViewFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - NAV_HEIGHT - 40) style:UITableViewStyleGrouped delegate:self emptyDelegate:self superView:self.view];
    _tableView.sakura.separatorColor(CommonSpaceLineUnfullColor);
    _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

- (void)createHeadView {
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, scrollViewHeight)];
    _headView.sakura.backgroundColor(CommonListContentContentBackColor);
    _tableView.tableHeaderView = _headView;
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(15, 0, kScreenWidth - 30, scrollViewHeight)];
    [_headView addSubview:bottomView];
    _loopScrollView = [[LoopScrollView alloc]initWithFrame:CGRectMake(0, 0, bottomView.width, scrollViewHeight)];
    [bottomView addSubview:_loopScrollView];
    _loopScrollView.carouseScrollTimeInterval = 5.0f;//滚动间隔时间
    _loopScrollView.delegate = self;
    _loopScrollView.dataSource = self;

    _headView.hidden = YES;
    _headView.frame = CGRectZero;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _bottomDataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InfoImportantNewsTableViewCell *cell = [InfoImportantNewsTableViewCell infoImportantNewsTableViewCell:tableView];
    InfoImportantNewsModel *model = _bottomDataSource[indexPath.row];
    [cell.leftImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:ImageNamed(@"placeholderPicSmall") options:SDWebImageRetryFailed|SDWebImageAvoidAutoSetImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (error) {
            cell.leftImageView.image = ImageNamed(@"placeholderPicSmall");
        } else {
            CGRect rect = CGRectMake((image.size.width - SmallPicAspectRatio * image.size.height)/2, 0, SmallPicAspectRatio * image.size.height, image.size.height);
            image = [UIImage imageFromImage:image inRect:rect];
            cell.leftImageView.image = image;
        }

    }];
    cell.titleLabel.text = model.title;
    CGFloat titleHeight = [InfoCalculate caculateHeight:cell.titleLabel lineSpace:5 fontSize:17 row:2];
    cell.dateLabel.text = model.time;
    CGFloat topHeight = (120 - titleHeight - 13 - 10)/2.0;
    cell.titleLabel.frame = CGRectMake(cell.leftImageView.right + 12, topHeight, kScreenWidth - 15 - (cell.leftImageView.right + 12), titleHeight);
    cell.dateLabel.frame = CGRectMake(cell.titleLabel.left, cell.titleLabel.bottom + 10, cell.titleLabel.width, 13);
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    InfoImportantNewsModel *model = _bottomDataSource[indexPath.row];
    InfoDetailViewController *vc = [[InfoDetailViewController alloc]initWithType:InfoDetailTypeOrdinary newsNo:model.newsno newsType:@""];
    [self pushViewController:vc from:self trade:NO];
}

#pragma mark HomePageScrollViewDataSource
-(NSArray *)loopScroll:(LoopScrollView *)carouselView {
    return _topDataSource.mutableCopy;
}

-(UIView *)loopScroll:(LoopScrollView *)carouselView carouselFrame:(CGRect)frame data:(NSArray *)data viewForItemAtIndex:(NSInteger)index {
    InfoImportantNewsModel *model = data[index];
    UIView *view = [[UIView alloc]initWithFrame:frame];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, frame.size.width, 18)];
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.sakura.textColor(CommonListContentTextColor);
    titleLabel.text = model.title;
    [view addSubview:titleLabel];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, titleLabel.bottom + 10, frame.size.width, ScrollPicHeight)];
    imageView.contentMode = UIViewContentModeScaleToFill;
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:ImageNamed(@"placeholderPicBig") options:SDWebImageRetryFailed|SDWebImageAvoidAutoSetImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (error) {
            imageView.image = ImageNamed(@"placeholderPicBig");
        } else {
            CGRect rect = CGRectMake((image.size.width - BigPicAspectRatio * image.size.height)/2, 0, BigPicAspectRatio * image.size.height, image.size.height);
            image = [UIImage imageFromImage:image inRect:rect];
            imageView.image = image;
        }
        
    }];
    [view addSubview:imageView];
    return view;
}

-(void)drawImage:(UIImage *)image targetSize:(CGSize )size imageView:(UIImageView *)imageView {
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
        CGRect newRect = CGRectMake(0, 0, size.width, size.height);
        CGRectIntegral(newRect);
        UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
        CGAffineTransform transform = CGAffineTransformMake(1, 0, 0, -1, 0, size.height);
        CGContextConcatCTM(context, transform);
        CGContextSaveGState(context);
        CGContextDrawImage(context, newRect, image.CGImage);
        CGContextRestoreGState(context);
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        dispatch_async(dispatch_get_main_queue(), ^{
            if (newImage) {
                imageView.layer.contents = (id)(newImage.CGImage);
            }
        });
    });
}

#pragma mark LoopScrollViewDelegate
-(void)loopScroll:(LoopScrollView *)zzcarouselView didSelectItemAtIndex:(NSInteger)index {
    
    if ([@(zzcarouselView.coreView.contentOffset.x) integerValue] % [@(kScreenWidth - 30) integerValue] || index > 3) {
        return;
    }
    
    InfoImportantNewsModel *model = _topDataSource[index];
    InfoDetailViewController *vc = [[InfoDetailViewController alloc]initWithType:InfoDetailTypeOrdinary newsNo:model.newsno newsType:@""];
    [self pushViewController:vc from:self trade:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
