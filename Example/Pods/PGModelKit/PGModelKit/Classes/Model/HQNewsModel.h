//
//  HQNewsModel.h
//  PanGu
//
//  Created by 吴肖利 on 16/9/7.
//  Copyright © 2016年 Security Pacific Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HQNewsModel : NSObject
//信息的id
@property (nonatomic, copy) NSString *infoId;
//息标题
@property (nonatomic, copy) NSString *infoTitle;
//息简介
@property (nonatomic, copy) NSString *infoAbstract;
//键字
@property (nonatomic, copy) NSString *keyword;
//息作者
@property (nonatomic, copy) NSString *infoAuthor;
//息提交者的呢称
@property (nonatomic, copy) NSString *nickName;
//交者的用户ID
@property (nonatomic, copy) NSString *userId;
//息的来源
@property (nonatomic, copy) NSString *source;
//信息级别
@property (nonatomic, copy) NSString *level;
//紧急程度
@property (nonatomic, copy) NSString *urgency;
//信息状态，0 ：发布，1 ：待审，-1：打回
@property (nonatomic, copy) NSString *infoState;
//相关股票
@property (nonatomic, strong) NSArray *relatedStock;
//相关信息的id，多个之间用英文逗号分隔
@property (nonatomic, copy) NSString *relatedInfoId;
//Hot标志，0:无此标志；1:有此标志
@property (nonatomic, copy) NSString *hotFlag;
//置顶标志，0:无此标志；1:有此标志
@property (nonatomic, copy) NSString *topFlag;
//New标志0:无此标志；1:有此标志
@property (nonatomic, copy) NSString *newsFlag;
//自动转入信息在源表中的id
@property (nonatomic, copy) NSString *autoId;
//附件个数
@property (nonatomic, copy) NSString *optionNum;
//信息的原始时间
@property (nonatomic, copy) NSString *originalDate;
//信息的过期时间
//信息创建时间
//信息最后修改时间
//正文
@property (nonatomic, copy) NSString *text;

@property (nonatomic, copy) NSString *imageBase64;

@property (nonatomic, copy) NSString *imageUrl;


@end
