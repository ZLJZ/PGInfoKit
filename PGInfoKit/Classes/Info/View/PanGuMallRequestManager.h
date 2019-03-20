//
//  PanGuMallRequestManager.h
//  PanGu
//
//  Created by 祁继宇 on 2018/10/12.
//  Copyright © 2018 Security Pacific Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PanGuMallHeader.h"
#import "PanGuAdModel.h"
#import "PGInfo.h"

NS_ASSUME_NONNULL_BEGIN

static NSString *const kAdPositionResponseTop = @"AdPositionResponseTop";       // 广告展示位置的 key
static NSString *const kAdPositionResponseMiddle = @"AdPositionResponseMiddle"; // 广告展示位置的 key

typedef void(^MallResquestBlock)(NSError *_Nullable error, NSArray *dataArr, EMPTY_TYPE emptyType);
typedef void(^MallFundFilterResquestBlock)(NSError *_Nullable error, NSArray *dataArr, NSInteger totalCount, EMPTY_TYPE emptyType);
typedef void(^MallFocusResquestBlock)(NSError *_Nullable error, BOOL flag, NSString *message);

@class InfoNewsDetailModel;
@interface PanGuMallRequestManager : NSObject

/**
 根据方案  获取列表数据
 
 @param financeType     理财类型
 @param otherValue      主题投资为栏目id、其它为排序值。没有则传空
 @param pageSize        每页请求数据条数
 @param pageIndex       第几页数据
 @param resquestBlock   请求回调
 */
+ (void)requestDataById:(PanGuFinanceType)financeType
             otherValue:(NSString *)otherValue
               pageSize:(NSInteger)pageSize
              pageIndex:(NSInteger)pageIndex
          resquestBlock:(MallResquestBlock)resquestBlock;



/**
 根据方案id获取产品列表（获取预约结果页列表）

 @param schemeId 方案id
 @param pageNum 当前页
 @param pageSize 请求条数
 @param resquestBlock 请求回调
 */
+ (void)requestDataBySchemeId:(NSString *)schemeId
                      pageNum:(NSInteger)pageNum
                     pageSize:(NSInteger)pageSize
                 requestBlock:(MallResquestBlock)resquestBlock;
/**
 基金排行、基金筛选 请求

 @param financeType     理财类型
 @param sortValue       排序值
 @param paramsArr       调用 [PanGuMallRequestManager getFilterParmasWithArray:] 获取参数数组
 @param pageSize        每页请求数据条数
 @param pageIndex       第几页数据
 @param resquestBlock   请求回调
 */
+ (void)requestFundSortDataByType:(PanGuFinanceType)financeType
                        sortValue:(NSString *)sortValue
                        paramsArr:(NSArray *)paramsArr
                         pageSize:(NSInteger)pageSize
                        pageIndex:(NSInteger)pageIndex
                    resquestBlock:(MallFundFilterResquestBlock)resquestBlock;

/**
 理财首页合并的接口

 @param responseBlock 回调
 */
+ (void)requestHomeDataResponseBlock:(MallResquestBlock)resquestBlock;

/**
 主题方案集合查询

 @param columnId      主题栏目id
 @param pageSize      显示数目
 @param pageIndex     当前页
 @param resquestBlock 请求回调
 */
+ (void)requestTopicInvestById:(NSString *)columnId
                      pageSize:(NSInteger)pageSize
                     pageIndex:(NSInteger)pageIndex
                 resquestBlock:(MallResquestBlock)resquestBlock;



/**
 获取关注列表
 
 @param focusType     关注对象的类型（1：产品，2：主题）
 @param resquestBlock 请求回调
 */
+ (void)getFocusListDataFocusType:(PanGuMallFocusType)focusType
                    resquestBlock:(MallResquestBlock)resquestBlock;

/**
 添加关注
 
 @param focusType       关注对象的类型（1：产品，2：主题）
 @param focusId         要关注的产品 id
 @param resquestBlock   请求回调
 */
+ (void)addFocusType:(PanGuMallFocusType)focusType
             focusId:(NSString *)focusId
       resquestBlock:(MallFocusResquestBlock)resquestBlock;

/**
 移除关注
 
 @param focusIds      要移除的产品 id 合集(以逗号分隔)
 @param focusType     关注对象的类型（1：产品，2：主题）
 @param resquestBlock 请求回调
 */
+ (void)removeFocusType:(PanGuMallFocusType)focusType
               focusIds:(NSString *)focusIds
          resquestBlock:(MallFocusResquestBlock)resquestBlock;

/**
 获取广告数据

 @param position 广告位置
 
 理财商城首页顶部：   1个  L1N1    入参: L1
 理财商城首页底部：   1个  L1N2    入参: L1
 理财商城银行理财：   1个  L2N1    入参: L2
 理财商城国债理财：   1个  L3N1    入参: L3
 理财商城太平洋优选:  1个  L4N1    入参: L4
 理财商城活期理财：   1个  L5N1    入参: L5
 理财商城定投专区：   1个  L6N1    入参: L6
 理财商城基金首页：   1个  L7N2    入参: L7
 搜索页面热搜数据：   1个  L8N1    入参: L8
 投教知识点(小贴士)： 1个  L9N1    入参: L9
 
 @param keys 以 @[kAdPositionResponseTop 、kAdPositionResponseMiddle] 类似结构传入
 @param responseBlock 回调, 字典里面以 kAdPositionResponseTop 、kAdPositionResponseMiddle 为 key, 里面为 PanGuAdModel 数组
 */
+ (void)requestAdDataWithPosition:(NSString *)position
                             keys:(NSArray *)keys
                    responseBlock:(void(^)(NSDictionary<NSString *, NSArray<PanGuAdModel *> *> *responseObj, NSError *error))responseBlock;

/**
 搜索接口

 @param code  股票代码,股票名称首字母,模糊查询（长度<=6）
 @param start 起始的记录数，从0开始
 @param type  返回结果的数量 (取值范围1-100)
 @param responseBlock 0全部 1沪深 2港股 3理财 4基金
 */
+ (void)requestStockSearchWithCode:(NSString *)code
                             start:(NSInteger)start
                              type:(PanGuSearchListType)type
                     responseBlock:(void(^)(NSArray *responseObj, EMPTY_TYPE emptyType, NSError *error))responseBlock;

/**
 理财头条信息详情查询

 @param NewsId 新闻id
 @param responseBlock 回调
 */
+ (void)requestTopicInstructionDataNewsId:(NSString *)newsId
                            responseBlock:(void(^)(NSError *_Nullable error, InfoNewsDetailModel *_Nullable model, EMPTY_TYPE emptyType))responseBlock;

/**
 获取基金筛选参数数组

 @param array @[@[],@[],@[]]
 @return @[@"",@"",@""]
 */
+ (NSArray *)getFilterParmasWithArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
