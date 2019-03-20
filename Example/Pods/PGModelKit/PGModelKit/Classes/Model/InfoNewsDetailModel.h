//
//  InfoNewsDetailModel.h
//  PanGu
//
//  Created by 张琦 on 2017/7/24.
//  Copyright © 2017年 Security Pacific Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InfoNewsDetailModel : NSObject

//信息id
@property (nonatomic, copy) NSString *newsno;
//标题
@property (nonatomic, copy) NSString *title;
//内容
@property (nonatomic, copy) NSString *content;
//时间
@property (nonatomic, copy) NSString *time;
//来源
@property (nonatomic, copy) NSString *source;
//声明
@property (nonatomic, copy) NSString *statement;
//附件
@property (nonatomic, strong) NSArray *atachment;
//文章摘要
@property (nonatomic, copy) NSString *digest;
//自选相关个股
@property (nonatomic, copy) NSString *relatedStock;


//声明高度
@property (nonatomic, assign) CGFloat stateHeight;
//头部标题高度
@property (nonatomic, assign) CGFloat titleHeight;
//内容高度
@property (nonatomic, assign) CGFloat contentHeight;

@end

@interface InfoAttachmentModel : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) CGFloat height;


@end
