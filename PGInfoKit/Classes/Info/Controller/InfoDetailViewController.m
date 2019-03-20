//
//  InfoDetailViewController.m
//  PanGu
//
//  Created by 张琦 on 2017/8/30.
//  Copyright © 2017年 Security Pacific Corporation. All rights reserved.
//

#import "InfoDetailViewController.h"
#import "InfoDetailTableViewCell.h"
#import "InfoCalculate.h"
#import "NetworkRequest.h"
#import "InfoStateTableViewCell.h"
#import "AccessoryTableViewCell.h"
#import "TradePDFController.h"
#import "WXLLabel.h"
#import "InfoDataManager.h"
#import "PGInfo.h"


@interface InfoDetailViewController ()<UITableViewDelegate,UITableViewDataSource,WKNavigationDelegate>
{
    NSInteger    fontAdd;//增加的字号值
    NSInteger   _clickCount;//控制只能点一次
}
@property (nonatomic, strong) UITableView *tableView;//列表

@property (nonatomic, strong) NSMutableArray *dataSource;//数据源

@property (nonatomic, strong) WKWebView *webView;//webView

@property (nonatomic, strong) NSMutableArray *attachmentDataSource;//附件

@property (nonatomic, assign) InfoDetailType type;//详情页类型

@property (nonatomic, strong) NSArray *listData;//列表数据源

@property (nonatomic, assign) NSInteger curIdx;//当前新闻

@property (nonatomic, copy) NSString *newsType;

@property (nonatomic, copy) NSString *newsNo;

@property (nonatomic, copy) NSString *relatedStock;


@end

@implementation InfoDetailViewController

#pragma mark  life cycle

- (instancetype)initWithType:(InfoDetailType)type newsNo:(NSString *)newsNo newsType:(NSString *)newsType  relatedStock:(NSString *)relatedStock {
    if (self = [super init]) {
        self.newsNo = newsNo;
        self.newsType = newsType;
        self.relatedStock = relatedStock;
        self.type = type;
        if (self.type == InfoDetailTypeOptionalOnly) {
            self.title = @"研报详情";
        }
    }
    return self;
}

- (instancetype)initWithType:(InfoDetailType)type newsNo:(NSString *)newsNo newsType:(NSString *)newsType {
    if (self = [super init]) {
        self.newsNo = newsNo;
        self.newsType = newsType;
        self.type = type;
        if (self.type == InfoDetailTypePacificInstitute) {
            self.title = @"研报详情";
        } else if (self.type == InfoDetailTypeInvestment) {
            self.title = @"投顾观点";
        } else if (self.type == InfoDetailTypeMallDigest) {
            self.title = @"简介";
        } else {
            self.title = @"新闻详情";
        }
    }
    return self;
}

