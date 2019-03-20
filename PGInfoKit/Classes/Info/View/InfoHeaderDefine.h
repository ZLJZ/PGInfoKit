//
//  InfoHeaderDefine.h
//  PanGu
//  资讯
//  Created by 吴肖利 on 2018/12/13.
//  Copyright © 2018 Security Pacific Corporation. All rights reserved.
//

#ifndef InfoHeaderDefine_h
#define InfoHeaderDefine_h

//资讯详情页类型
typedef NS_ENUM(NSInteger, InfoDetailType) {
    InfoDetailTypeDefault,//红珊瑚
    InfoDetailTypeMall,//理财商城头条详情
    InfoDetailTypeMallDigest,//理财头条简介
    InfoDetailTypePacificInstitute,//太平洋研究
    InfoDetailTypeInvestment,//投顾详情
    InfoDetailTypeOrdinary,//普通资讯详情
    InfoDetailTypeStockNewsDetail,//个股新闻
    InfoDetailTypeOptionalOnly,//自选股 -- 独家
};

typedef NS_ENUM(NSInteger, PacificInstituteType) {
    PacificInstituteTypeInfoNest,//资讯嵌套
    PacificInstituteTypeSudoku,//九宫格入口
};

//资讯单列表类型
typedef NS_ENUM(NSInteger, InfoListType) {
    InfoListTypeCPGG,//产品公告
    InfoListTypePacificInstitute,//太平洋研究
    InfoListTypeInvestmentProfessor,//投顾专家
};


#import "InfoNewsDetailModel.h"
#import "MyAttributedStringBuilder.h"
#import "InfoCalculate.h"
#import "ParamsRequest.h"
#import "NetworkRequest.h"
#import "WXLLabel.h"
#import "EditColumnModel.h"
#import "InfoImportantNewsModel.h"
#import "InfoNewsDetailModel.h"
#import "InfoReadingModel.h"
#import "InvestmentAdviserModel.h"
#import "InfoDataManager.h"

#endif /* InfoHeaderDefine_h */
