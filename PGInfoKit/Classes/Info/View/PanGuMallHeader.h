//
//  PanGuMallHeader.h
//  PanGu
//
//  Created by 祁继宇 on 2018/10/12.
//  Copyright © 2018 Security Pacific Corporation. All rights reserved.
//

#ifndef PanGuMallHeader_h
#define PanGuMallHeader_h

//* 理财商城 -- 理财类型 */
typedef NS_OPTIONS(NSUInteger, PanGuFinanceType) {
    
#pragma mark =========== ********* 理财 ******** ===========

    PanGuFinanceTypeNational = 1 << 0,    //国债理财
    PanGuFinanceTypeTaiPingYang = 1 << 1, //太平洋优选
    PanGuFinanceTypeBank = 1 << 2,        //银行理财
    PanGuFinanceTypeDemand = 1 << 3,      //活期理财
    PanGuFinanceTypeWise = 1 << 4,        //智选理财

#pragma mark =========== ********* 各类理财产品 ******** ===========

    PanGuFinanceTypeFundFirst = 1 << 5,       //首发基金
    PanGuFinanceTypeFundTodayHot = 1 << 6,    //今日最热
    PanGuFinanceTypeFundJiXuan = 1 << 7,      //精选基金
    
#pragma mark =========== ********* 基金排行 ******** ===========

    PanGuFinanceTypeFundFilter = 1 << 8,   //基金排行 -- 基金筛选页面(单页面)
    
    PanGuFinanceTypeFundSortStock = 1 << 9,    //基金排行 -- 股票型
    PanGuFinanceTypeFundSortMixed = 1 << 10,   //基金排行 -- 混合型
    PanGuFinanceTypeFundSortDebt = 1 << 11,    //基金排行 -- 债券型
    PanGuFinanceTypeFundSortMoney = 1 << 12,   //基金排行 -- 货币型
    PanGuFinanceTypeFundSortIndex = 1 << 13,   //基金排行 -- 指数型
    PanGuFinanceTypeFundSortQD = 1 << 14,      //基金排行 -- QD型
    PanGuFinanceTypeFundSortLOF = 1 << 15,     //基金排行 -- LOF型
    PanGuFinanceTypeFundSortFOF = 1 << 16,     //基金排行 -- FOF型

#pragma mark =========== ********* 基金定投 ******** ===========
    
    PanGuFinanceTypeFundFixInvest = 1 << 17,            //基金定投（页面类型）
    
    PanGuFinanceTypeFundFixInvestRecommend = 1 << 18,   //基金定投 -- 推荐定投基金
    PanGuFinanceTypeFundFixInvestAvailable = 1 << 19,   //基金定投 -- 可定投基金
    
#pragma mark =========== ********* 理财头条 ******** ===========
    
    PanGuFinanceTypeFinanceHeadlineJiJinZiXun = 1 << 20,   //理财头条 -- 基金资讯
    PanGuFinanceTypeFinanceHeadlineInvestSkill = 1 << 21,  //理财头条 -- 投资技巧
    PanGuFinanceTypeFinanceHeadlineSchool = 1 << 22,       //理财头条 -- 理财学堂
    PanGuFinanceTypeFinanceHeadlineLatest = 1 << 23,       //理财头条 -- 最新
    
#pragma mark =========== ********* 主题投资 ******** ===========
    
    PanGuFinanceTypeTopicDetail = 1 << 24,          //主题投资详情
    PanGuFinanceTypeFinanceCalender = 1 << 25,      //理财日历
    PanGuFinanceTypeFinanceFundHome = 1 << 26,      //基金首页--基金排行

    PanGuFinanceTypeNone = 1 << 60 // 其他类型
};

// 基金首页
typedef NS_OPTIONS(NSUInteger, PanGuMallFundType) {
    PanGuMallFundEntranceType,      //入口
    PanGuMallFundFiltrateType,      //找基金
    PanGuMallFundTipType            //提示
};

typedef NS_ENUM(NSUInteger, PanGuMallShareType) {
    PanGuMallShareTypeFinancialDetail,      // 理财详情
    PanGuMallShareTypeThemeDetail,          // 主题详情
    PanGuMallShareTypeMallInfoDetail,       // 理财资讯详情
    PanGuMallShareTypeInfoDetail,           // 资讯详情
    PanGuMallShareTypeFocusThemeDetail,     // 关注主题详情
    PanGuMallShareTypeFocusProductDetail,   // 关注产品详情
    PanGuMallShareTypeCalendar,             // 理财日历
    PanGuMallShareTypeStockDetail,          // 个股详情
    PanGuMallShareTypeOptionalStock,        // 自选股
    PanGuMallShareTypeInvestmentEdu,        // WKWVViewController 小贴士用的资讯详情页分享
    
    PanGuShareTypeInfoVideo,                // 视频讲堂
};

typedef NS_ENUM(NSUInteger, PanGuMallFocusType) {
    PanGuMallFocusManagerType = 1,   //理财
    PanGuMallFocusThemeType          //主题
};

// 搜索列表类型
typedef NS_ENUM(NSUInteger, PanGuSearchListType) {
    PanGuSearchListTypeAll,      //全部
    PanGuSearchListTypeHuShen,   //沪深
    PanGuSearchListTypeHK,       //港股
    PanGuSearchListTypeFinance,  //理财
    PanGuSearchListTypeFund      //基金
};

//* 预约产品倒计时通知 */
static NSString *const kPanGuMallYuYueProductTimeDownNotification = @"PanGuMallYuYueProductTimeDownNotification";

//* 理财列表每页请求条数 */
#define PanGuMallListPageSize 20

#endif /* PanGuMallHeader_h */
