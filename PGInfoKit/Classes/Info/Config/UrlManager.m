//
//  UrlManager.m
//  PanGu
//
//  Created by Security Pacific on 16/9/21.
//  Copyright © 2016年 Security Pacific Corporation. All rights reserved.
//

#import "UrlManager.h"

@interface ConfigURL()
{
    //数据
    NSMutableDictionary *datas;
}
@end

@implementation ConfigURL

static ConfigURL *_configUrl;

+ (ConfigURL *)shareManager {
    static ConfigURL *configUrl;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        configUrl = [[ConfigURL alloc] init];
    });
    return configUrl;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_configUrl)
            _configUrl = [super allocWithZone:zone];
    });
    return _configUrl;
}

- (void)saveUserQuoteUrl:(NSString *)url
{
    if (url.length > 0) {
        _userQuoteUrl = url;
        _marketUrl = _userQuoteUrl;
        [datas setValue:_userQuoteUrl forKey:@"userQuoteUrl"];
        [PanGuUserDefault setObject:datas forKey:@"defaulturlData"];
        [PanGuUserDefault synchronize];
    }else{
        _userQuoteUrl = url;
        _marketUrl = [self getUrl:0 forKey:@"hq"];
        [datas setValue:_userQuoteUrl forKey:@"userQuoteUrl"];
        [PanGuUserDefault setObject:datas forKey:@"defaulturlData"];
        [PanGuUserDefault synchronize];
    }
}

- (void)saveUserTradeUrl:(NSString*)url
{
    if (url.length > 0) {
        _userTradeUrl = url;
        _tradeUrl = _userTradeUrl;
        [datas setValue:_userTradeUrl forKey:@"userTradeUrl"];
        [PanGuUserDefault setObject:datas forKey:@"defaulturlData"];
        [PanGuUserDefault synchronize];
    }else{
        _userTradeUrl = url;
        _tradeUrl = [self getUrl:0 forKey:@"trade"];
        [datas setValue:_userTradeUrl forKey:@"userTradeUrl"];
        [PanGuUserDefault setObject:datas forKey:@"defaulturlData"];
        [PanGuUserDefault synchronize];
    }
}

- (void)saveUserInfoUrl:(NSString *)url
{
    if (url.length > 0) {
        _userInfoUrl = url;
        _infoUrl = _userInfoUrl;
        [datas setValue:_userInfoUrl forKey:@"userInfoUrl"];
        [PanGuUserDefault setObject:datas forKey:@"defaulturlData"];
        [PanGuUserDefault synchronize];
    }else{
        _userInfoUrl = url;
        _infoUrl = [self getUrl:0 forKey:@"info"];
        [datas setValue:_userInfoUrl forKey:@"userInfoUrl"];
        [PanGuUserDefault setObject:datas forKey:@"defaulturlData"];
        [PanGuUserDefault synchronize];
    }
}

- (NSArray*)getUrls:(NSString* _Nonnull)key
{
    NSMutableArray *urls = @[].mutableCopy;
    if (key.length > 0) {
        urls = datas[key];
    }
    return urls;
}

- (id)init
{
    self = [super init];
    if (self) {
        datas = @{}.mutableCopy;
        _userTradeUrl = @"";
        _userQuoteUrl = @"";
        _userInfoUrl = @"";
        _marketUrl = @"";
        _tradeUrl = @"";
        _infoUrl = @"";
        _securityUrl_note = @"";
        _securityUrl_httpServer = @"";
        _refreshTime = @"";
        _classTypeStr = @"";
        NSString *requestStr = [PanGuUserDefault objectForKey:REQUEST_TIMEOUT];
        NSString *pingStr = [PanGuUserDefault objectForKey:PING_TIMEOUT];
        if ([ToolHelper isBlankString:requestStr]) {
            [PanGuUserDefault setValue:@"5" forKey:REQUEST_TIMEOUT];
        }
        if ([ToolHelper isBlankString:pingStr]) {
            [PanGuUserDefault setValue:@"2" forKey:PING_TIMEOUT];
        }
        [PanGuUserDefault synchronize];
        [self readData];
    }
    return self;
}

