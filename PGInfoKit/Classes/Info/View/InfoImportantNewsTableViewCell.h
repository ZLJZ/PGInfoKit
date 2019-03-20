//
//  InfoImportantNewsTableViewCell.h
//  PanGu
//
//  Created by 张琦 on 2017/7/10.
//  Copyright © 2017年 Security Pacific Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoImportantNewsTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *leftImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *dateLabel;

+ (id)infoImportantNewsTableViewCell:(UITableView *)tableView;

@end
