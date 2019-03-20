//
//  InfoDataManager.m
//  PanGu
//
//  Created by 吴肖利 on 2018/12/24.
//  Copyright © 2018 Security Pacific Corporation. All rights reserved.
//

#import "InfoDataManager.h"
#import "PanGuMallHeader.h"

@implementation InfoDataManager

#pragma mark  请求产品公告接口
+ (void)requestInfoListDataByType:(InfoListType)type
                         prodCode:(NSString *)prodCode
                    responseBlock:(void(^)(EMPTY_TYPE emptyType,NSError *error,NSArray *data))responseBlock {
    NSMutableDictionary *param = @{}.mutableCopy;
    NSMutableDictionary *paramDic = @{}.mutableCopy;
    NSString *interfaceURL = @"";
    if (type == InfoListTypeCPGG) {
        [param setValue:@"000100010003" forKey:@"channelid"];
        [param setValue:prodCode forKey:@"code"];
        [paramDic setValue:@"900103" forKey:@"funcid"];
        [paramDic setValue:@"" forKey:@"token"];
        [paramDic setValue:param forKey:@"parms"];
        interfaceURL = [UrlManager getTwoRongBalance];
    }
    [NetworkRequest postRequestUrlString:[UrlManager getTwoRongBalance] params:paramDic success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:3 error:nil];
        NSInteger code = [dic[@"code"] integerValue];
        
        EMPTY_TYPE emptyType = EMPTY_TYPE_NO_DATA;
        
        if (code != 200) {
            if (responseBlock) responseBlock(EMPTY_TYPE_NETWORK_ERROR,nil,nil);
            return;
        }
        
        NSArray *arr = dic[@"data"];
        if (arr.count != 0) {
            NSMutableArray *dataArr = @[].mutableCopy;
            [arr enumerateObjectsUsingBlock:^(NSArray *  _Nonnull subArr, NSUInteger idx, BOOL * _Nonnull stop) {
                InfoReadingModel *model = [[InfoReadingModel alloc]init];
                model.newsno = [arr objectNAtIndex:0];
                model.title = [arr objectNAtIndex:1];
                model.source = [arr objectNAtIndex:7];
                model.time = [arr objectNAtIndex:19];
                [dataArr addObject:model];
            }];
            if (responseBlock) responseBlock(emptyType,nil,dataArr);
        } else {
            if (responseBlock) responseBlock(EMPTY_TYPE_NO_DATA,nil,nil);
        }
    } failure:^(NSError *error) {
        if (responseBlock) responseBlock(error.code == NetworkErrorCode ? EMPTY_TYPE_NO_NETWORK: EMPTY_TYPE_NETWORK_ERROR,error,nil);
    }];
}

#pragma mark  请求太平洋证券研究（研报）列表接口
+ (void)requestTPYResearchDataByPageNo:(NSUInteger)pageNo
                           pageSize:(NSInteger)pageSize
                           category:(NSString *)category
                      responseBlock:(void(^)(EMPTY_TYPE emptyType,NSError *error,NSArray *data))responseBlock {
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setValue:kString_Format(@"%ld",pageNo) forKey:@"PageNo"];
    [param setValue:kString_Format(@"%ld",pageSize) forKey:@"PageSize"];
    [param setValue:category forKey:@"sectioncode"];
    
    [NetworkRequest getRequestUrlString:[UrlManager getTPYResearchURL] params:param success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:3 error:nil];
        NSInteger code = [dic[@"code"] integerValue];
        
        EMPTY_TYPE emptyType = EMPTY_TYPE_NO_DATA;
        
        if (code != 200) {
            if (responseBlock) responseBlock(EMPTY_TYPE_NETWORK_ERROR,nil,nil);
            return;
        }
        
        NSArray *arr = dic[@"data"];
        if (arr.count != 0) {
            NSMutableArray *dataArr = @[].mutableCopy;
            [arr enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull subDic, NSUInteger idx, BOOL * _Nonnull stop) {
                InfoReadingModel *model = [[InfoReadingModel alloc]init];
                [model setValuesForKeysWithDictionary:subDic];
                [dataArr addObject:model];
            }];
            if (responseBlock) responseBlock(emptyType,nil,dataArr);
        } else {
            if (responseBlock) responseBlock(EMPTY_TYPE_NO_DATA,nil,nil);
        }
    } failure:^(NSError *error) {
        if (responseBlock) responseBlock(error.code == NetworkErrorCode ? EMPTY_TYPE_NO_NETWORK: EMPTY_TYPE_NETWORK_ERROR,error,nil);
    }];
}

#pragma mark  请求红珊瑚投顾观点列表接口
+ (void)requestRedCoralDataByPageNo:(NSUInteger)pageNo
                           pageSize:(NSInteger)pageSize
                      responseBlock:(void(^)(EMPTY_TYPE emptyType,NSError *error,NSArray *data))responseBlock {
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setValue:kString_Format(@"%ld",pageNo) forKey:@"PageNo"];
    [param setValue:kString_Format(@"%ld",pageSize) forKey:@"PageSize"];
    
    [NetworkRequest getRequestUrlString:[UrlManager getRedCoralURL] params:param success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:3 error:nil];
        NSInteger code = [dic[@"code"] integerValue];
        
        EMPTY_TYPE emptyType = EMPTY_TYPE_NO_DATA;
        
        if (code != 200) {
            if (responseBlock) responseBlock(EMPTY_TYPE_NETWORK_ERROR,nil,nil);
            return;
        }
        
        NSArray *arr = dic[@"data"];
        if (arr.count != 0) {
            NSMutableArray *dataArr = @[].mutableCopy;
            [arr enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull subDic, NSUInteger idx, BOOL * _Nonnull stop) {
                InfoReadingModel *model = [[InfoReadingModel alloc]init];
                [model setValuesForKeysWithDictionary:subDic];
                [dataArr addObject:model];
            }];
            if (responseBlock) responseBlock(emptyType,nil,dataArr);
        } else {
            if (responseBlock) responseBlock(EMPTY_TYPE_NO_DATA,nil,nil);
        }
    } failure:^(NSError *error) {
        if (responseBlock) responseBlock(error.code == NetworkErrorCode ? EMPTY_TYPE_NO_NETWORK: EMPTY_TYPE_NETWORK_ERROR,error,nil);
    }];
}