- (void)readData
{
    NSDictionary *dic = [PanGuUserDefault objectForKey:@"defaulturlData"];
    if (dic && [dic isKindOfClass:[NSDictionary class]]) {
        datas = dic.mutableCopy;
        //行情
        _userQuoteUrl = [ToolHelper getJSONString:datas withKey:@"userQuoteUrl"];
        if (_userQuoteUrl.length > 0) {
            _marketUrl = _userQuoteUrl;
        }else{
            //如果用户没有手动设置行情，就用默认行情
            _marketUrl = [ToolHelper getJSONString:datas withKey:@"quoteUrl"];
        }
        //交易
        _userTradeUrl = [ToolHelper getJSONString:datas withKey:@"userTradeUrl"];
        if (_userTradeUrl.length > 0) {
            _tradeUrl = _userTradeUrl;
        }else{
            //如果用户没有手动设置交易，就用默认交易
            _tradeUrl = [ToolHelper getJSONString:datas withKey:@"tradeUrl"];
        }
        //资讯
        _userInfoUrl = [ToolHelper getJSONString:datas withKey:@"userInfoUrl"];
        if (_userInfoUrl.length > 0) {
            _infoUrl = _userInfoUrl;
        }else{
            //如果用户没有手动设置行情，就用默认行情
            _infoUrl = [ToolHelper isBlankString:[ToolHelper getJSONString:datas withKey:@"infoUrl"]] ? [self getUrl:0 forKey:@"info"] : [ToolHelper getJSONString:datas withKey:@"infoUrl"];
            //兼容旧版本
        }
        _securityUrl_note = [ToolHelper getJSONString:datas withKey:@"register-note"];
        _securityUrl_httpServer = [ToolHelper getJSONString:datas withKey:@"register-httpServer"];
        //获取更新时间
        _refreshTime = [ToolHelper getJSONString:datas withKey:@"refreshTime"];
        //设置请求时间和超时时间
        NSString *requestStr = [ToolHelper getJSONString:datas withKey:@"net_time"];
        NSString *pingStr = [ToolHelper getJSONString:datas withKey:@"ping_time"];
        if (![ToolHelper isBlankString:requestStr]) {
            [PanGuUserDefault setValue:requestStr forKey:REQUEST_TIMEOUT];
        }
        if (![ToolHelper isBlankString:pingStr]) {
            [PanGuUserDefault setValue:pingStr forKey:PING_TIMEOUT];
        }
        [PanGuUserDefault synchronize];
    }else{
        //没有填充默认值
        NSString *string = [[NSBundle mainBundle] pathForResource:@"defaulturl" ofType:@"txt"];
        NSData *data = [NSData dataWithContentsOfFile:string];
        NSDictionary *d = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (d && [d isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dd = d[@"data"];
            if (dd && [dd isKindOfClass:[NSDictionary class]]) {
                //校验数据（只需校验行情地址，因为涉及地址服务器）
                NSArray *array = dd[@"hq"];
                if (array && [array isKindOfClass:[NSArray class]] && array.count > 0) {
                    [self saveData:dd updateTime:NO];
                    [self readData];
                }
                
            }
        }
    }
}

- (void)saveData:(NSDictionary*)dic updateTime:(BOOL)isUpdateTime
{
    datas = dic.mutableCopy;
    [datas setObject:[self getUrl:0 forKey:@"hq"] forKey:@"quoteUrl"];
    [datas setObject:[self getUrl:0 forKey:@"trade"] forKey:@"tradeUrl"];
    [datas setObject:[self getUrl:0 forKey:@"info"] forKey:@"infoUrl"];
    [datas setObject:_userQuoteUrl forKey:@"userQuoteUrl"];
    [datas setObject:_userTradeUrl forKey:@"userTradeUrl"];
    [datas setObject:_userInfoUrl forKey:@"userInfoUrl"];
    
    //判断手动设置行情是否还存在
    if (_userQuoteUrl.length > 0) {
        __block BOOL isExist = NO;
        NSArray *quoteUrls = [self getUrls:@"hq"];
        [quoteUrls enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger index, BOOL *stop){
            if ([_userQuoteUrl isEqualToString:obj[@"url"]]) {
                isExist = YES;
            }
        }];
        if (!isExist) {//如果不存在清空手动设置
            _userQuoteUrl = @"";
            [datas setObject:_userQuoteUrl forKey:@"userQuoteUrl"];
        }
    }
    //判断手动设置交易是否还存在
    if (_userTradeUrl.length > 0) {
        __block BOOL isExist = NO;
        NSArray *tradeUrls = [self getUrls:@"trade"];
        [tradeUrls enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger index, BOOL *stop){
            if ([_userTradeUrl isEqualToString:obj[@"url"]]) {
                isExist = YES;
            }
        }];
        if (!isExist) {//如果不存在清空手动设置
            _userTradeUrl = @"";
            [datas setObject:_userTradeUrl forKey:@"userTradeUrl"];
        }
    }
    //判断手动设置资讯是否还存在
    if (_userInfoUrl.length > 0) {
        __block BOOL isExist = NO;
        NSArray *infoUrls = [self getUrls:@"info"];
        [infoUrls enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger index, BOOL *stop){
            if ([_userInfoUrl isEqualToString:obj[@"url"]]) {
                isExist = YES;
            }
        }];
        if (!isExist) {//如果不存在清空手动设置
            _userInfoUrl = @"";
            [datas setObject:_userInfoUrl forKey:@"userTradeUrl"];
        }
    }
    //获取时间
    if (isUpdateTime) {
        _refreshTime = [ToolHelper getNowDate:yyyy_MM_dd];
        [datas setValue:_refreshTime forKey:@"refreshTime"];
    }
    [PanGuUserDefault setObject:datas forKey:@"defaulturlData"];
    [PanGuUserDefault synchronize];
}

