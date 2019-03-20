//
//  InfoDetailViewController.h
//  PanGu
//  太平洋研究/红珊瑚资讯
//  Created by 张琦 on 2017/8/30.
//  Copyright © 2017年 Security Pacific Corporation. All rights reserved.
//

#import "BaseViewController.h"
#import "InfoHeaderDefine.h"

@interface InfoDetailViewController : BaseViewController

- (instancetype)initWithType:(InfoDetailType)type newsNo:(NSString *)newsNo newsType:(NSString *)newsType  relatedStock:(NSString *)relatedStock;

- (instancetype)initWithType:(InfoDetailType)type newsNo:(NSString *)newsNo newsType:(NSString *)newsType;

- (instancetype)initWithType:(InfoDetailType)type newsNo:(NSString *)newsNo newsType:(NSString *)newsType curIdx:(NSInteger)curIdx listData:(NSArray *)listData;


@end
