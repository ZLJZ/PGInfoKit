//
//  PanGuAdModel.h
//  PanGu
//
//  Created by 祁继宇 on 2017/8/9.
//  Copyright © 2017年 Security Pacific Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PanGuAdModel : NSObject <NSCoding>

/*
 TN0000        我的账户
 TN0001        自选股
 TN0002        搜索股票
 TN0003        新股
 TN0004        资产分析
 TN0005        稳赢理财
 TN0006        开户
 TN0007        咨询
 TN0008        交易动态
 TN0009        股市回忆录
 TN0010        股票买入
 TN0011        股票卖出
 TN0012        股票持仓
 TN0013        OTC持仓
 TN0014        可取资金
 TN0015        银行转账
 TN0016        业务办理
 TN0017        自选股新闻
 TN0018        资金持仓
 TN0019        我的消息
 TN0020        股市月账单
 TN0021        热搜股票
 TN0022        国债逆回购
 */
@property (nonatomic, copy) NSString *jump_position;// 本地跳转的功能代码
@property (nonatomic, copy) NSString *jump_type;    // 0 不跳转, 仅作为展示, 1 跳转 HTML, 2 跳转本地功能
@property (nonatomic, copy) NSString *jump_url;     // 跳转 HTML 的 URL
@property (nonatomic, copy) NSString *show_url;     // 展示用的 URL

/*
 文档 '太平洋证券综合APP功能需求说明书 (投资日历及其理财商城)20181012-评审后'
 文档说明位置
 3.13.5.    理财广告管理（广告功能页面UI优化）
 理财广告属于对现有广告UI部分优化，同时，根据理财商城的UI设计，定义广告位；后台广告管理页面，按左侧列示字段，字段属性、名称不变。
 在现有广告跳转功能基础上，应支持跳转到资讯详情页面，传入信息ID；跳转到信息频道分类，传入频道ID；跳转到产品详情页面，传入产品代码；跳转到指定主题，传入方案ID，跳转到产品列表功能，包括：今日最热、智选理财、首发基金、理财日历。
 */
@property (nonatomic, copy) NSString *objectId;

@property (nonatomic, copy) NSString *is_text;// 区分是文字广告还是图片广告 1：是文字广告，2：是图片广告

@property (nonatomic, copy) NSString *showImageName;
@property (nonatomic, strong) NSData *showImageData;

@end
