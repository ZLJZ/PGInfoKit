//
//  InvestmentAdviserModel.h
//  PanGu
//
//  Created by 吴肖利 on 2018/12/14.
//  Copyright © 2018 Security Pacific Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface InvestmentAdviserModel : NSObject

@property (nonatomic, copy) NSString *headPortrait;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *style;

@property (nonatomic, copy) NSString *cer;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign) BOOL isUnfold;



@end

@interface InvestmentCategoryModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) BOOL isSelected;


@end

NS_ASSUME_NONNULL_END
