//
//  InfoTagTableViewCell.h
//  PanGu
//
//  Created by 张琦 on 2017/7/20.
//  Copyright © 2017年 Security Pacific Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoTagTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UIView *singleView;

@property (nonatomic, assign) CGFloat cellHeight;

+(id)infoTagTableView:(UITableView *)tableView;

@end
