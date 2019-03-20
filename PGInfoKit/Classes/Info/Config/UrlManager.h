//
//  UrlManager.h
//  PanGu
//
//  Created by Security Pacific on 16/9/21.
//  Copyright © 2016年 Security Pacific Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, URL_SITE_TYPE) {
    URL_SITE_TYPE_KM,
    URL_SITE_TYPE_BJ,
};

@interface ConfigURL : NSObject

/* 这几个元素的值，在 AppDelegate 中进行赋值 */
@property (nonatomic, copy) NSString * _Nullable securityUrl_note;          // note Url
@property (nonatomic, copy) NSString * _Nullable securityUrl_httpServer;    // httpServer Url
@property (nonatomic, copy) NSString * _Nullable tradeUrl;                  // 交易 Url
@property (nonatomic, copy) NSString * _Nullable marketUrl;                 // 行情 Url
@property (nonatomic, copy) NSString * _Nullable infoUrl;                 //资讯，热卖 Url（考虑把行情和资讯，热卖这些服务分开）
//用户手动选择行情地址
@property (nonatomic, copy) NSString * _Nullable userQuoteUrl;
//用户手动选择交易地址
@property (nonatomic, copy) NSString * _Nullable userTradeUrl;
//用户手动选择资讯站点
@property (nonatomic, copy) NSString * _Nullable userInfoUrl;

@property (nonatomic,copy) NSString * _Nullable refreshTime;

// 埋点用
@property (nonatomic, copy) NSString *_Nullable classTypeStr;

+ (ConfigURL * _Nonnull)shareManager;

//保存用户手动设置的行情站点
- (void)saveUserQuoteUrl:(NSString* _Nonnull)url;

//保存用户手动设置的交易站点
- (void)saveUserTradeUrl:(NSString* _Nonnull)url;

//保存用户手动设置的资讯站点
- (void)saveUserInfoUrl:(NSString* _Nonnull)url;

//获取对应的的服务数组
- (NSArray* _Nonnull)getUrls:(NSString* _Nonnull)key;

//解析数据
- (BOOL)parseData:(NSDictionary* _Nonnull)dic;

@end

@interface UrlManager : NSObject

//获取交易接口
+(NSString *_Nonnull)getTransactionURL;

//获取消息推送的token
+(NSString *_Nonnull)getTransactionTokenURL;

//绑定
//+(NSString *)getTransactionURL1;

//获取行情接口
+(NSString *_Nonnull)getHangQingURL;

//获取验证码接口
+(NSString *_Nonnull)getIdentifyURL;

//获取新股接口
+(NSString *_Nonnull)getNewSharesURL;

//获取个股公告接口
+(NSString *_Nonnull)getSingleNewsURL;

//获取注册接口
+(NSString *_Nonnull)getRegisterURL;

//自选股新闻列表接口接口
+(NSString *_Nonnull)getOptionalStockNewsURL;

//通知服务器添加自选股
+(NSString *_Nonnull)addOptionalStockURL;

//资讯URL
+(NSString *_Nonnull)infosURL;

//分享URL
+(NSString *_Nonnull)shareURL;

//短信验证
+(NSString *_Nonnull)massagesURL;

//大数据
+(NSString *_Nonnull)bigDataURL;

//"我的"模块
+(NSString *_Nonnull)mineURL;

//后台请求是否使用明文
+(NSString *_Nonnull)passwoldURL;

//资产分析近期状况
+(NSString *_Nonnull)propertyAnalyseURL;
//资产结构拉取接口
+(NSString *_Nonnull)assetsGetURL;
//股市回忆录
+(NSString *_Nonnull)stockMemoirURL;
//股市月账单分享
+(NSString *_Nonnull)stockMonthBill;
//资产分析分享
+(NSString *_Nonnull)asstesAnalyseShare;
//交易记录分享
+(NSString *_Nonnull)tradeRecords;

//首页临时接口
+(NSString *_Nonnull)shouyelinshiUrl;
//金融生活
+(NSString *_Nonnull)financeLifeUrl;
//首页广告
+(NSString *_Nonnull)urlAd;
//博睿接口
+(NSString *_Nonnull)brUrl;
//热搜接口
+(NSString *_Nonnull)hotDataURL;


//安全注册接口
+(NSString *_Nonnull)getSecurityRegisterURL;
//语音验证码
+(NSString *_Nonnull)getVoiceMessageURL;
//安全语音验证码
+(NSString *_Nonnull)getSecurityVoiceMessageURL;
//安全短信验证接口
+(NSString *_Nonnull)getSecurityMessageURL;
//安全股市月账单分享
+(NSString *_Nonnull)getSecurityStockMonthBill;
//安全交易记录分享
+(NSString *_Nonnull)getSecurityTradeRecords;
//安全资产分析分享
+(NSString *_Nonnull)getSecurityAsstesAnalyseShare;
//安全绑定手机号
+(NSString *_Nonnull)getSecurityBindingTelURL;
//新股新债分享
+(NSString *_Nonnull)getIPOsShareURL;

//用户账户对应
+(NSString *_Nonnull)getUserAccountCorrespondingURL;
//基金定投
+(NSString *_Nonnull)investmentBuy;
//产品预约
+(NSString *_Nonnull)policyURL;

//短信验证码
+ (NSString *_Nonnull)getNewMessageURL;
//安全语音验证码
+ (NSString *_Nonnull)getNewVoiceMessageURL;
//短信验证码验证接口
+ (NSString *_Nonnull)getNewVerifyMessageURL;

