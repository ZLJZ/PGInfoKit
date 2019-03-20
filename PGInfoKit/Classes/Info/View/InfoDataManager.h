//
//  InfoDataManager.h
//  PanGu
//
//  Created by 吴肖利 on 2018/12/24.
//  Copyright © 2018 Security Pacific Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InfoHeaderDefine.h"
#import "PGInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface InfoDataManager : NSObject


#pragma mark  请求产品公告接口
+ (void)requestInfoListDataByType:(InfoListType)type
                         prodCode:(NSString *)prodCode
                    responseBlock:(void(^)(EMPTY_TYPE emptyType,NSError *error,NSArray *data))responseBlock;

#pragma mark  请求太平洋证券研究（研报）列表接口
+ (void)requestTPYResearchDataByPageNo:(NSUInteger)pageNo
                              pageSize:(NSInteger)pageSize
                              category:(NSString *)category
                         responseBlock:(void(^)(EMPTY_TYPE emptyType,NSError *error,NSArray *data))responseBlock;

#pragma mark  请求红珊瑚投顾观点列表接口
+ (void)requestRedCoralDataByPageNo:(NSUInteger)pageNo
                           pageSize:(NSInteger)pageSize
                      responseBlock:(void(^)(EMPTY_TYPE emptyType,NSError *error,NSArray *data))responseBlock;

#pragma mark  请求广告接口
+ (void)requestAdDataWithPosition:(NSString *)position
                              key:(NSString *)key
                    responseBlock:(void(^)(NSArray *data,NSArray *urlData))responseBlock;

#pragma mark  请求新闻详情页接口
+ (void)requestInfoDetailData:(InfoDetailType)type
                       newsNo:(NSString *)newsNo
                     newsType:(NSString *)newsType
                responseBlock:(void(^)(EMPTY_TYPE emptyType,NSError *error,InfoNewsDetailModel *model))responseBlock;

@end

NS_ASSUME_NONNULL_END
