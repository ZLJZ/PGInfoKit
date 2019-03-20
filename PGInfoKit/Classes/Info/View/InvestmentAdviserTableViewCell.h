//
//  InvestmentAdviserTableViewCell.h
//  PanGu
//
//  Created by 吴肖利 on 2018/12/13.
//  Copyright © 2018 Security Pacific Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoHeaderDefine.h"

NS_ASSUME_NONNULL_BEGIN
@class InvestmentAdviserView;
@interface InvestmentAdviserTableViewCell : UITableViewCell

@property (nonatomic, strong) InvestmentAdviserView *investmentAdviserView;

+ (id)initWithTableView:(UITableView *)tableView;

@end

@interface InvestmentAdviserView : UIView

- (void)configData:(InvestmentAdviserModel *)model;

@end

NS_ASSUME_NONNULL_END
