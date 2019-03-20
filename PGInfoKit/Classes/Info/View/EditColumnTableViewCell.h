//
//  EditColumnTableViewCell.h
//  PanGu
//
//  Created by 吴肖利 on 16/9/18.
//  Copyright © 2016年 Security Pacific Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditColumnTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *leftImageView;

@property (nonatomic, strong) UIButton *leftImageButton;

@property (nonatomic, strong) UILabel *topLabel;

@property (nonatomic, strong) UILabel *bottomLabel;

//@property (nonatomic, strong) UIImageView *rightImageView;

@property (nonatomic, strong) UIButton *rightButton;

+ (id)editColumnTableViewCell:(UITableView *)tableView;

@end