- (NSString*)getUrl:(NSInteger)index forKey:(NSString*)key
{
    NSString *url = @"";
    if (index < 0) {
        return url;
    }
    NSArray *array = datas[key];
    if (array && [array isKindOfClass:[NSArray class]] && array.count > index) {
        NSDictionary *dic = array[index];
        url = dic[@"url"];
    }
    return url;
}

- (BOOL)parseData:(NSDictionary*)dic
{
    BOOL isSuccess = NO;
    NSString *code = [ToolHelper getJSONString:dic withKey:@"code"];
    if (code.length > 0 && [code isEqualToString:@"0"]) {//成功
        NSDictionary *dd = dic[@"data"];
        if (dd && [dd isKindOfClass:[NSDictionary class]]) {
            NSArray *array = dd[@"hq"];
            if (array && [array isKindOfClass:[NSArray class]] && array.count > 0) {
                isSuccess = YES;
                [self saveData:dd updateTime:YES];
                [self readData];
            }
        }
        
    }
    return isSuccess;
}

@end

@implementation UrlManager

/**************************** httpserver *******************************/

//交易

//获取交易接口
+(NSString *)getTransactionURL{
    
    //    return @"http://192.168.0.91:8080/HTTPServer/servlet";
    return [[[ConfigURL shareManager] tradeUrl] stringByAppendingString:@"/HTTPServer/servlet"];
}

//获取交易接口
+(NSString *)getTransactionTokenURL{
    
    return [[[ConfigURL shareManager] tradeUrl] stringByAppendingString:@"/HTTPServer/token/"];
}

//获取行情指数接口
+(NSString *)getHangQingIndex{
    
    return [[[ConfigURL shareManager] marketUrl] stringByAppendingString:@"/hqserver/http/newGet"];
}


//行情
//获取新股接口
+(NSString *)getNewSharesURL{
    return [[[ConfigURL shareManager] securityUrl_httpServer] stringByAppendingString:@"/HTTPServer/servlet"];
}

//获取个股公告接口
+(NSString *)getSingleNewsURL{
    return [[[ConfigURL shareManager] securityUrl_httpServer] stringByAppendingString:@"/HTTPServer/servlet"];
}

//获取注册接口
+(NSString *)getRegisterURL{
    
    return [[[ConfigURL shareManager] securityUrl_httpServer] stringByAppendingString:@"/HTTPServer/servlet"];
}

//通知服务器添加自选股 OptionalServerUrl
+(NSString *)addOptionalStockURL{
    //    return @"http://192.168.0.91:8082/HTTPServer/servlet";
    return [[[ConfigURL shareManager] securityUrl_httpServer] stringByAppendingString:@"/HTTPServer/servlet"];
}

