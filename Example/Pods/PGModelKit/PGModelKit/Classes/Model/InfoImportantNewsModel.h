//
//  InfoImportantNewsModel.h
//  PanGu
//
//  Created by 张琦 on 2017/7/24.
//  Copyright © 2017年 Security Pacific Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InfoImportantNewsModel : NSObject<NSCoding>

//信息id
@property (nonatomic, copy) NSString *newsno;
//标题
@property (nonatomic, copy) NSString *title;
//摘要
@property (nonatomic, copy) NSString *digest;
//时间
@property (nonatomic, copy) NSString *time;
//图片地址
@property (nonatomic, copy) NSString *image;

@end