//获取图片验证码
+(NSString *_Nonnull)getSecurityPicVerify;
//新发送短信验证码
+(NSString *_Nonnull)getSecurityNewMessageVerify;
//新发送语音验证码
+(NSString *_Nonnull)getSecurityNewVoiceVerify;
//短信验证码验证并注册
+(NSString *_Nonnull)getSecurityVerifyRegister;
//微信手机号绑定
+(NSString *_Nonnull)getSecurityWXBinding;

//****************************  新资讯  *****************************
//要闻
+(NSString *_Nonnull)getInfoImportantURL;
//直播
+(NSString *_Nonnull)getInfoStreamingURL;
//查询栏目信息列表
+(NSString *_Nonnull)getInfoHkstocksURL;
//信息详情
+(NSString *_Nonnull)getInfoDetailURL;
//栏目list
+(NSString *_Nonnull)getInfoClassListURL;
//股票相关新闻
+(NSString *_Nonnull)getInfoStockNewsURL;
//个股公告
+(NSString *_Nonnull)getStockNoticeURL;
// 个股近三个月机构研报
+ (NSString *_Nonnull)getStockRatingURL;
//个股港股公告
+(NSString *_Nonnull)getHKStockNoticeURL;
//个股研报
+(NSString *_Nonnull)getStockResearchURL;
//个股港股研报
+(NSString *_Nonnull)getHKStockResearchURL;
//个股概况接口
+(NSString *_Nonnull)shortBriefUrl;
//红珊瑚投顾观点列表
+(NSString *_Nonnull)getRedCoralURL;
//红珊瑚投顾观点详情
+(NSString *_Nonnull)getRedCoralInfoURL;
//太平洋证券研究（研报）列表
+(NSString *_Nonnull)getTPYResearchURL;
//太平洋证券研究（研报）详情
+(NSString *_Nonnull)getTPYResearchInfoURL;

//****************************  热卖(替换稳赢部分接口)  *****************************
//2017-09-05
//根据栏目获取产品列表
+(NSString *_Nonnull)getListForColumn;
//根据方案ID获取产品列表
+(NSString *_Nonnull)getListForSchema;
//(新)查询预约信息(是否可预约)
+(NSString *_Nonnull)getOrderPremise;
//查询是否具有购买资格
+(NSString *_Nonnull)checkBuyPremise;
//(新)记录产品预约信息
+(NSString *_Nonnull)addOrderRecord;
//(新)查询预约详情
+(NSString *_Nonnull)getOrderDetail;
//(新)查询附件列表
+(NSString *_Nonnull)getAttachments;
//三板股票相关公告
+(NSString *_Nonnull)getAnnouListForNQ;
//获取基金概况
+(NSString *_Nonnull)queryFundProfile;
//14天详情
+(NSString *_Nonnull)query14Pro;
// 股市月账单
+(NSString *_Nonnull)getStockMonthBill;

//三板公告研报详情
+(NSString *_Nonnull)getContentForNQ;

// 获取风险警示文件 URL
+ (NSString *_Nonnull)getRiskWarning;

//定投跳转基金详情
+(NSString *_Nonnull)queryProduct;

//查询两融余额（包括otherUrl）
+ (NSString *_Nonnull)getTwoRongBalance;

//旗舰店
+(NSString *_Nonnull)niuManager;

//14天理财附加信息
+(NSString *_Nonnull)queery14ProList;

//获取请求及ping的超时时间
+(NSString *_Nonnull)getTimeout;

//附近营业网点
+(NSString *_Nonnull)businessOutlets;

//免责条款
+(NSString *_Nonnull)getDisclaimerURL;

//隐私政策
+(NSString *_Nonnull)getPrivacyURL;

//获取港股行情
+(NSString *_Nonnull)getHKStocksURL;

//获取相似K线
+(NSString *_Nonnull)getSimilarURL;

//获取筹码分布
+(NSString *_Nonnull)getChipURL;

//获取市场监控
+(NSString *_Nonnull)getMonitorURL;

//获取短线精灵
+(NSString *_Nonnull)getShortelvesURL;

//获取异动精灵
+(NSString *_Nonnull)getSpiritURL;

//获取个股资金流水
+(NSString *_Nonnull)getCapitalflowURL;

//查询股票大事提醒信息
+(NSString *_Nonnull)getEventRemindURL;

//查询股票大事提醒详细信息
+(NSString *_Nonnull)getEventRemindDetailURL;

//查询股票龙虎榜信息
+(NSString *_Nonnull)getBillboardURL;

//查询股票大宗交易信息
+(NSString *_Nonnull)getBlockTradingURL;

// 新闻公告研报合并接口
+(NSString *_Nonnull)getMergeNewsURL;

// 新闻公告研报详情合并接口
+(NSString *_Nonnull)getMergeNewsDetailURL;

//理财商城URL
+(NSString *_Nonnull)getFinanceURL;

// 商城咨询
+(NSString *_Nonnull)getFinanceInfoURL;

//理财商城tradeURL
+(NSString *_Nonnull)getFinanceTradeURL;

// 商城导读固定URL
+ (NSString *_Nonnull)getMallTakeaway;

//自选股 - 新闻、公告、研报
+ (NSString *_Nonnull)getHQOptionalNewsURL;

//自选股 - 独家
+ (NSString *_Nonnull)getHQOptionalNewsOnlyURL;

//自选股 - 独家 -- 详情
+ (NSString *_Nonnull)getHQOptionalNewsOnlyDetailURL;

// 行情 -- 决策 - HTML
+ (NSString *_Nonnull)getHQPolicyHtmlUrl;

// 新版分享 URL
+ (NSString *_Nonnull)getShareURL;

//商城业务
+(NSString *_Nonnull)getFinanceYWURL;

@end