//"我的"模块
+(NSString *)mineURL {
    return [[[ConfigURL shareManager] securityUrl_httpServer] stringByAppendingString:@"/HTTPServer/servlet"];
}
//后台请求是否使用明文
+(NSString *)passwoldURL {
    
    return [[[ConfigURL shareManager] securityUrl_httpServer] stringByAppendingString:@"/HTTPServer/servlet"];
}

//首页临时接口 查询基金产品下的公告和协议
+(NSString *)shouyelinshiUrl{
    
    return [[[ConfigURL shareManager] securityUrl_httpServer] stringByAppendingString:@"/HTTPServer/servlet"];
}

//用户账户对应 暂时没用
+(NSString *)getUserAccountCorrespondingURL {
    return [[[ConfigURL shareManager] securityUrl_httpServer] stringByAppendingString:@"/HTTPServer/servlet"];
}

//首页广告 暂时没用
+(NSString *)urlAd{
    return [[[ConfigURL shareManager] securityUrl_httpServer] stringByAppendingString:@"/HTTPServer/servlet"];
}

//安全注册接口
+(NSString *)getSecurityRegisterURL{
    
    return [[[ConfigURL shareManager] securityUrl_httpServer] stringByAppendingString:@"/HTTPServer/servlet"];
}

//安全绑定手机号
+(NSString *)getSecurityBindingTelURL {
    return [[[ConfigURL shareManager] securityUrl_httpServer] stringByAppendingString:@"/HTTPServer/servlet"];
}


//新股新债分享
+(NSString *)getIPOsShareURL {
    return [[[ConfigURL shareManager] infoUrl] stringByAppendingString:@"/hostsale/newStocks_today/html/newStocks_today.html"];
}


/******************************* note *********************************/

//安全短信验证码
+ (NSString *)getNewMessageURL {
    return [[[ConfigURL shareManager] securityUrl_note] stringByAppendingString:@"/note/send"];
}

//安全语音验证码
+ (NSString *)getNewVoiceMessageURL {
    return [[[ConfigURL shareManager] securityUrl_note] stringByAppendingString:@"/note/sendVoice"];
}

//安全短信验证码验证接口
+ (NSString *)getNewVerifyMessageURL {
    return [[[ConfigURL shareManager] securityUrl_note] stringByAppendingString:@"/note/auth"];
}

//获取图片验证码
+(NSString *)getSecurityPicVerify{
    return [[[ConfigURL shareManager] securityUrl_note] stringByAppendingString:@"/note/getImage"];
}

//新发送短信验证码
+(NSString *)getSecurityNewMessageVerify{
    return [[[ConfigURL shareManager] securityUrl_note] stringByAppendingString:@"/note/imgAuthSmsNew"];
}

//新发送语音验证码
+(NSString *)getSecurityNewVoiceVerify{
    return [[[ConfigURL shareManager] securityUrl_note] stringByAppendingString:@"/note/imgAuthVoiceNew"];
}

//新注册
+(NSString *)getSecurityVerifyRegister{
    return [[[ConfigURL shareManager] securityUrl_note] stringByAppendingString:@"/note/authAndRegister"];
}

//微信手机号绑定
+(NSString *)getSecurityWXBinding{
    return [[[ConfigURL shareManager] securityUrl_note] stringByAppendingString:@"/note/WXBinding"];
}

/******************************* hqserver *********************************/
//获取行情接口
+(NSString *)getHangQingURL{
    //    return @"http://192.168.0.91:8082/hqserver/http/newGet";
    return [[[ConfigURL shareManager] marketUrl] stringByAppendingString:@"/hqserver/http/newGet"];
    
}

/******************************* trade *********************************/
//获取验证码接口
+(NSString *)getIdentifyURL{
    
    return [[[ConfigURL shareManager] tradeUrl] stringByAppendingString:@"/unikeyAuth/ImageServlet"];
}

/*****************************************************************/

//自选股新闻列表接口接口
+(NSString *)getOptionalStockNewsURL{
    return [[[ConfigURL shareManager] infoUrl] stringByAppendingString:@"/webapp/action"];
    //    return [URL stringByAppendingString:@"/Bigdata/bighttp"];
}

//个股概况接口
+(NSString *)shortBriefUrl{
    return [[[ConfigURL shareManager] infoUrl] stringByAppendingString:@"/HTTPServer/servlet"];
}

