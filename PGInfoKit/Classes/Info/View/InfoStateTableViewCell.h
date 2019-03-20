//
//  InfoStateTableViewCell.h
//  PanGu
//
//  Created by 张琦 on 2017/7/26.
//  Copyright © 2017年 Security Pacific Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoHeaderDefine.h"
@class InfoStateSeparatorView;
@interface InfoStateTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *sourceLabel;

@property (nonatomic, strong) UILabel *stateLabel;

@property (nonatomic, assign) CGFloat cellHeight;

- (void)configData:(InfoNewsDetailModel *)model type:(InfoDetailType)type;

+ (id)infoStateTableView:(UITableView *)tableView;

@end
