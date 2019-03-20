//
//  InformationMainViewController.h
//  PanGu
//
//  Created by 吴肖利 on 16/9/5.
//  Copyright © 2016年 Security Pacific Corporation. All rights reserved.
//

#import "BaseViewController.h"

//typedef enum : NSInteger {
//    J001 = 0,//要闻
//    J002 = 1,//直播
//    J003 = 2,//太平洋研究
//    J004 = 3,//红珊瑚资讯
//}JumpType;
@interface InformationMainViewController : BaseViewController

//判断是否从首页点击资讯按钮进来,从首页点击资讯按钮进来默认选中第一个,从点击资讯更多进来默认选中第二个
@property (nonatomic) BOOL isInfo;

@property (nonatomic, assign) BOOL isListInfo;

@property (nonatomic, copy) void(^readingDataSourceBlock)(NSArray *modelArray);

//@property (nonatomic, assign) JumpType jumpType;

@property (nonatomic, assign) NSInteger jumpType;


@end