//资讯URL
+(NSString *)infosURL{
    
    //    return [URL stringByAppendingString:@"/Bigdata/bighttp"];
    return [[[ConfigURL shareManager] infoUrl] stringByAppendingString:@"/webapp/action"];
    
    
}

//分享URL
+(NSString *)shareURL{
    
    return [[[ConfigURL shareManager] infoUrl] stringByAppendingString:@"/Bigdata/bighttp"];
}

//短信验证
+(NSString *)massagesURL{
    
    return [[[ConfigURL shareManager] infoUrl] stringByAppendingString:@"/Bigdata/bighttp"];
}

//大数据
+(NSString *)bigDataURL{
    
    return [[[ConfigURL shareManager] infoUrl] stringByAppendingString:@"/Bigdata/bighttp"];
}

//热搜接口
+(NSString *)hotDataURL{
    
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/webapp/bigAction"];
}



//股市回忆录
+(NSString *)stockMemoirURL{
    
    return [[[ConfigURL shareManager] infoUrl] stringByAppendingString:@"/Bigdata/bighttp"];
}
//资产分析近期状况
+(NSString *)propertyAnalyseURL{
    
    return [[[ConfigURL shareManager] infoUrl] stringByAppendingString:@"/Bigdata/bighttp"];
}
//资产结构拉取接口
+(NSString *)assetsGetURL{
    
    return [[[ConfigURL shareManager] infoUrl] stringByAppendingString:@"/Bigdata/bighttp"];
}

//股市月账单分享
+(NSString *)stockMonthBill{
    
    return [[[ConfigURL shareManager] infoUrl] stringByAppendingString:@"/Bigdata/bighttp"];
}
//交易记录分享
+(NSString *)tradeRecords{
    
    return [[[ConfigURL shareManager] infoUrl] stringByAppendingString:@"/Bigdata/bighttp"];
}
//资产分析分享
+(NSString *)asstesAnalyseShare{
    
    return [[[ConfigURL shareManager] infoUrl] stringByAppendingString:@"/Bigdata/bighttp"];
}

//基金定投
+(NSString *)investmentBuy{
    
    return [ConfigURL.shareManager.tradeUrl stringByAppendingString:@"/HTTPServer/servlet"];
}

//金融生活
+(NSString *)financeLifeUrl{
    
    return [[[ConfigURL shareManager] infoUrl] stringByAppendingString:@"/Bigdata/bighttp"];
}



//稳赢预约
+(NSString *)getVoiceMessageURL {
    return [[[ConfigURL shareManager] infoUrl] stringByAppendingString:@"/webapp/action"];
}

//产品预约
+(NSString *)policyURL{
    
    //    return [URL stringByAppendingString:@"/Bigdata/bighttp"];
    return [[[ConfigURL shareManager] infoUrl] stringByAppendingString:@"/webapp/action"];
}

// 股市月账单
+(NSString *)getStockMonthBill{
    
    return [[[ConfigURL shareManager] infoUrl] stringByAppendingString:@"/Bigdata/bighttp"];
}

//安全股市月账单分享
+(NSString *)getSecurityStockMonthBill{
    
    return [[[ConfigURL shareManager] infoUrl] stringByAppendingString:@"/Bigdata/bighttp"];
}

//安全交易记录分享
+(NSString *)getSecurityTradeRecords{
    
    return [[[ConfigURL shareManager] infoUrl] stringByAppendingString:@"/Bigdata/bighttp"];
}

//安全资产分析分享
+(NSString *)getSecurityAsstesAnalyseShare{
    
    return [[[ConfigURL shareManager] infoUrl] stringByAppendingString:@"/Bigdata/bighttp"];
}

//短信验证接口
+(NSString *)getSecurityMessageURL{
    
    return [[[ConfigURL shareManager] infoUrl] stringByAppendingString:@"/Bigdata/bighttp"];
}

//安全语音验证码(old)
+(NSString *)getSecurityVoiceMessageURL {
    return [[[ConfigURL shareManager] infoUrl] stringByAppendingString:@"/webapp/action"];//(语音验证码暂时换为 http )
}

//****************************  新资讯  *****************************

//要闻
+(NSString *)getInfoImportantURL {
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/news/important"];
}

//直播
+(NSString *)getInfoStreamingURL {
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/news/streaming"];
}

//查询栏目信息列表
+(NSString *)getInfoHkstocksURL {
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/news/hkstocks"];
}