#pragma mark  请求广告接口
//+ (void)requestAdDataWithPosition:(NSString *)position
//                              key:(NSString *)key
//                    responseBlock:(void(^)(NSArray *data,NSArray *urlData))responseBlock {
//    [PanGuMallRequestManager requestAdDataWithPosition:position keys:@[key] responseBlock:^(NSDictionary<NSString *,NSArray<PanGuAdModel *> *> * _Nonnull responseObj, NSError * _Nonnull error) {
//        NSMutableArray *tmpData = @[].mutableCopy;
//        NSMutableArray *tmpUrlData = @[].mutableCopy;
//        if (error) {
//            responseBlock(tmpData,tmpUrlData);
//            return;
//        }
//        if ([responseObj.allKeys containsObject:key]) {
//            tmpData = responseObj[kAdPositionResponseTop].mutableCopy;
//            [tmpData enumerateObjectsUsingBlock:^(PanGuAdModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                [tmpUrlData addObject:obj.show_url];
//            }];
//        }
//        responseBlock(tmpData,tmpUrlData);
//    }];
//}

#pragma mark  请求新闻详情页接口
+ (void)requestInfoDetailData:(InfoDetailType)type
                       newsNo:(NSString *)newsNo
                     newsType:(NSString *)newsType
                responseBlock:(void(^)(EMPTY_TYPE emptyType,NSError *error,InfoNewsDetailModel *model))responseBlock {
    NSMutableDictionary *param = @{}.mutableCopy;
    NSString *interfaceURL;
    if (type == InfoDetailTypeMall ||
        type == InfoDetailTypeMallDigest) {
        
        [param setValue:newsNo forKey:@"newsId"];
        interfaceURL = [[UrlManager getFinanceInfoURL] stringByAppendingString:@"/info/queryFundDetail"];
        
    } else if (type == InfoDetailTypeDefault ||
               type == InfoDetailTypeOrdinary) {
        
        [param setValue:newsNo forKey:@"newsno"];
        [param setValue:newsType forKey:@"type"];
        interfaceURL = [UrlManager getInfoDetailURL];
        
    } else if (type == InfoDetailTypePacificInstitute) {
        
        [param setValue:newsNo forKey:@"id"];
        interfaceURL = [UrlManager getTPYResearchInfoURL];
        
    } else if (type == InfoDetailTypeInvestment) {
        
        [param setValue:newsNo forKey:@"id"];
        interfaceURL = [UrlManager getRedCoralInfoURL];
        
    } else if (type == InfoDetailTypeStockNewsDetail) {
        
        [param setValue:newsNo forKey:@"newsno"];
        [param setValue:newsType forKey:@"type"];//4
        interfaceURL = [UrlManager getMergeNewsDetailURL];
        
    }else if (type == InfoDetailTypeOptionalOnly) {
        [param setValue:newsNo forKey:@"newsno"];
        interfaceURL = [UrlManager getHQOptionalNewsOnlyDetailURL];
    }
    
    P_Log(@"%@",newsNo);
    [NetworkRequest getRequestUrlString:interfaceURL params:param success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:3 error:nil];
        NSInteger code = [dic[@"code"] integerValue];
        
        EMPTY_TYPE emptyType = EMPTY_TYPE_NO_DATA;

        if (code != 200) {
            if (responseBlock) responseBlock(EMPTY_TYPE_NETWORK_ERROR,nil,nil);
            return;
        }
        
        NSArray *arr = dic[@"data"];
        if (arr.count != 0) {
            
            InfoNewsDetailModel *model = [[InfoNewsDetailModel alloc]init];
            [model setValuesForKeysWithDictionary:arr[0]];
            NSMutableArray *attachmentArr = @[].mutableCopy;
            for (NSDictionary *subDic in model.atachment) {
                InfoAttachmentModel *attachmentModel = [[InfoAttachmentModel alloc]init];
                [attachmentModel setValuesForKeysWithDictionary:subDic];
                [attachmentArr addObject:attachmentModel];
            }
            model.atachment = attachmentArr;
            
            model.content = [model.content stringByReplacingOccurrencesOfString:@"\n\n" withString:@"<br>"];
            model.content = [model.content stringByReplacingOccurrencesOfString:@"\n\r\n" withString:@"<br>"];
            model.content = [model.content stringByReplacingOccurrencesOfString:@"\n \n" withString:@"<br>"];
            
            model.content = kString_Format(@"<div style=\"text-align:justify; text-justify:inter-ideograph;\">%@",model.content);
            if (responseBlock) responseBlock(emptyType,nil,model);
        } else {
            if (responseBlock) responseBlock(EMPTY_TYPE_NO_DATA,nil,nil);
        }
    } failure:^(NSError *error) {
        if (responseBlock) responseBlock(error.code == NetworkErrorCode ? EMPTY_TYPE_NO_NETWORK: EMPTY_TYPE_NETWORK_ERROR,error,nil);
    }];
}

@end
