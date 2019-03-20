//
//  InfoReadingTableViewCell.h
//  PanGu
//
//  Created by 张琦 on 2017/7/11.
//  Copyright © 2017年 Security Pacific Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoReadingTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView   *calendarImageView;

@property (nonatomic, strong) UILabel       *calendarTopLabel;

@property (nonatomic, strong) UILabel       *calendarBottomLabel;

@property (nonatomic, strong) UILabel       *dateLabel;

@property (nonatomic, strong) UILabel       *titleLabel;

@property (nonatomic, strong) UILabel       *contentLabel;

@property (nonatomic, strong) UIView        *bottomSingleView;

@property (nonatomic, assign) CGFloat        cellHeight;


+ (id)infoReadingTableViewCell:(UITableView *)tableView;

@end