//信息详情
+(NSString *)getInfoDetailURL {
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/news/detail"];
}

//栏目list
+(NSString *)getInfoClassListURL {
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/news/classlist?flag=new"];
}

//股票相关新闻
+(NSString *)getInfoStockNewsURL {
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/news/stockNews"];
}

//个股公告
+(NSString *)getStockNoticeURL {
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/news/getStockNotice"];
}

// 个股近三个月机构研报
+ (NSString *)getStockRatingURL {
    //    return @"https://dev-tnhq.tpyzq.com:8081/news/getStockRating";
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/news/getStockRating"];
}

//个股港股公告
+(NSString *)getHKStockNoticeURL {
    //    return @"https://dev-tnhq.tpyzq.com:8081/news/getHKStockNotice";
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/news/getHKStockNotice"];
}

//个股研报
+(NSString *)getStockResearchURL {
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/news/getStockResearch"];
}

//个股港股研报
+(NSString *)getHKStockResearchURL {
    //    return @"https://dev-tnhq.tpyzq.com:8081/news/getHKStockResearch";
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/news/getHKStockResearch"];
}

//红珊瑚投顾观点列表
+(NSString *)getRedCoralURL {
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/news/getRedCoral"];
}

//红珊瑚投顾观点详情
+(NSString *)getRedCoralInfoURL {
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/news/getRedCoralInfo"];
}

//太平洋证券研究（研报）列表
+(NSString *)getTPYResearchURL {
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/news/getTPYResearch"];
}

//太平洋证券研究（研报）详情
+(NSString *)getTPYResearchInfoURL {
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/news/getTPYResearchInfo"];
}

//****************************  热卖(替换稳赢部分接口)  *****************************
//2017-09-05
//根据栏目获取产品列表
//2018-12-18 李雄说改成这个, 目前只有首页在用
+(NSString *_Nonnull)getListForColumn {
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/hot/getListForColumn"];
}
//根据方案ID获取产品列表
+(NSString *_Nonnull)getListForSchema {
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/lcsc/hot/getListForSchema"];
}
//(新)查询预约信息(是否可预约)
+(NSString *_Nonnull)getOrderPremise {
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/lcsc/hot/getOrderPremise"];
}
//查询是否具有购买资格
+(NSString *_Nonnull)checkBuyPremise {
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/lcsc/hot/checkBuyPremise"];
}
//(新)记录产品预约信息
+(NSString *_Nonnull)addOrderRecord {
    return [ConfigURL.shareManager.securityUrl_httpServer stringByAppendingString:@"/lcsc/hot/addOrderRecord"];
}
//(新)查询预约详情
+(NSString *_Nonnull)getOrderDetail {
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/lcsc/hot/getOrderDetail"];
}
//(新)查询附件列表
+(NSString *_Nonnull)getAttachments {
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/lcsc/hot/getAttachments"];
}

//三板股票相关公告
+(NSString *_Nonnull)getAnnouListForNQ {
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/news/getAnnouListForNQ"];
}

//(新)获取基金概况
+(NSString *_Nonnull)queryFundProfile {
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/lcsc/hot/queryFundProfile"];
}

//14天详情
+(NSString *_Nonnull)query14Pro {
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/lcsc/hot/query14Pro"];
}

//三板公告研报详情
+(NSString *_Nonnull)getContentForNQ {
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/news/getContentForNQ"];
}

// 获取风险警示文件 URL
+ (NSString *_Nonnull)getRiskWarning {
    return [ConfigURL.shareManager.tradeUrl stringByAppendingString:@"/HTTPServer/"];
}

//定投跳转基金详情
+(NSString *_Nonnull)queryProduct {
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/lcsc/hot/queryProduct"];
}

//查询两融余额
+ (NSString *_Nonnull)getTwoRongBalance {
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/HTTPServer/servlet"];
}

//旗舰店
+(NSString *_Nonnull)niuManager {
    return @"https://bj-kp.tpyzq.com/h5-fans-pse/#/";
}

//14天
+(NSString *_Nonnull)queery14ProList
{
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/lcsc/hot/query14ProList"];
}

//获取请求及ping的超时时间
+(NSString *_Nonnull)getTimeout
{
    return [ConfigURL.shareManager.marketUrl stringByAppendingString:@"/HTTPServer/NetServlet"];
}

