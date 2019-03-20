//
//  InfoReadingModel.h
//  PanGu
//
//  Created by 张琦 on 2017/7/24.
//  Copyright © 2017年 Security Pacific Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InvestmentAdviserModel.h"
@interface InfoReadingModel : NSObject

//信息id
@property (nonatomic, copy) NSString *newsno;
//标题
@property (nonatomic, copy) NSString *title;
//摘要
@property (nonatomic, copy) NSString *digest;
//日期
@property (nonatomic, copy) NSString *date;
//时间
@property (nonatomic, copy) NSString *time;
//头像
@property (nonatomic, copy) NSString *headPortrait;
//专家
@property (nonatomic, copy) NSString *professor;

@property (nonatomic, assign) BOOL isFirst;

@property (nonatomic, copy) NSString *source;

@property (nonatomic, assign) CGFloat height;
//上一篇下一篇的高度
@property (nonatomic, assign) CGFloat switchHeight;

@property (nonatomic, copy) NSString *author;// 港股研报用
@property (nonatomic, copy) NSString *ratingcode;// 港股研报用
@property (nonatomic, copy) NSString *ratingmsg;// 港股研报用
@property (nonatomic, copy) NSString *secuCode;// 港股研报用
@property (nonatomic, strong) UIColor *skinColor;// 港股研报用

@end
