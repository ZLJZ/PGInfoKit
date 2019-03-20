//
//  AccessoryTableViewCell.h
//  PanGu
//
//  Created by 张琦 on 2017/8/30.
//  Copyright © 2017年 Security Pacific Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoNewsDetailModel.h"

@interface AccessoryTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *accessoryLabel;

@property (nonatomic, strong) UIView *singleView;

- (void)configData:(InfoAttachmentModel *)model;

+ (id)accessoryTableViewCell:(UITableView *)tableView;

@end