+(NSString *_Nonnull)businessOutlets
{
    return @"http://wxinfo.tpyzq.com:8081/weixinvii/ac/NetWorkOldSvl_ForTN?";
}

+(NSString *_Nonnull)getDisclaimerURL
{
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/APPMAP/mianzetiaokuan.html"];
}

+(NSString *_Nonnull)getPrivacyURL
{
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/APPMAP/yinsizhengce.html"];
}

//获取港股行情
+(NSString *_Nonnull)getHKStocksURL {
    //    return @"https://dev-tnhq.tpyzq.com:8081/HKService/http/newGet";
    //    return @"http://192.168.0.91:8082/HKService/http/newGet";
    return [ConfigURL.shareManager.marketUrl stringByAppendingString:@"/hkhqserver/http/newGet"];
}

+(NSString *_Nonnull)getSimilarURL
{
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/APPMAP/forwardPage.html?type_tpy=xskx"];
}

+(NSString *_Nonnull)getChipURL
{
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/APPMAP/forwardPage.html?type_tpy=cmfb"];
}

+(NSString *_Nonnull)getMonitorURL
{
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/APPMAP/forwardPage.html?type_tpy=scjk"];
}

+(NSString *_Nonnull)getShortelvesURL
{
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/APPMAP/forwardPage.html?type_tpy=dxjl"];
}

+(NSString *_Nonnull)getSpiritURL
{
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/APPMAP/forwardPage.html?type_tpy=ydjl"];
}

+(NSString *_Nonnull)getCapitalflowURL
{
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/APPMAP/forwardPage.html"];
}

//查询股票大事提醒信息
+(NSString *_Nonnull)getEventRemindURL {
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/greatEvent/eventList"];
}

//查询股票大事提醒详细信息
+(NSString *_Nonnull)getEventRemindDetailURL {
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/greatEvent/eventInfo"];
}

//查询股票龙虎榜信息
+(NSString *_Nonnull)getBillboardURL {
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/newQuery/fund/chart"];
}

//查询股票大宗交易信息
+(NSString *_Nonnull)getBlockTradingURL {
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/newQuery/fund/blockTrade"];
}

// 新闻公告研报合并接口
+(NSString *_Nonnull)getMergeNewsURL {
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/news/getInfoListNew"];
}

// 新闻公告研报详情合并接口
+(NSString *_Nonnull)getMergeNewsDetailURL {
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/news/getDetailInfoNew"];
}

//理财商城URL
+(NSString *_Nonnull)getFinanceURL
{
    //    return @"http://192.168.0.91:8088/lcsc";
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/lcsc"];
}

// 商城咨询
+(NSString *_Nonnull)getFinanceInfoURL
{
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/news/lcsc"];
}

//理财商城tradeURL
+(NSString *_Nonnull)getFinanceTradeURL{
    //    return @"http://192.168.0.91:8088/lcsc";
    return [ConfigURL.shareManager.tradeUrl stringByAppendingString:@"/lcsc"];
}

+ (NSString *_Nonnull)getMallTakeaway {
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/tainiuH5/mall_guide/mall_guide.html"];
}

//自选股 - 新闻、公告、研报
+ (NSString *)getHQOptionalNewsURL {
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/news/getSelfStockInfo"];
}

//自选股 - 独家
+ (NSString *)getHQOptionalNewsOnlyURL {
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/news/exclusiveList"];
}

//自选股 - 独家 -- 详情
+ (NSString *)getHQOptionalNewsOnlyDetailURL {
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/news/exclusiveInfo"];
}

// 行情 -- 决策 - HTML
+ (NSString *)getHQPolicyHtmlUrl {
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/tainiuH5/decision_making/index.html"];
}

// 新版分享 URL
+ (NSString *_Nonnull)getShareURL {
    return [ConfigURL.shareManager.infoUrl stringByAppendingString:@"/tainiuH5/lcfx/details/"];
}

//商城业务
+(NSString *_Nonnull)getFinanceYWURL
{
    //    return [@"https://dev-tnyw.tpyzq.com" stringByAppendingString:@"/lcsc"];//仅测试使用
    
    return [ConfigURL.shareManager.securityUrl_httpServer stringByAppendingString:@"/lcsc"];
}

@end