- (instancetype)initWithType:(InfoDetailType)type newsNo:(NSString *)newsNo newsType:(NSString *)newsType curIdx:(NSInteger)curIdx listData:(NSArray *)listData {
    if (self = [super init]) {
        self.newsNo = newsNo;
        self.newsType = newsType;
        self.type = type;
        self.curIdx = curIdx;
        self.listData = listData;
        if (self.type == InfoDetailTypeInvestment) {
            self.title = @"投顾观点";
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _attachmentDataSource = @[].mutableCopy;
    _dataSource = @[].mutableCopy;
    _clickCount = 0;
    fontAdd = [[PanGuUserDefault objectForKey:@"infoFontAddSub"] integerValue];
    
    [self addRightBtTwoWithImage:@"market_share" secondImageName:fontAdd == 0 ? @"fontAdd" : @"fontSub"];
    
    _tableView = [UITableView addTableViewFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - NAV_HEIGHT) style:UITableViewStyleGrouped delegate:self emptyDelegate:self superView:self.view];

    [self refreshData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [PanGuUserDefault setValue:@(fontAdd) forKey:@"infoFontAddSub"];
}

#pragma mark  loadData
- (void)refreshData {
    _tableView.mj_header = [PanGuRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
    [_tableView.mj_header beginRefreshing];
}

- (void)requestData {
    
    uWeakSelf
    [InfoDataManager requestInfoDetailData:self.type newsNo:self.newsNo newsType:self.newsType responseBlock:^(EMPTY_TYPE emptyType, NSError * _Nonnull error, InfoNewsDetailModel * _Nonnull model) {
        [weakSelf.tableView.mj_header endRefreshing];
        if (error) {
            [weakSelf dealWithExp:emptyType error:error];
        } else {
            if (model) {
                if (weakSelf.type == InfoDetailTypeOptionalOnly) {
                    model.relatedStock = weakSelf.relatedStock;
                }
                weakSelf.dataSource = @[model].mutableCopy;
                weakSelf.attachmentDataSource = model.atachment.mutableCopy;
//                [weakSelf.webView loadHTMLString:model.content baseURL:nil];
                [weakSelf loadWebView:model.content];
                [weakSelf.tableView reloadData];
            } else {
                [weakSelf dealWithExp:emptyType error:nil];
            }
        }
        
    }];
}

#pragma mark  异常处理
- (void)dealWithExp:(EMPTY_TYPE)emptyType error:(NSError *)error {
    [_attachmentDataSource removeAllObjects];
    [self reloadPublicEmptyData:_dataSource emptyType:emptyType scrollView:_tableView isHeadRefresh:YES error:error];
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    [super emptyDataSet:scrollView didTapButton:button];
    [self refreshData];
}


#pragma mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.type == InfoDetailTypeInvestment && self.listData.count > 1 && _dataSource.count != 0) return 3;
    if (_dataSource.count != 0) return 2;
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        if (_dataSource.count != 0) return (self.type == InfoDetailTypeInvestment) ? 3 : 2;
    } else if (section == 1) {
        return _attachmentDataSource.count + 1;
    } else if (section == 2) {
        return self.curIdx == 0 || self.curIdx == self.listData.count - 1 ? 1 : 2;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InfoNewsDetailModel *model = _dataSource[0];
    if (indexPath.section == 0) {
        InfoDetailTableViewCell *cell = [InfoDetailTableViewCell infoDetailTableView:tableView reusableCellId:kString_Format(@"infoDetailCellId%ld%ld",indexPath.section,indexPath.row)];
        if (self.type == InfoDetailTypeInvestment) {
            if (indexPath.row == 0) {
                [cell configData:model fontAdd:fontAdd type:self.type];
            } else if (indexPath.row == 1) {
                [cell configDetailWithModel:model font:fontAdd type:self.type];//简介
                return cell;
            } else if (indexPath.row == 2) {
                if (_webView) [cell.contentView addSubview:_webView];
                return cell;
            }
        } else {
            if (indexPath.row == 0) {
                [cell configData:model fontAdd:fontAdd type:self.type];
            } else if (indexPath.row == 1) {
                if (_webView) [cell.contentView addSubview:_webView];
            }
        }
        return cell;
    } else if (indexPath.section == 1) {
        if (_attachmentDataSource.count == indexPath.row) {
            InfoStateTableViewCell *cell = [InfoStateTableViewCell infoStateTableView:tableView];
            [cell configData:model type:self.type];
            return cell;
        } else {
            AccessoryTableViewCell *cell = [AccessoryTableViewCell accessoryTableViewCell:tableView];
            InfoAttachmentModel *model = _attachmentDataSource[indexPath.row];
            [cell configData:model];
            cell.singleView.left = (indexPath.row == _attachmentDataSource.count - 1) ? 0 : 15;
            return cell;
        }
    } else if (indexPath.section == 2) {
        InfoDetailTableViewCell *cell = [InfoDetailTableViewCell infoDetailTableView:tableView reusableCellId:kString_Format(@"infoDetailSwitchCellId")];
        NSInteger idx = indexPath.row == 0 ? (self.curIdx == 0 ? (self.curIdx + 1) : (self.curIdx - 1)) : self.curIdx + 1;
        InfoReadingModel *model = self.listData[idx];
        BOOL isPre = indexPath.row == 0 && self.curIdx != 0;
        [cell configSwitchData:model isPre:isPre];
        cell.bottomLine.hidden = !isPre;
        return cell;
    }
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    InfoNewsDetailModel *model = _dataSource[0];
    if (indexPath.section == 0) {
        if (self.type == InfoDetailTypeInvestment) {
            if (indexPath.row == 0) {
                return model.titleHeight;
            } else if (indexPath.row == 1) {
                return model.contentHeight;
            } else {
                return _webView.frame.size.height + 20;
            }
        } else {
            if (indexPath.row == 0) {
                return model.titleHeight;
            } else {
                return _webView.frame.size.height + 20;
            }
        }
        
    } else if (indexPath.section == 1) {
        if (_attachmentDataSource.count == indexPath.row) {
            return model.stateHeight;
        }
        InfoAttachmentModel *model = _attachmentDataSource[indexPath.row];
        return model.height;
    } else if (indexPath.section == 2) {
        NSInteger idx = indexPath.row == 0 ? (self.curIdx == 0 ? (self.curIdx + 1) : (self.curIdx - 1)) : self.curIdx + 1;
        InfoReadingModel *model = self.listData[idx];
        return model.switchHeight;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (self.type == InfoDetailTypeInvestment && section == 2) {
        return [UIView adddView:CGRectMake(0, 0, kScreenWidth, 5) backColor:CommonGlobalBackColor superView:nil];
    }
    
    if (_attachmentDataSource.count == 0 ) return nil;
    if (section == 1) {
        WXLLabel *label = [[WXLLabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 45)];
        label.text = @"附件";
        label.font = [UIFont boldSystemFontOfSize:17];
        label.sakura.textColor(CommonListContentTextColor);
        label.sakura.backgroundColor(CommonListContentContentBackColor);
        label.textInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        [UIView adddView:CGRectMake(0, label.height - KSINGLELINE_WIDTH, kScreenWidth, KSINGLELINE_WIDTH) backColor:CommonSpaceLineUnfullColor superView:label];
        return label;
    }

    
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (self.type == InfoDetailTypeInvestment) return nil;
    return section == 0 && _attachmentDataSource.count != 0 ? [UIView adddView:CGRectMake(0, 0, kScreenWidth, 5) backColor:CommonGlobalBackColor superView:nil] : nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) return _attachmentDataSource.count == 0 ? 0.1 : 42;
    if (section == 2) return 5;
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (self.type == InfoDetailTypeInvestment) return 0.1;
    if (section == 0) return _attachmentDataSource.count == 0 ? 0.1 : 5;
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (_attachmentDataSource.count != indexPath.row) {
            TradePDFController *vc = [[TradePDFController alloc]init];
            InfoAttachmentModel *model = _attachmentDataSource[indexPath.row];
            vc.title = model.name;
            [vc reloadWithString:model.url];
            [self pushViewController:vc from:self trade:NO];
        }
    }
    
    if (indexPath.section == 2) {
        NSInteger idx = indexPath.row == 0 ? (self.curIdx == 0 ? (self.curIdx + 1) : (self.curIdx - 1)) : self.curIdx + 1;
        InfoReadingModel *model = self.listData[idx];
        //
        self.newsNo = model.newsno;
        self.newsType = @"3";
        //
        self.curIdx = idx;
        [self refreshData];
//        [self requestData];
    }
}

#pragma mark  WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSString *str = kString_Format(@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '%@'",[TXSakuraManager tx_stringWithPath:self.type == InfoDetailTypeInvestment ? CommonContentContentTextColor : CommonListContentTextColor]);
    [_webView evaluateJavaScript:str completionHandler:nil];
    
    if (fontAdd == 4) {
        NSString *jsString = @"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '130%'";
        [_webView evaluateJavaScript:jsString completionHandler:nil];
    }
}

