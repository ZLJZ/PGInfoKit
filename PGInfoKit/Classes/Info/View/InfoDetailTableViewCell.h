//
//  InfoDetailTableViewCell.h
//  PanGu
//
//  Created by 张琦 on 2017/7/19.
//  Copyright © 2017年 Security Pacific Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoHeaderDefine.h"
#import "InvestmentAdviserTableViewCell.h"

@class InfoOptionalRelatedView;
@interface InfoDetailTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UILabel *sourceLabel;

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, strong) UILabel *stateLabel;

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) InfoOptionalRelatedView *optionalRelatedView;

@property (nonatomic, strong) InvestmentAdviserView *investmentAdviserView;

+ (id)infoDetailTableView:(UITableView *)tabelView;

+ (id)infoDetailTableView:(UITableView *)tabelView reusableCellId:(NSString *)cellId;

- (void)configTitleWithModel:(InfoNewsDetailModel *)model font:(NSInteger)fontAdd;

- (void)configDetailWithModel:(InfoNewsDetailModel *)model font:(NSInteger)fontAdd type:(InfoDetailType)type;

- (void)configData:(InfoNewsDetailModel *)model fontAdd:(NSInteger)fontAdd type:(InfoDetailType)type;

- (void)configSwitchData:(InfoReadingModel *)model isPre:(BOOL)isPre;

@end

@interface InfoOptionalRelatedView : UIView

- (CGFloat)configData:(InfoNewsDetailModel *)model;

@end
