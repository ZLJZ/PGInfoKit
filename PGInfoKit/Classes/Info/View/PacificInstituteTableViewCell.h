//
//  PacificInstituteTableViewCell.h
//  PanGu
//
//  Created by 吴肖利 on 2018/12/12.
//  Copyright © 2018 Security Pacific Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoHeaderDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface PacificInstituteTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *sourceLabel;

@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UIView *singleView;

- (void)configData:(InfoReadingModel *)model type:(InfoListType)type;

+ (id)initWithTableView:(UITableView *)tableView;

@end

@interface ProfessorHeaderView : UIView

/**
 初始化headView
 
 @param block 展开收起回调
 @return 自定义view
 */
- (instancetype)initWithEventBlock:(void(^)(CGFloat height))block;

- (void)configData:(InvestmentAdviserModel *)model;

@end

NS_ASSUME_NONNULL_END