#pragma mark  监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    _webView.height = _webView.scrollView.contentSize.height;
    [_tableView reloadData];
}

#pragma mark  click event
- (void)firstRightAction {
//    NSString *type = kString_Format(@"2%@", [self.newsType isEqualToString:@"1"] ? @"1" : @"");
//    NSString *infoClass = @"";
//    PanGuMallShareType shareType = PanGuMallShareTypeInfoDetail;
//    if (self.type == InfoDetailTypeDefault) {
//        infoClass = @"1";
//    }else if (self.type == InfoDetailTypeInvestment) {
//        infoClass = @"2";
//    }
//    if (self.type == InfoDetailTypeMallDigest || self.type == InfoDetailTypeMall) {
//        shareType = PanGuMallShareTypeMallInfoDetail;
//    }
//    [PanGuMallAlertManager alertShareWithType:shareType headerView:nil contentView:_tableView dismissBlock:nil parmrs:@[self.newsNo] entries:@{@"type": type, @"infoClass": infoClass}];


}

- (void)secondRightAction {
    fontAdd = fontAdd == 0 ? 4 : 0;
    [self addRightBtTwoWithImage:@"market_share" secondImageName:fontAdd == 0 ? @"fontAdd" : @"fontSub"];
    if (_dataSource.count > 0) {
        InfoNewsDetailModel *model = _dataSource[0];
        [self loadWebView:model.content];
    }
}

- (void)loadWebView:(NSString *)content {
    _webView.frame = CGRectMake(15, 0, kScreenWidth - 30, 0.1);
    [_webView removeObserver:self forKeyPath:@"scrollView.contentSize"];
    _webView = nil;
    [self.webView loadHTMLString:content baseURL:nil];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return nil;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (iOS10orLater && !iOS11orLater) {
        if (scrollView == self.tableView) {
            [self.webView setNeedsLayout];
        }
    }    
}

#pragma mark  lazy
- (WKWebView *)webView {
    if (!_webView) {
        NSString *jsStr = kString_Format(@"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=%f'); document.getElementsByTagName('head')[0].appendChild(meta);",kScreenWidth - 60);
        WKUserScript *userScript = [[WKUserScript alloc] initWithSource:jsStr injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        WKUserContentController *ucc = [[WKUserContentController alloc] init];
        [ucc addUserScript:userScript];
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        config.userContentController = ucc;
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth - 30, 0.1) configuration:config];
        _webView.navigationDelegate = self;
        _webView.scrollView.scrollEnabled = NO;
        _webView.scrollView.delegate = self;
        if (self.type == InfoDetailTypeInvestment) {
            _webView.sakura.backgroundColor(CommonContentContentBackColor);
        } else {
            _webView.sakura.backgroundColor(CommonListContentContentBackColor);
        }
        _webView.opaque = NO;
        [_webView addObserver:self forKeyPath:@"scrollView.contentSize" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _webView;
}

- (void)dealloc {
    [_webView removeObserver:self forKeyPath:@"scrollView.contentSize"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
